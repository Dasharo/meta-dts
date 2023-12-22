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

## Testing Dasharo firmware updates from local sources

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
