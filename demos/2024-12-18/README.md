# Release Demo 1.4.0 - 2024-12-18

## Agenda

### 1. Overview of new features with thin-edge.io 1.4.0

Other great improvements:

* Workflows are automatically reloaded at runtime (you don't need to restart the tedge-agent anymore)

* Support SmartREST 1.0 by using Cumulocity Basic Auth device credentials

* UX improvements to the `tedge connect` command

* Filtering support for `tedge config list`

* Robustness improvements
    * Improved validation checks on messages and loading workflows
    * More verbose error messages
    * Service shutdown handling is more responsive

### 2. Cloud Profiles

* Connect a single device to multiple Cumulocity instances

* Support moving the device to different tenants
    * Connect to Tenant 1 => Connect to Tenant 2 => Disconnect from Tenant 1

* Customers can connect and push their data to their own tenant whilst a second Cumulocity connection can be used to keep the device up-to-date with the latest security patches / functionality.

### 3. Upload files to Cumulocity with a single command

* Create events and upload a binary to them in a single CLI command

### 4. Using workflows in custom operation handlers

* Use thin-edge.io workflows for robust execution of custom operations
