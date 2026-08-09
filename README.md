## am-utils

Suite of static binaries for GNU/Linux, built on top of Debian Unstable, using [quick-sharun](https://github.com/pkgforge-dev/Anylinux-AppImages).

Supported architectures:
- [x86_64](https://github.com/ivan-hc/am-utils/releases/tag/continuous-x86_64)
- [aarch64](https://github.com/ivan-hc/am-utils/releases/tag/continuous-aarch64)

------------------------------------------------------------------------

## Motivation

This suite was created to provide the AM package manager with a set of "temporary" dependencies that can be used as a fallback for the correct functioning of AM if the user does not have the necessary commands installed on the host system.

This led to the idea of ​​increasing the number of core programs to cover more needs.

## Limitations

These binaries are based on Debian Unstable. Although they are static, not all are fully compatible with FreeBSD and derivatives.

**Any improvement is welcome.**

------------------------------------------------------------------------

## Fallback Dependencies in [AM](https://github.com/ivan-hc/AM) and [AppMan](https://github.com/ivan-hc/AppMan)

When using the AM/AppMan package manager, you'll likely be prompted to install or temporarily download the missing commands if there are any missing dependencies.

If you decide to use them temporarily, AM/AppMan will temporarily cache them in a temporary directory that will be used as $PATH for their execution while using AM/AppMan.

With the `-c` or `clean` option, this directory will be emptied, and the next time you use it, you'll be prompted again to download the missing dependencies.

### Set amdeps_on=true to download fallback dependencies not interactively

Sometimes these commands are required for automatic processes to function correctly, and responding to the prompt becomes a bit difficult. And having them downloaded continuously every time you use `-c` in AM/AppMan can get annoying.

To resolve this, simply export the `$amdeps_on` variable to `true`, like this:
```
export amdeps_on=true=true
```
This way, AM/AppMan will download these fallback commands without prompting.

NOTE: It's best to install these commands from your system package manager rather than using temporary static binaries as a fallback. This repository doesn't update its binaries often, and only makes them available when absolutely necessary.

------------------------------------------------------------------------

## Install and update them all with ease

### *"*AM*" Application Manager* 
#### *Package manager, database & solutions for all AppImages and portable apps for GNU/Linux!*

[![sample.png](https://raw.githubusercontent.com/ivan-hc/AM/main/sample/sample.png)](https://github.com/ivan-hc/AM)

[![Readme](https://img.shields.io/github/stars/ivan-hc/AM?label=%E2%AD%90&style=for-the-badge)](https://github.com/ivan-hc/AM/stargazers) [![Readme](https://img.shields.io/github/license/ivan-hc/AM?label=&style=for-the-badge)](https://github.com/ivan-hc/AM/blob/main/LICENSE)

*"AM"/"AppMan" is a set of scripts and modules for installing, updating, and managing AppImage packages and other portable formats, in the same way that APT manages DEBs packages, DNF the RPMs, and so on... using a large database of Shell scripts inspired by the Arch User Repository, each dedicated to an app or set of applications.*

*The engine of "AM"/"AppMan" is the "APP-MANAGER" script which, depending on how you install or rename it, allows you to install apps system-wide (for a single system administrator) or locally (for each user).*

*"AM"/"AppMan" aims to be the default package manager for all AppImage packages, giving them a home to stay.*

*You can consult the entire **list of managed apps** at [**portable-linux-apps.github.io/apps**](https://portable-linux-apps.github.io/apps).*

## *Go to *https://github.com/ivan-hc/AM* for more!*

------------------------------------------------------------------------

| [***Install "AM"***](https://github.com/ivan-hc/AM) | [***See all available apps***](https://portable-linux-apps.github.io) | [***Support me on ko-fi.com***](https://ko-fi.com/IvanAlexHC) | [***Support me on PayPal.me***](https://paypal.me/IvanAlexHC) |
| - | - | - | - |

------------------------------------------------------------------------
