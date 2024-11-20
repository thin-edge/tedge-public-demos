#!/usr/bin/env bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Don't prompt
export CI=true

upsert_software() {
    software_name="$1"
    software_type="$2"
    version="$3"

    file_or_url="$4"

    optional_args=()

    if [ -f "$file_or_url" ]; then
        # is file
        optional_args+=(
            --file
            "$file_or_url"
        )
    else
        # is url
        optional_args+=(
            --url
            "$file_or_url"
        )
    fi

    SOFTWARE_ID=$(
        c8y software get --id "$software_name" --silentStatusCodes 404 --select id -o csv ||
            c8y software create --name "$software_name" --softwareType "$software_type" --select id -o csv
    )

    c8y software versions get --software "$SOFTWARE_ID" --id "$version" --silentStatusCodes 404 ||
        c8y software versions create --software "$SOFTWARE_ID" --version "$version" "${optional_args[@]}"

}

echo "Adding software repository items (idempotent)"
upsert_software "tedge-nodered-plugin-ng" "apt" "latest" " "
upsert_software "nodered" "container-group" "4.0.3-22-minimal-podman" "$SCRIPT_DIR/docker-compose.nodered-podman.yaml"
upsert_software "nodered" "container-group" "4.0.3-22-minimal-docker" "$SCRIPT_DIR/docker-compose.nodered-docker.yaml"
upsert_software "portainer-ce" "container-group" "2.21.4-alpine" "$SCRIPT_DIR/docker-compose.portainer.yaml"
upsert_software "nodered-demo-next" "nodered-flows" "1.0.0" "$SCRIPT_DIR/flows.json"


echo "Create/update device Profile"
DEVICE_PROFILE_CONTENTS=$(cat <<EOT
{
    "c8y_DeviceProfile": {
        "configuration": [],
        "software": [
            {
                "action": "install",
                "name": "tedge-nodered-plugin-ng",
                "softwareType": "apt",
                "url": " ",
                "version": "latest"
            },
            {
                "action": "install",
                "name": "nodered",
                "softwareType": "container-group",
                "url": "$(c8y software versions get --software nodered --id 4.0.3-22-minimal-podman --select c8y_Software.url -o csv)",
                "version": "4.0.3-22-minimal-podman"
            },
            {
                "action": "install",
                "name": "nodered-demo-next",
                "softwareType": "nodered-flows",
                "url": "$(c8y software versions get --software nodered-demo-next --id 1.0.0 --select c8y_Software.url -o csv)",
                "version": " 1.0.0"
            }
        ]
    },
    "c8y_Filter": {}
}
EOT
)


DEVICE_PROFILE_ID=$(
    c8y deviceprofiles get --id detection-example-demo --silentStatusCodes 404 --select id -o csv ||
    c8y deviceprofiles create --name detection-example-demo --select id -o csv
)
echo "$DEVICE_PROFILE_ID" | c8y deviceprofiles update --template "$DEVICE_PROFILE_CONTENTS"
