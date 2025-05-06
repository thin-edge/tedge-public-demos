# Release Demo - 2025-05-07 - 1.5.0

## Agenda

### 1. Introduction of new release 1.5.0

* [Where to find the Changelog](https://github.com/thin-edge/thin-edge.io/releases)
* Release Artifacts
    * [Linux artifacts](https://cloudsmith.io/~thinedge/repos/) (e.g. deb, rpm, apk, tarball packages)
    * [Container images](https://github.com/thin-edge/thin-edge.io/pkgs/container/tedge)

---

### 2. Cumulocity Certificate Authority Support - Didier / Rina

* Easy device enrollment (using device specific one-time passwords)
* Automatic certificate renewal service (currently only for SystemD but a cron job could also be manually configured)
* Seamless upgrade path from self-signed certificates to a Cumulocity CA issued certificate (migrated automatically by the renewal service)

**Demo**

1. Manual registration via UI and tedge cli
2. Registering a device using `c8y tedge bootstrap`
3. Show upgrade path from self-signed certificate to c8y signed

---

### 3. Entity Store HTTP API  - Albin

* Register/Deregister
* List and query existing entities
* Update digital twin information on child devices and services (e.g. similar to the `/twin` MQTT topic)

**Demo**

* What tasks are easier to do with HTTP instead of MQTT
    * Deleting an entire entity tree => delete child and services of that child
    * Changing entity's parent (example of misconfiguration)

* Example of a UI to use the Entity Store API

---

### 4. Hardware Security Module (HSM) support via PKCS#11 (cryptoki) Interface - Reuben

Support for accessing the device's private key stored in secure storage via the [PKCS#11](https://docs.oasis-open.org/pkcs11/pkcs11-base/v2.40/os/pkcs11-base-v2.40-os.html) interface (also called cryptoki). By storing private keys in a HSM it prevents the private key from being exposed or stolen by attackers.

* USB based devices like NitroKey HSM 2, Yubikey 5
* TPM 2.0 (Trusted Platform Module)
* ARM TrustZone (via OP-TEE)

**Demo**

* Example integration into Rugix and Yocto layers
* Integration with other tooling (e.g. gnutls's certtool)

---

### 5. HTTP Proxy support using CONNECT Tunneling - Reuben

thin-edge.io can now be used behind a HTTP/HTTPS proxy (provided the proxy supports [HTTP Tunneling](https://en.wikipedia.org/wiki/HTTP_tunnel).

Note: The proxy support will require you to use the built-in bridge mode where the tedge-mapper connects to the cloud instead of mosquitto, however the built-in bridge will be the future default.

**Demo**

* install and configure thin-edge.io on a device behind a HTTP proxy


---

### 6. Other note-worthy changes

* support shell completions in `tedge` cli - [#3332](https://github.com/thin-edge/thin-edge.io/pull/3332)

* Control whether child devices should appear in the Cumulocity All Devices list - [#3560](https://github.com/thin-edge/thin-edge.io/pull/3560)

* add MQTT keepalive_interval config to allow custom value per bridge - [#3365](https://github.com/thin-edge/thin-edge.io/pull/3365)


* For Cumulocity SmartREST 1.0 / Basic Auth users:
    * Support setting device.id from the tedge.toml file

* `tedge mqtt sub` improvements
    * Subscribe to retained messages only
    * Only subscribe for a given duration, or a given number of messages

* Rugix image changes


