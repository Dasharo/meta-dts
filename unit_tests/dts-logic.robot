*** Settings ***
Library             Collections
Library             OperatingSystem
Library             Process
Library             String


*** Test Cases ***
DTS-logic001.001 Dasharo v1.7.2 on NV4x_PZ, heads with heads DES
    [Documentation]    This test aims to verify that updates on Dasharo v1.7.2
    ...    on NV4x_PZ eligible for updates to heads with heads DES and
    ...    regular update are working properly
    ${COMMAND}=    catenate    SEPARATOR=
    ...    expect -c '
    ...    ${SPACE}set env(BOARD_VENDOR) "Notebook";
    ...    ${SPACE}set env(SYSTEM_MODEL) "NV4xPZ";
    ...    ${SPACE}set env(BOARD_MODEL) "NV4xPZ";
    ...    ${SPACE}set env(BIOS_VERSION) "Dasharo (coreboot+UEFI) v1.7.2";
    ...    ${SPACE}set env(TEST_DES) "y"'
    ...    ${SPACE}exp/novacustom-Notebook-NV4xPZ-1.7.2-heads-DES.exp
    ${output}=    Run Process    bash    -c    ${COMMAND}
    Should Not Contain    ${output.stdout}    expect timeout looking for
    Should Contain    ${output.stdout}    Successfully switched to Dasharo Heads firmware.
    Should Contain    ${output.stdout}    Checking Dasharo EC firmware checksum...
    Should Contain    ${output.stdout}    Checking Dasharo EC firmware signature...
    Should Contain    ${output.stdout}    Updating EC...
    Log    ${output.stdout}

# example new tests could look something like this:
#     ${COMMAND}=    catenate    SEPARATOR=
#     ...    expect -c '
#     ...    ${SPACE}set env(BOARD_VENDOR) "other board vendor";
#     ...    ${SPACE}set env(SYSTEM_MODEL) "other system model";
#     ...    ${SPACE}set env(BOARD_MODEL) "other board model";
#     ...    ${SPACE}set env(BIOS_VERSION) "some Dasharo version";
#     ...    ${SPACE}set env(TEST_DES) "y/n"'
#     ...    ${SPACE}exp/novacustom-Notebook-NV4xPZ-1.7.2-heads-DES.exp <- we might need more files, but for
#     very generic updates this one could work
#     ${output}=    Run Process    bash    -c    ${COMMAND}

#     # this should stay the same always
#     Should Not Contain    ${output.stdout}    expect timeout looking for

#     # might also have to change the pass conditions though
#     Should Contain    ${output.stdout}    Successfully switched to Dasharo Heads firmware.
#     Should Contain    ${output.stdout}    Checking Dasharo EC firmware checksum...
#     Should Contain    ${output.stdout}    Checking Dasharo EC firmware signature...
#     Should Contain    ${output.stdout}    Updating EC...
#     Log    ${output.stdout}
