# Demo - 2025-02-12

## Agenda

### 1. New Entity Store REST API  - Albin

* Register/Deregister devices, child-devices and services
* Query existing devices
* Blocking API - only return once it has been registered simplifying startup logic for child entities (child-devices/services)

### 2. New command: tedge http - Didier

* Easier usage of both tedge API endpoint and Cumulocity local proxy
* Don't need to worry about tedge configuration
    * Auto detection of client x509 certificate settings
    * Auto detection of ports

### 3. CLI completions - Reuben

* Easier discovery of cli usage (especially for `tedge config` commands)
* Supports bash/zsh/fish
