# Deploying containers with thin-edge.io

## Setup

1. Create the software artifacts and device profile

    ```sh
    ./setup-c8y.sh
    ```

## Demo

1. Start a demo container

    ```sh
    c8y tedge demo start conner001
    ```

2. Create Remote Access passthrough configurations for node-red and portainer-ce

    ```sh
    c8y remoteaccess configurations create-passthrough --device conner001 --name native-ssh --port 22 -f
    c8y remoteaccess configurations create-passthrough --device conner001 --name http:node-red --port 1880 -f
    c8y remoteaccess configurations create-passthrough --device conner001 --name https:portainer-ce --port 9443 -f
    ```

3. Deploy the device profile called "detection-example-demo" in the Device Management UI

4. Install portainer-ce using the Software tab in the Device Management UI

## Cleanup

Stop the demo container and delete the device from Cumulocity.

```sh
c8y tedge demo stop conner001
c8y identity get --name conner001 --silentStatusCodes 404 | c8y devices delete --cascade
```
