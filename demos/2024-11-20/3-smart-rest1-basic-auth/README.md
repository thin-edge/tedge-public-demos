# Supporting for SmartREST 1.0 and Basic Authentication

## Demo

1. Start a demo container

    ```sh
    c8y tedge demo start legacyagent001 --skip-bootstrap
    ```

2. Create device credentials and register it in Cumulocity

    ```sh
    ./setup-c8y.sh legacyagent001
    ```

3. Open the shell to the demo container

    ```sh
    c8y tedge demo shell legacyagent001
    ```

4. Update to the main channel

    ```sh
    wget -O - thin-edge.io/install.sh | sh -s -- --channel main
    ```

5. Execute the one-liner presented in the previous step

6. Connect to Cumulocity

    ```sh
    tedge connect c8y
    ```

## Cleanup

Stop the demo container and delete the device from Cumulocity.

```sh
c8y tedge demo stop legacyagent001
c8y identity get --name legacyagent001 --silentStatusCodes 404 | c8y devices delete --cascade -f
c8y users get --id device_legacyagent001 --silentStatusCodes 404 | c8y users delete -f
```
