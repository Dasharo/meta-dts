# Testing

Current E2E tests are defined in [OSFV
repo](https://github.com/Dasharo/open-source-firmware-validation/blob/develop/dts/dts-e2e.robot)

They work by running through different workflows from the moment user sees UI to
the last step (e.g. reboot when updating). Currently, we only check whether we
can get from point A (e.g. start updating) to point B (e.g. printed reboot after
successful update).

## Planned changes

To improve end-to-end (E2E) testing, we plan to create a dedicated profile for
each workflow and platform. This profile will store an ordered list of all
Hardware Abstraction Layer (HAL) calls made during the actual execution of the
workflow. When running tests on QEMU, we will compare the HAL call sequence
generated during the test with the reference profile. The test will pass only if
both sequences are identical.

This change should be fairly trivial, we only have to modify
[tool_wrapper](https://github.com/Dasharo/dts-scripts/blob/bcf7871d4e334a47e7f8722793db5537db67a569/include/hal/dts-hal.sh#L65)
to make sure it appends command we are currently trying to run to a specific
file.

**Specifics**

1. Make `tool_wrapper` function append `<command> <command_args> <return_code>`
    to `/tmp/logs/profile`.
    - To make debugging easier create `/tmp/logs/debug_profile` which contains
      lines in format:
      `<script_file>:<script_line> <command> <command_args> <return_code>`
2. Generate profile for single platform and workflow
3. Modify E2E tests
    - Add generated profile to `open-source-firmware-validation/dts/profiles/`
    - Modify test for this platform and workflow and make it compare real
      profile with one generated after workflow finishes

Profile generated on real hardware can be accepted if workflow used to generate
it was successful e.g. there were no DTS errors, platform works after rebooting,
workflow assumptions are fulfilled e.g. firmware version changed to expected
one.

**Pros:**

* Little changes needed to implement

**Cons:**

* Generating profiles for all workflows and platforms might take a while
* Changes in DTS might force us to regenerate all profiles
