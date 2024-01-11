# meta-dts

You can find documentation about the DTS system, including information on
building the system, running the system, and the functionalities included in the
system, by visiting the following links.

* [Building the system](https://docs.dasharo.com/dasharo-tools-suite/documentation/#building)
* [Running the system](https://docs.dasharo.com/dasharo-tools-suite/documentation/#running)
* [Features included in the system](https://docs.dasharo.com/dasharo-tools-suite/documentation/#features)

Please visit [release](https://docs.dasharo.com/dasharo-tools-suite/releases/)
section to get latest version of DTS.

## Communication channel

We have created [communication
channels](https://docs.dasharo.com/ways-you-can-help-us/#join-dasharo-matrix-community)
to provide support to our community. Please look there if you are looking for
help regarding DTS system or any Dasharo related stuff.

## Reporting issues

Thank you for using Dasharo Tools Suite Community Edition. If you have
encountered any problems with this version, or would like to provide feedback
for us - please open an issue on
[dasharo-issues](https://github.com/Dasharo/dasharo-issues/issues) repository.

## Release process

This section contains the technical aspects of the `DTS` release process. The
recipients of this information should be those authorised to issue `DTS`
releases.

Below are information on how to publish `production` and `develop` releases.

* `Production` releases deploy images to GitHub Release pages and
  `boot.3mdeb.com`/`boot.dasharo.com` pages to boot via iPXE.

* `Develop` releases deploy images to GitHub Release pages, so not all users
  will be able to use them via iPXE.

### How to publish a production release

<!--
We should prepare scripts that automates this.
-->

Please follow the steps below to release a new production `DTS` image.

1. Make sure that everything that should go into the given release is merged to
   `main`.

1. Bump the version in `meta-dts-distro/conf/distro/dts-distro.conf` file.

    > Note: In cases where MINOR or MAJOR part of version is updated, please inform
    one of the maintainers as there will be needed new keys to sign the binaries
    in next step of CI/CD pipeline.

1. Fill up the [CHANGELOG.md](./CHANGELOG.md) file with latest changes.

1. Run [update_components.sh](./scripts/update_components.sh) script which will
   update revision of Dasharo related recipes (e.g.
   [dasharo-ectool](./meta-dts-distro/recipes-support/dasharo-ectool/dasharo-ectool_0.3.8.bb)),
   create a tag and push it to the remote repository.

From here, rest of the jobs should be carried out by the GitHub and Gitea
Actions. Whole pipeline of creating `DTS` release consists of two steps.

* First is done on GitHub Actions. Here we update [Dasharo
  components](./scripts/update_components.sh) build the `DTS` image and push
  binaries to `boot.dasharo.com`.

* Second is done on Gitea Actions. Here we push the ipxe menu to
  `boot.3mdeb.com` and sign the `DTS` binaries. The last step of Gitea Actions
  creates new release at the `https://github.com/Dasharo/meta-dts/releases`
  from where binaries can be downloaded.

### How to publish a develop release

Please follow the steps below to release a new develop `DTS` image.

1. Make sure that everything that should go into the given release is merged to
   `develop`.

1. Bump the version in `meta-dts-distro/conf/distro/dts-distro.conf` file by
   adding `-rcX` suffix.

    > Note: X should increase every time new develop release is created.

1. Create and push tag that match the newly bumped version.

From here, rest of the jobs should be carried out by the GitHub and Gitea
Actions. Whole pipeline of creating `DTS` release consists of two steps.

* First is done on GitHub Actions. Here we build the `DTS` image.

* Second is done on Gitea Actions. Here we sign the `DTS` binaries and push
  them to [boot.dasharo.com](https://boot.dasharo.com/dts) under the directory
  named after rcX version.

## Testing Dasharo firmware updates from local sources

<!--
This section could go to docs.dasharo.com after some clean-up regarding DTS
documentation.
-->

By default the `DTS` uses `https://3mdeb.com/open-source-firmware/Dasharo` as a
source of downloaded artifacts in case of community releases. This behaviour can
be changed by starting `dts` script from the command line with
`FW_STORE_URL_DEV` variable set to the http address that is serving the update
files.

Below there is a list of steps that one need to do, to fetch binaries from local
server.

1. On host PC create `dasharo-updates` directory and from it start the http
   python module, as a port you can use e.g. `1234`.

    ```bash
    mkdir dasharo-updates && cd dasharo-updates
    python -m http.server 1234
    ```

1. Inside `dasharo-updates` directory create the same folder structure as there
   is for your update files on `https://3mdeb.com/open-source-firmware/Dasharo`.
   E.g. for `v1.7.2` of `NovaCustom NS5X ADL` you need to create path
   `novacustom_ns5x_adl/v1.7.2/` and inside put binaries, hashes and signatures
   from that release.

1. Boot `DTS` and start shell by pressing `9`.

1. Start `dts` script with `FW_STORE_URL_DEV` variable set to started server on
   the host PC. E.g. if the PC has IP address `192.168.1.14` use below command.

    ```bash
    FW_STORE_URL_DEV="http://192.168.1.14:1234" dts
    ```

1. Normal `dts` menu entry will be displayed but any request to the server with
   binaries will be done to `http://192.168.1.14:1234` instead of
   `https://3mdeb.com/open-source-firmware/Dasharo`.
