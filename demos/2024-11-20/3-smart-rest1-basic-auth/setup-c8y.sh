#!/usr/bin/env bash
set -e

# Don't prompt
export CI=true

c8y_bulk_registration() {
    EXTERNAL_ID="$1"
    DEVICE_TYPE="thin-edge.io"
    if [ $# -gt 1 ]; then
        DEVICE_TYPE="$2"
    fi

    REG_FILE="/tmp/${EXTERNAL_ID}.csv"

    CREDENTIALS=$(c8y template execute --template '_.Char(13) + "&" + _.Digit(2)')

    cat << EOT > "$REG_FILE"
"ID","CREDENTIALS","AUTH_TYPE","TYPE","NAME","com_cumulocity_model_Agent.active"
"$EXTERNAL_ID","$CREDENTIALS",BASIC,"$DEVICE_TYPE","$EXTERNAL_ID",true
EOT

    echo "Manually registering device: $EXTERNAL_ID (type=$DEVICE_TYPE)" >&2
    if ! c8y api POST devicecontrol/bulkNewDeviceRequests --file "$REG_FILE" --force; then
        echo "Warning: Failed to manually register device (via c8y bulk registration API): $EXTERNAL_ID" >&2
        exit 1
    fi

    echo
    echo
    echo "Run the following script on the device"
    echo echo "------------------- begin script ----------------------------"
    echo

    cat <<EOT
tedge cert create --device-id "${EXTERNAL_ID}" 2>/dev/null
tedge config set c8y.url "$C8Y_DOMAIN"
tedge config set c8y.auth_method basic
cat <<EOL > /etc/tedge/credentials.toml
[c8y]
username = "$C8Y_TENANT/device_${EXTERNAL_ID}"
password = "$CREDENTIALS"
EOL
EOT
    echo
    echo echo "------------------- end script ----------------------------"
    rm -f "$REG_FILE"
}


DEVICE_ID="legacyagent001"

if [ $# -gt 0 ]; then
    DEVICE_ID="$1"
fi

c8y_bulk_registration "$DEVICE_ID"
