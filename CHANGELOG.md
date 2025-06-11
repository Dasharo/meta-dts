# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## 2.5.0 - 2025-06-11

### Added
- CHANGELOG: add notes for v2.5.0
- distro: dts-scripts: add SeaBIOS support


### Changed
- kas/common.yml: bump meta-dasharo for updated dasharo_ectool
- dts-scripts: Use external board_config repository. DTS releases are no longer
  needed after new Dasharo release.
- kas/common.yml: Bump meta-coreboot revision
- dts-distro.conf: bump version to 2.5.0


## 2.4.0 - 2025-03-31

### Changed
- .github/workflows/test.yml: Use MinIO credentials
- dts-scripts: Use MinIO for DPP
- dts-distro.conf: bump version to 2.4.0


### Fixed
- dts-scripts: Fix error handling


## 2.3.0 - 2025-03-20

### Added
- dts-scripts: Add Heads FW to V540TU
- CHANGELOG: Add notes for v2.3.0


### Changed
- .github/workflows: Build DTS from kas-uefi-sb.yml
- Use separate cache for kas-uefi-sb + build kas-uefi-sb in weekly workflow
- .github/workflows/test.yml: Build from kas-uefi-sb.yml
- recipes=bsp/grub/grub-efi-efi-custom.inc: Force do_deploy execution
- distro: dts-scripts: Hide DPP credentials
- dts-scripts: Initialize _check_dwn_req_resp_uefi_cap
- dts-distro.conf: bump version to 2.3.0
- cliff.toml: Allow parsing keywords starting with uppercase letters
- dts-scripts: Download SINIT ACM from dl.3mdeb.com


### Fixed
- distro: dts-scripts: Fix double ME warning
- dts-scripts: Fix Intel SINIT ACM download


## 2.2.1 - 2025-02-05

### Changed
- generate-changelog.sh: Add help and remove container after use
- workflow: change backticks to quotes
- dts-distro.conf: bump version to 2.2.1


### Fixed
- dts-scripts: fixes failed update when FD/ME is locked on e.g. MSI
- dts-scripts: fix ODROID-H4 firmware link and initial deployment


## 2.2.0 - 2025-01-30

### Added
- dts-scripts: add V560TU Heads support


### Changed
- README.md: update docs.dasharo links
- README.md: update old information
- dts-scripts: enhanced logging also fixes Dasharo/dasharo-issues#1165
- workflow: test.yml: use line buffering with grep
- distro: dts-scripts: mock sound card in HCL report
- distro: dts-scripts: HCL should not exit on error
- CHANGELOG.md: Fix Dasharo/dasharo-issues#1185
- CHANGELOG.md: Remove links from changelog
- scripts/generate-changelog.sh: Fix arguments
- dts-scripts: Change FW access warning to less alarming message
- meta-dts-distro: packagegroup-dts: Add msr-tools and bc
- distro: bump to 2.2.0


### Fixed
- distro: dts-scripts: fix DPP message typo
- distro: dts-scripts: fix DTS Extensions messages
- distro: dts-scripts: fix DPP access message


## 2.1.3 - 2025-01-03

### Fixed
- dts-scripts: fix for logs not being sent after update/install


## 2.1.2 - 2024-12-20

### Changed
- .github/workflows/test.yml: Improve test workflow (#200)
- kas: cache.yml: don't use local hash equivalence server
- distro: bump to 2.1.2


### Fixed
- dts-scripts: fix acpidump command in HCL report
- distro: dts: dts-scripts: fix for empty credentials
- distro: dts: dts-scripts: change DTS Extensions message


## 2.1.1 - 2024-12-13

### Added
- kas/common.yml: add meta-coreboot and meta-dasharo


### Changed
- Remove recipes from meta-dts-distro as part of migration
- dts-distro.conf: bump to 2.1.1


### Fixed
- dts-scripts: fix boardmismatch unhandled parameter error


### Removed
- scripts/update_components.sh: remove migrated components


## 2.1.0 - 2024-12-09

### Added
- recipes-gnome: gcab: add bbapend that disable qa tests
- recipes-kernel: linux-yocto: add efivars.cfg back to SRC_URI
- distro: recipes-kernel: linux-yocto: add capsule update configuration


### Changed
- conf/distro/dts-distro.conf: ROOT_HOME was missing
- recipes-bsp: txe-secure-boot: smmstoretool fix buildpaths warning
- recipes-bsp: coreboot-utils: nvramtool - Fix buildpath warning
- recipes-connectivity: wolfssl: Ignore [buildpaths] QA ISSUE
- recipes-gnome: gcab: use insane_skip instead of disabling whole qa check
- recipes-core: base-files: Mount efivars by default. Needed by FUM
- distro: recipes-dts: dts-scripts: bump revision
- Add generate-changed-recipes script + specify PV for git recipes
- .github/workflows: Deploy manifest to boot.dasharo.com
- Use git-cliff to generate changelog
- recipes-bsp/coreboot-utils: Use 4.21 as base version for coreboot-utils packages
- README: Link Zarhus release process
- Change git-cliff config
- .github/workflows: Fix getting DTS_VER in manifest deployment
- Move generate-changelog.sh to scripts
- Fill up CHANGELOG after rebase
- Add extension to generate-changed-recipes
- README: Explain parameter in generate-changelog.sh
- .github/workflows: Add workflow with DTS tests
- .github/workflows: Add build.yml reusable workflow
- dts-distro.conf: bump to 2.1.0
- dts-scripts: Improve UI/UX
- dts-scripts: Use correct flashrom flags
- dts-distro.conf: Change PREFERRED_VERSION_flashrom
- Remove condition for running tests
- dts-scripts: Bump Optiplex version to 0.1.1


### Fixed
- recipes-bsp/coreboot-utils/intelp2m_git.bb: fix buildpath error
- workflow: fix build artifact paths


### Removed
- linux-yocto: remove deprecated kconfig entries
- recipes-bsp: intelp2m: remove useless 'go version' command


## 2.0.1-rc3 - 2024-11-21

### Changed
- dts-scripts: Enhance verbose mode + collect cbmem console in hcl report
- dts-scripts: Add vbt to hcl report
- dts-scripts: Bump DPP versions for MSI


## 2.0.1-rc2 - 2024-11-04

### Changed
- kernel/linux-yocto: Add CONFIG_SERIAL_8250_DW
- recipes-extended: sbctl: add RDEPENDS to recipe
- flashrom: Add TGL chipset detection based on SPI PCI ID


## 2.0.1-rc1 - 2024-10-23

### Changed
- recipes-extended: sbctl: update sbctl to v0.15.4
- dts-scripts: Print warning when creds don't support DPP packages


## 2.0.0 - 2024-09-30

### Changed
- Clean up changelog


### Added
- Add support for ODROID-H4
- Add support for NovaCustom V5x0TNx
- Add support for Dell Optiplex 7010/9010
- CHANGELOG: add changelog for v2.0.0

### Fixed
- Fix workflow errors


## 2.0.0-rc7 - 2024-09-23

### Changed
- pre-commit: use upstream oelint
- recipes-dts: dts-scripts: Bump SRCREV (verbose mode and sending logs)


### Added
- CHANGELOG: add changelog for v2.0.0-rc7

## 2.0.0-rc6 - 2024-09-12

### Changed
- scripts: generate-ipxe-menu: delete root=/dev/nfs
- python/python3-binwalk_2.3.3.bb: Change src to updated fork
- meta-dts-distro/conf/layer.conf: Bump layer priority to 9


### Added
- Add support for Dell Optiplex including DPP support
- CHANGELOG: add changelog for v2.0.0-rc6

## 2.0.0-rc5 - 2024-08-28

### Changed
- .github/workflows: Use separate SSH config for deploy job
- recipes-bsp/txe-secure-boot/txesbmantool_git.bb: Bump SRCREV
- recipes-bsp: txesbmantool: Change branch and SRCREV
- distro: extended: minio-cli: amend absolete-license
- .oelint-ruleset.json: Set homepageping to info so pre-commit ci can run
- conf/distro/dts-distro.conf: Bump DISTRO_VERSION to 2.0.0-rc5


## 2.0.0-rc4 - 2024-07-26

### Added
- Add minio-cli
- dts-scripts: add DES(DPP) packaging support


## 2.0.0-rc3 - 2024-07-16

### Changed
- dts-scripts: Change to rev removing separate EC update
- dts-distro.conf: bump to 2.0.0-rc3

## 2.0.0-rc2 - 2024-07-09

### Changed
- Use sshd.service instead of sshd.socket
- dts-base-image.inc: Remove 'rootfs' suffix from image
- dts-scripts: Add more model checks for V54x_6xTU
- dasharo-ectool: bump rev for Dasharo ACPI ID
- dts-distro.conf: bump version to 2.0.0-rc2


### Added
- Add and use python semver module to compare versions
- Add lshw
- CHANGELOG.md: Add v2.0.0-rc2


## 2.0.0-rc1 - 2024-07-08

### Added
- Add support for MTL
- Add txesbmantool, revision 235c946838dc8c619ff821c9791386d63f5cbd6a
- Add smmstoretool, revision 602653abed391ae1b1445ad86d0f05b8b5b678cb
- Add cpuid tool
- Add pre-commit configuration
- Add cukinia documentation


### Changed
- Change meta-secure-core origin
- Update most of system libraries and applications to newer version
- linux-yocto: remove efi-ext.scc from KERNEL_FEATURES
- move DTS scripts to another repo
- dts-scripts: do_install via Makefile
- dts-scripts: relicense to Apache-2.0
- kernel: acpi-call-dkms: change license to GPLv3
- update layers to scarthgap
- dts-distro.conf: add usrmerge to DISTRO_FEATURES
- dasharo-ectool: add sha256sums for cargo deps
- iotools: allow overriding CC
- iotools: disable DEBUG by default
- Updated Linux kernel to version 6.6.21
- Don't use ICMP for network connection verification
- dts-distro.conf: bump to v2.0.0-rc1


### Fixed
- dts-scripts: fix Intel regions backup
- Fixed scp not working without `-O` option


### Removed
- support: hidapi: delete


## 1.2.23 - 2024-06-27

### Changed
- dts-distro.conf: bump to v1.2.23
- CHANGELOG.md: v1.2.23
- dts-functions: support seabios in check_se_creds()

### Fixed
- dasharo-deploy: fix flashrom_extra_args


## 1.2.22 - 2024-06-27

### Added
- CHANGELOG.md: add v1.2.22
- packagegroup-dts.bb: add iperf3 to tools
- unit_tests: basic support for running in QEMU and OSFV
- dts: initial deployment for PC Engines SeaBIOS
- dts-base-image: add lshw
- meta-dts-distro: add python3-roca-detect
- meta-dts-distro: add rdepends for python3-roca-detect
- dasharo-deploy: preserve settings for seabios initial deploy


### Changed
- dts-distro: coreboot-utils: Update branch and commit
- dts/dts-functions.sh: bump ncm adl heads to v0.9.1
- conf/distro/dts-distro.conf: bump to v1.2.22
- dts-functions.sh: clarify on heads update path
- dts: allow overriding some variables from env
- coreboot-utils: update SRCREV


### Fixed
- dts: dts-functions.sh: fix BINARY_HAS_RW_B value
- Fix Dell Optiplex variables to enable firmware download
- dasharo-hcl-report: fix generation on qemu (coreboot + edk2)


### Removed
- reports: dasharo-hcl-report: remove board_config call
- Remove unneeded line that is commented out

## 1.2.21 - 2024-03-29

### Added
- deploy: add exit when trying to flash v1.1.1 on 13th gen and above
- deploy: add two missing DDR5 boards


### Changed
- deploy: make it exit only on specific boards
- Update meta-dts-distro/recipes-dts/dts/dasharo-deploy/dasharo-deploy
- meta-dts-distro/recipes-dts: dts-functions: Add config for PC Engines APU boards
- recipes-dts: dts-functions.sh: Modify config for APU platforms
- recipes-dts: dts-functions.sh: Change PC Engines binary paths
- meta-dts-distro/recipes-dts: Changes to support PC Engines firmware deployment
- add support for hw-probe.AppImage
- add hw-probe section to the end of dasharo-hcl-report script
- add hw-probe tool
- make the wording in the prompt better
- move INSANE_SKIP to .bb
- distro: dts-distro: v1.2.21 bump
- CHANGELOG: v1.2.21
- 3mdeb-secpack: update to f52771d2d001c55b164fae397d060d6e5af9c733
- CHANGELOG.md: fill up after automatic update of components


### Fixed
- fix hcl report freezing, update script for hw-probe
- fix removing the mac adress from logs


### Removed
- deploy: remove extra boards


## 1.2.20 - 2024-03-19

### Added
- CHANGELOG: add v1.2.20


### Changed
- workflows: ci.yml: comment out releasing iso image
- flashrom: update to f5a48aa6c67bd30603062bb4265419fd49f83870
- 3mdeb-secpack: update to c844b4ba536cde4813c8e4088bf069ac90ef9c27
- CHANGELOG.md: fill up after automatic update of components
- distro: dts-distro: bump v1.2.20


## 1.2.20-rc7 - 2024-03-18

### Changed
- distro: wic: change boot partition to efi type
- dts: dts-functions: use local vars in check_se_creds
- dts: packagegroups: create packagegroup-tpm-dts
- distro: dts-base-image: install packagegroup-tpm-dts
- dts: dts-functions: standarize HEADS_SWITCH_FLASHROM_OPT_OVERRIDE variable
- dts: dasharo-deploy: change logic to set FLASHROM_ADD_OPT_UPDATE_OVERRIDE
- distro: dts-distro: bump v1.2.20-rc7


## 1.2.20-rc6 - 2024-03-18

### Changed
- distro: dts-distro: bump v1.2.20-rc6


### Fixed
- unit_tests: dts-boot: fixes after testing with MSI heads creds
- dts: dts-functions: fix links for MSI heads release
- dts: dts-functions: fix check_se_creds func for heads check
- dts: dts: fix providing DES creds, allow to use $ character


## 1.2.20-rc5 - 2024-03-15

### Added
- dts: dts-functions: add PLATFORM_SIGN_KEY for heads binary


### Changed
- dts-functions: set HEADS_SWITCH_FLASHROM_OPT_OVERRIDE based on msi ver
- dts: dts-functions: use DES_IS_LOGGED var while checking HEADS flashing flags
- distro: dts-distro: bump v1.2.20-rc5


### Fixed
- dts: dts-functions: fix get_signing_keys function


## 1.2.20-rc4 - 2024-03-13

### Added
- distro: dts: add dropin to set DTS_ENV, DTS_FUNCS vars on ssh connection


### Changed
- dts: dts-environment: set default value for DEPLOY_REPORT variable
- distro: dts-distro: bump v1.2.20-rc2
- distro: dts-distro: bump v1.2.20-rc3
- distro: dts-distro: bump v1.2.20-rc4


### Fixed
- dts: dasharo-hcl-report: fix typo while sourcing dts-functions script
- distro: dasharo-hcl-report: fix sed command to remove MAC address info


## 1.2.20-rc1 - 2024-03-13

### Added
- distro: dts: dts-functions: add flags for NovaCustom EC flashing


### Changed
- sbctl: fetch tarball from github
- distro: dts-functions: enable HEADS support for MSI targets
- distro: dts-distro: bump v1.2.20-rc1


## 1.2.19 - 2024-02-28

### Added
- distro: packagegroup-dts: add missing packages for TPM2 support
- CHANGELOG: add changelog for v1.2.19


### Changed
- distro: dts: iterate over gpg keys while importing them
- distro: bump v1.2.19-rc2
- Update dts - reorder where to thow DES keys
- Update dts - remove unneeded empty line
- Update dts - removed not needed fi
- distro: bump v1.2.19
- distro: dts-functions: comment out HEADS support for MSI targets
- 3mdeb-secpack: update to c48af6eb2698f255c19a48a602b0e474137b07ef
- CHANGELOG.md: fill up after automatic update of components


## 1.2.19-rc1 - 2024-02-27

### Added
- local-ipxe-server.sh: added
- dts: add warnings after switching FW branches


### Changed
- linux-yocto: enable IOMMU
- meta-dts-distro/recipes-dts/dts/dts/dts-functions.sh: Fix MSI Z790-P DDR4 board matching
- meta-dts-distro/recipes-dts/dts: Add switching to heads
- unit_tests: Add stubs and unit tests for Dasharo updates
- Apply suggestions from code review
- Apply suggestions from code review
- meta-dts-distro/recipes-dts/dts/dts/dts-functions.sh: Fix DES logged checks
- meta-dts-distro/recipes-dts/dts/dts/dts-functions.sh: Reduce version checks in switching
- unit_tests: Fix running unit tests
- Add support for heads switching for MSI
- unit_tests: make dts-boot executable, add replacements for reboot/poweroff cmd
- unit_tests: README: change command for test execution
- distro: bump v1.2.19-rc1


### Fixed
- unit_tests: dts-environment: fixes in CMD_POWEROFF/REBOOT after review


## 1.2.18 - 2024-01-22

### Changed
- distro: bump v1.2.18
- Release v1.2.18


## 1.2.18-rc1 - 2024-01-17

### Changed
- Bring back changes reverted in d72852e76e9f
- meta-dts-distro/recipes-dts/dts: Add flashrom update params override for MSI boards
- distro: bump v1.2.18-rc1


## 1.2.17 - 2024-01-17

### Added
- CHANGELOG: add changelog for v1.2.17


### Changed
- distro: bump v1.2.17
- 3mdeb-secpack: update to 2225894887fc81a1c72b067edbe348b5f3f02a05
- CHANGELOG.md: fill up after automatic update of components


## 1.2.17-rc4 - 2024-01-17

### Changed
- Revert changes introduced by commits d5054bc2f8b7 through b240c2484981
- distro: dts-functions: bump update version for NCM NS5x
- distro: bump v1.2.17-rc4


## 1.2.17-rc3 - 2024-01-16

### Changed
- distro: bump v1.2.17-rc3


### Fixed
- distro: dasharo-deploy: fix typo in if statement


## 1.2.17-rc2 - 2024-01-16

### Changed
- meta-dts-distro/recipes-dts/dts/dts/dts-functions.sh: Add missing fi
- distro: bump v1.2.17-rc2


## 1.2.17-rc1 - 2024-01-16

### Added
- distr: dts-sb-distro: adds working distro configuration
- CHANGELOG: add info about changes in SB enabled image


### Changed
- distro: sbctl: provide recipe to install sbctl
- distro: dts-base-sb-image: install sbctl
- distro: grub-efi-efi-custom: provide UEFI SB enabled bootfiles to deploydir
- Update dts - wording
- meta-dts-distro/recipes-dts: Add checks for readable and flashable regions
- meta-dts-distro/recipes-dts/dts: Add logic for determining flashrom update params
- meta-dts-distro/recipes-dts/dts: Fix bugs and syntax
- meta-dts-distro/recipes-dts/dts: Check if vboot keys need to be updated
- meta-dts-distro/recipes-dts/dts: Add prints in section which may take a while
- meta-dts-distro/recipes-dts/dts: Add option to override flashrom update parameters
- meta-dts-distro/recipes-dts/dts: Handle all migration and update operations automatically
- meta-dts-distro/recipes-dts/dts: Address review discussions
- distro: dasharo-deploy: small syntax fixes
- distro: dts-functions: bump update versions for MSI and NCM NS5x
- distro: bump v1.2.17-rc1


## 1.2.16 - 2024-01-11

### Changed
- dts: dts-functions: reset ns5x tgl to v1.5.1
- dts-distro: bump v1.2.16
- CHANGELOG: fill up list of changes for v1.2.16


## 1.2.16-rc5 - 2024-01-11

### Changed
- dasharo-deploy: use dcu for patching bootlogo
- dts-distro: bump v1.2.16-rc5


## 1.2.16-rc4 - 2024-01-11

### Added
- README: add info about rc rel available over iPXE on boot.dasharo.com


### Changed
- dts-distro: bump v1.2.16-rc4


## 1.2.16-rc3 - 2024-01-11

### Added
- scripts: get_last_commit: add script to get latest commit from given branch
- scripts: update_components: add script to update 3mdeb/Dasharo-based recipes
- README: add info about automatic update of some revisions in prod release
- scripts: update_components: add automatic CHNGLG update, move tag after commiting release


### Changed
- workflows: run jobs on tags creation instead of pushing
- workflows: another try to run jobs dependencies
- distro: dts: dts-functions.sh: Fix missing space
- scripts: update_components: does not use force while creating tag
- dts: dts-functions: set DASHARO_REL_VER to 1.5.2 for NCM tgl
- dts-distro: bump v1.2.16-rc1
- dts-distro: bump v1.2.16-rc2
- scripts: generate-ipxe-menu: generate different ipxe menu file for rc releases
- dts-distro: bump v1.2.16-rc3


### Fixed
- workflows: ci.yml: fix re in tags section
- workflows: fix pipeline triggers
- workflows: fix jobs execution
- workflows: fix typo
- README: fix release process section
- workflows: develop: fix tag re, push rc iPXE menu to boot.dasharo.com


## 1.2.15 - 2024-01-11

### Added
- CHANGELOG: add v1.2.15
- workflows: weekly: add on workflow_dispatch to run job manually


### Changed
- Update dts-functions.sh
- dts-distro: bump v1.2.15
- workflows: rerun build step in case of error
- dts/dts-functions.sh: update checksum for ACM relese file v003
- meta-dts-distro/recipes-dts/dts/dts/dts-functions.sh: Update SINIT ACM ZIP name
- dts: do not check signatures if PLATFORM_SIGN_KEY not set
- dasharo-deploy: update smmstore and bootsplash migration console output
- dasharo-deploy: use common error handling functions
- dts-functions: avoid printing empty line in error_check
- dts: dts-functions: improve UX
- dts: dasharo-deploy: improve logging in migration functions
- distro: dts: improve UX of update process
- CHANGELOG: update for v1.2.15


### Fixed
- distro: dts-functions: fix PLATFORM_SIGN_KEY variable for msi cases
- dts: dts-functions: fix bash execution error


### Removed
- workflows: remove not needed comments


## 1.2.14 - 2024-01-03

### Added
- README: add information how to publish develop release
- distro: 3mdeb-secpack: add recipe to include 3mdeb keys in the image
- distro: 3mdeb-secpack: add script to profile to set GNUPGHOME env
- CHANGELOG: add rest changes for v1.2.14


### Changed
- workflows: develop.yml: publish develop releases only on GitHub Rel tab
- distro: dts: set GNUPGHOME env when dts script is executed
- distro: packagegroup-dts: install 3mdeb-secpack
- dts-functions: do not fetch 3mdeb Master keys in get_signing_keys func
- distro: 3mdeb-secpack: correctly set dir permissions
- dts-distro: rel v1.2.14
- CHANGELOG: fill up list of changes for v1.2.14
- workflows: include wic.bmap files in prod and dev releases
- workflows: set tags pattern
- workflows: save gitea key in correct format


### Fixed
- workflows: fix usage of SSH_KEY_GITEA secret


## 1.2.13 - 2023-12-22

### Added
- meta-dts-distro: add dasharo_ectool
- distro: converged-security-suite: add bg-suite recipe and binary
- distro: recipes-dts: packagegroups: add bg-suite to image
- distro: converged-security-suite: add statically linked bg-suite
- CHANGELOG.md: add bg-suite note
- dts: kernel: add support for exFAT and NTFS
- CHANGELOG.md: add exFAT and NTFS note
- dts: add check_if_ac() before fw update
- dts: add bootsplash_migration()
- recipes-dasharo/dasharo-coreboot-customizer: add recipe
- distro: dts: add signature verification of Dasharo firmware binaries
- README: add section about testing updates from local sources
- README: add release process section
- CHANGELOG: add missing points


### Changed
- dts: print list of IPs when starting SSH
- system76_ectool: rename to dasharo_ectool
- dasharo-ectool_0.3.8.bb: update to fix build
- CHANGELOG.md: Fix Z790-P board typo
- Release v1.2.13
- distro: converged-security-suite: change path to bg-suite binary
- linux-yocto: enable ACPI_BGRT
- dts: check for network in board_config(), improve err msgs
- dasharo-configuration-utility/: bump SRCREV
- Release v1.2.13-rc2
- generate-ipxe-menu.sh: more readable script, prepare for imgverify
- distro: dts: cleanup environment and functions
- distro: dts-functions: bump ncm adl to v1.7.2
- distro: dts-functions: flash whole bios for ncm adl update
- distro: dts-environment: set default value for FW_STORE_URL variable
- distro: dts-functions: silence logs from pub key fetching
- distro: dts-functions: run curl in silent mode when fetching artifacts
- Release v1.2.13-rc3
- README: update section about testing updates from local sources
- distro: update revisions of Dasharo related utilities
- CHANGELOG: fillup changelog for release v1.2.13
- distro: dts-distro: Release v1.2.13


### Fixed
- distro: dasharo-configuration-utility: fix whitespace


### Removed
- distro: dts-environment: remove unused variable


## 1.2.12 - 2023-11-03

### Changed
- bump to 1.2.12
- CHANGELOG.md: update for v1.2.12
- github: workflows: use dts-builder label for runner


### Fixed
- dts/dts-functions.sh: fix updating boards without Vboot slot B
- github: workflows: fix typos


## 1.2.11 - 2023-10-31

### Changed
- dts/dts-functions.sh: set NovaCustom versions to 1.5.1/1.7.1


## 1.2.10 - 2023-10-27

### Added
- meta-dts-distro/recipes-dts/dts: add coreboot_customizer
- workflows: ci.yml: add final version


### Changed
- meta-dts-distro/recipes-dts/dts/dts/coreboot_customizer: Fix UUID param case
- meta-dts-distro/recipes-dts/dts/coreboot_customizer: Use cbfstool from variable
- CHANGELOG: init v1.2.10 notes
- dts/dts-functions.sh: enable SMMSTORE migration for NovaCustom
- bump to 1.2.10
- workflows: ci.yml: verification commit
- .github: ci.yml: prepare final CI for signing tests
- .github: ci.yml: commit changes to release singning repo
- CHAGELOG: finish v1.2.10 changelog


### Fixed
- CHANGELOG.md: fix typos for rel v1.2.10


## 1.2.9 - 2023-09-29

### Added
- dts: dts-functions: add fum_exit


### Changed
- kernel: linux-yocto: set CONFIG_EFI_VARS
- dts: dts-functions: improve check_flash_chip func
- dts: install dts-boot script to help in detecting FUM
- dts: dts-base-image: use dts-boot as login-program
- dts: packagegroup-dts: install efivar utility
- dts: dasharo-deploy: integrate FUM support
- dts: dts-functions: modify flashrom update flags for NC targets
- distro: dts-distro: bump 1.2.9-rc1
- distro: dts-functions: improve links to EC according to latest changes
- dts: dasharo-deploy: minor fix in EC_HASH check and add network check in FUM
- dts: dasharo-deploy: improve logging visibility
- distro: dts-distro: bump 1.2.9
- CHANGELOG: v1.2.9


### Fixed
- dts: dasharo-deploy: fix log typos


## 1.2.8 - 2023-09-05

### Added
- recipes-devtool/me-cleaner: add recipe
- dts: dasharo-deploy: add ROM hole and SMMSTORE migration
- dts: dts-functions: add board_config for Z790
- CHANGELOG.md: add placeholder for v1.2.6
- recipes-tests/converged-security-suite/txt-suite_2.6.0.bb: add recipe
- CHANGELOG.md: add txt-suite
- distro: dts: add check_flash_lock function


### Changed
- recipes-bsp/coreboot-utils: update revision for Jasper Lake support
- release v1.2.1
- recipes-bsp/coreboot-utils: update to support Raptor Lake
- release v1.2.2
- recipes-core/busybox: enable devmem applet
- release v1.2.3
- release v1.2.4
- release v1.2.5
- Update CHANGELOG.md
- distro: flashrom: update flashrom revision
- scripts: local-deploy: improve development scripts
- dts: dasharo-hcl-report: move variables and functions to common files
- dts: dasharo-hcl-report: improve reading firmware image on Z790
- dts: dasharo-deploy: move variables and functions to common files
- dts: dasharo-deploy: introduce split into DES and community releases
- dts: dasharo-deploy: improve reading firmware image on Z790
- dts: use DES instead of SE in variables
- dts: dts-environment: move more variables to common file
- dts: dts-functions: source dts-environment, add new common functions
- distro: dts-distro: use IMAGE_EFI_BOOT_FILES to install EFI/DTS/grubx64.efi
- distro: dts-distro: bump v1.2.6
- recipes-bsp/flashrom/flashrom_git.bb: use dashar-release branch
- recipes-dts/packagegroups/packagegroup-dts.bb: install txt-suite
- meta-dts-distro/recipes-dts: use consistent keys nomenclature
- distro: dts: improve logging, add link for Dasharo Security Options
- distro: dts-distro: bump v1.2.7
- distro: dasharo-hcl-report: correct checking log/error files
- distro: dts: export creds for logs if DES not logged
- CHANGELOG: v1.2.7
- recipes-dts/dts/dts/dts-functions.sh: check for SMM protection before flashing
- bump to v1.2.8


### Fixed
- meta-dts-distro/recipes-dts/dts/dasharo-deploy: fix downloading Dell BIOS Update packages
- distro: dasharo-deploy: fix SMMSTORE migration
- meta-dts-distro/recipes-dts/dts/dts/dts-functions.sh: fix DES binary URL
- distro: dts: fix downloading blobs for Dell OptiPlex
- distro: dts: fix nomenclature for DES
- CHANGELOG: fixed typo


## 1.2.0 - 2023-05-10

### Added
- linux-yocto/dts.cfg: add IXGBE driver as module
- scripts: add script for local development


### Changed
- distro: dts: store flashrom logs in /var/local/flashrom.log file
- distro: openssh: disable ssh server by default
- dts: cloud_list: use curl with redirection
- dts: major changes in scripts for release 1.2.0
- dts-distro: v1.2.0 bump
- CHANGELOG.md: release v1.2.0


### Fixed
- workflows: fix existing ones, add develop


### Removed
- README.md: remove content and provide links to docs.dasharo.com
- recipes-dts: dts: removed client's specific scripts


## 1.1.1 - 2023-02-17

### Added
- ipxe-commands: added service able to run scripts (#21)
- dts-distro.conf: add support for iso building
- distro: initramfs: setup-live: add fix for VentoyOS UEFI mode use
- dasharo-deploy: add DDR5 option, add prototype of display_flashing_warning
- distro: dasharo-deploy: add error_check on using flashrom when restoring
- distro: dts: add progress bar for hcl report when init deploy
- distro: dts-distro: add wic.bmap generation to speed up dev flashing


### Changed
- Enable UEFI SB support via meta-secure-core layer (#20)
- Disabling flashing when Dasharo is on board (#25)
- README.md: make commands copypastable (#22)
- distro: system76-ectool: update refspec, use Dasharo fork
- recipes-dts/dts/dasharo-deploy/dasharo-deploy: use baseboard name for MSI
- dts: use reboot by default on dasharo deploy, print hash of used fw
- distro: dasharo-deploy: update error log
- distro: dts-distro: bump v1.1.1
- distro: packagegroup-dts: install tpm2-tools


### Fixed
- dasharo-hcl-report: fix handling multiple default route (#18)
- distro: dasharo-deploy: fix path for SCH5545_FW used with T1650 model
- distro: dasharo-deploy: fix escaping from while loop
- distro: dasharo-hcl-report: fixes after tests


## 1.1.0 - 2022-11-02

### Added
- dasharo-hcl-report: add check on flash chip, fix determing mac address
- dts: add description for option 5


### Changed
- Hcl report improvements (#8)
- CI Builder (#5)
- Implement Dasharo zero-touch init deployment (#14)
- distro: packagegroup-coreboot-utils: install missing packages
- distro: packagegroup-dts: install missing packages
- distro: bump v1.1.0-rc2
- Enable firmware rollback from HCL report (#16)
- Drop CE from names


### Fixed
- dts: fix saving local report
- dasharo-deploy: fix typo in restore option
- workflows: fix yamls
- workflows: fix repo paths


## 1.0.2 - 2022-10-12

### Added
- distro: dts: add vendor menu with novacustom menu
- kernel: add cfg to silence terminal logs and enable GOOGLE_MEMCONSOLE_COREBOOT
- CHANGELOG_CE.md: add v1.0.2 changelog
- CHANGELOG_CE.md: add link for ec transition
- CHANGELOG_CE.md: add info about OS version in menu


### Changed
- distro: ec_transition: download fw from the internet instead of using local files
- dts: ec_transition: update sources of NV4x firmware
- dts-distro: bump to v1.0.2
- dts: ec_transition: name fix and correctly use PROGRAMMER_BIOS variable
- dts: print OS version in main menu
- distro: ec_transition: update ec hash and version for NV4X
- distro: ec_transition: update ec hash and version for NV4X
- CHANGELOG_CE.md: update date


## 1.0.1 - 2022-09-02

### Changed
- Initial commit
- Initial public release
- Fix README

<!-- generated by git-cliff -->
