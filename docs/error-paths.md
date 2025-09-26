# Error paths

Possible error paths in DTS and how to trigger them

## UI/User Experience

- UI refresh loop
    * press Enter multiple times (or keep it pressed) in main UI
    * relevant code:
      [dts.sh#L44](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/scripts/dts.sh#L44)
- multiple UI refreshes per one key
    * press arrow key in main UI
    * relevant code:
      [dts.sh#L44](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/scripts/dts.sh#L44)
- strings don't fit in UI border
    * check on platform/firmware with very long `dmidecode` strings
    * or enter DTS shell and use these commands:

        ```sh
        export DTS_TESTING=true
        export TEST_SYSTEM_VENDOR="very long system vendor string that won't fit"
        dts-boot
        ```

    * relevant code:
      [show_hardsoft_inf](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/include/dts-functions.sh#L1343)

- `RAM` hardware information has different indentation
    * start DTS and compare `HARDWARE INFORMATION` entries
    * relevant code:
      [show_ram_inf](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/include/dts-functions.sh#L1329)
- wrong answer for user choice
    * enter value outside of allowed ones
    * enter value with spaces and other special characters
    * enter non-numeric value if choice expects number
    * press enter without writing anything (if there's no default value used)
    * relevant code: Check all `read` command usages
- stop workflow
    * Answer negatively when asked if everything is ok/you want to continue
    * relevant code:
        - [force_me_update](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/include/dts-functions.sh#L1016)
        - [display_warning specification](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/scripts/dasharo-deploy.sh#L462)
        - [display_warning
          deploy](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/scripts/dasharo-deploy.sh#L508)
        - [ask_for_confirmation](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/include/dts-functions.sh#L1862)
        - [HCL
          report](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/reports/dasharo-hcl-report.sh#L421)
        - [restore](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/scripts/dasharo-deploy.sh#L1408)
- `CTRL+C`
    * press `CTRL+C`. Shouldn't break anything no matter when it's used.
    * If it's used during workflow then user should see relevant information
      that workflow was stopped.
    * If `CTRL+C` is used during flashing user should be informed that their
      platform is in unknown state, and they shouldn't reboot.
    * alternatively - `CTRL+C` should be trapped and do nothing (at least when
      flashing to not brick user platform)

## Credentials

- empty e-mail
    * press Enter without writing anything when prompted for e-mail
    * relevant code: [get_dpp_creds
      e-mail](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/include/dts-subscription.sh#L106)
- empty password
    * press Enter without writing anything when prompted for password
    * relevant code: [get_dpp_creds
      password](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/include/dts-subscription.sh#L108)
- non-existent credentials
    * enter random, non-existent e-mail and password when prompted
- no internet access
    * disconnect Ethernet cable or set network interface down before trying to
      load credentials
- no access to MinIO server - e.g. server is down
    * modify `DPP_SERVER_ADDRESS`
    * relevant code:
      [dts-environment.sh](https://github.com/Dasharo/dts-scripts/blob/f504940be758576a9fd6df90759abb04e4863e7c/include/dts-environment.sh#L26)
- e-mail or password with space
    * use space in e-mail or password

## Generic workflow (update, deployment, transition)

- missing remote files - any combination of missing files downloaded by DTS so
  firmware binaries, hashes, signatures, additional binaries used by some
  platforms
    * remove files on remote server
    * change path to file to point to non-existent file (in `dts-configs` or by
      modifying scripts)
- no access to remote server
    * FTP/minio/GitHub is down or blocked
    * modify address of remote server to some non-existent one
    * block server/IP via e.g. firewall
- no internet access
    * disconnect Ethernet cable or disable network interface before starting
      workflow
    * disable network before starting workflow and during
    * all places where we connect to the remote should be tested (all usages of
      `curl`, `wget`, `mc`, e.t.c.). All file downloads should possibly be
      merged into one function to simplify testing
- BIOS region in flash is write-protected
    * enable `BIOS boot medium lock` or `Enable SMM BIOS write protection` in
      BIOS on Dasharo UEFI firmware
    * mock on non-Dasharo firmware
    * test all workflows that use flashrom to write to flash
- no firmware available
    * try to run workflow on unsupported platform or platform by emulating
      unsupported platform (`TEST_SYSTEM_*` and `TEST_BOARD_MODEL` variables).
    * modify `DTS_CONFIG_REF` to use `dts-configs` branch with removed support
      for your platform
- firmware to be deployed doesn't support platform hardware e.g.
    * [firmware doesn't support 13th gen
      CPU](https://github.com/Dasharo/open-source-firmware-validation/blob/085e87c254975cc21c778291307aa16aa1848dca/dts/dts-e2e.robot#L56)
- wrong hash
    * modify `.sha256` file used during workflow
    * use custom file server with wrong hash files
- wrong signature
    * serve malformed `.sig` file
    * serve `.sig` file signed with different, untrusted, key
- flashing fails
    * mock flashing failure
    * There are multiple possible failure points in `deploy_firmware` function,
      all need to be tested.
    * inform user what to do in this case (especially if it was partially
      flashed).
- flashrom (internal) failures
    * multiple failure points
    * to test: mock
    * complete flashrom failure (can't access flash at all)
    * flash region read failures
- flashrom (ec) failures
    * to test: mock
    * complete flashrom failure (can't access flash at all)
    * flash region read failures
    * flash write failure (initial deployment)
- capsule workflow with Intel ME enabled
    * run capsule workflow (e.g. update/fuse) with Intel ME enabled or Soft
      disabled
- failed capsule loading
    * run capsule update on firmware that doesn't support capsule updates
    * run capsule update with enabled ME

## Variables

Wrong values in DTS variables in `dts-scripts` or `dts-configs`

- Variables related to paths e.g.:
    * `bios_path_comm`
    * `heads_link_dpp`
    * and others. Same results as in `Missing remote files` point.

- Unsupported version format in `dasharo_rel_ver*`
    * set version in format unsupported by `compare_version`

- Variables related to binary preparation i.e. `*_MIGRATION`. Those
    variables decide whether we need to run workflow related to this migration. If
    they have wrong value then final workflow result might be different from
    expected e.g. in case of `NEED_SMMSTORE_MIGRATION` we might end up without
    migrated config (so we lose all BIOS configuration after update)

- Variables related to flashing firmware e.g. `HAVE_EC`,
    `FLASHROM_ADD_OPT_UPDATE_OVERRIDE`, `PROGRAMMER_BIOS`, `PROGRAMMER_EC`.
    Mistakes here might result in:
    * flashrom command failing
    * flashrom flashing wrong/unexpected regions
    * EC not being flashed (if platform has EC) or error when trying to flash
      non-existent EC
