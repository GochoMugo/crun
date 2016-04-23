# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).


## Unreleased


## [0.6.0][0.6.0] - 29/03/2016

Changed:

* use `${CRUN_DO_EVAL}`/`--do-eval` to enable evaluation of the bash string (issue #6)


## [0.5.0][0.5.0] - 18/03/2016

Added:

* use `-fc, --force-compile` to force compilation of the script (issue #4)
* use `-jc, --just-compile` for compiling script without running (issue #5)


## [0.4.0][0.4.0] - 27/02/2016

Added:

* maintain line numbers (issue #3)


## [0.3.0][0.3.0] - 13/02/2016

Added:

* add `--create` and `--create-force` for creating template scripts


## [0.2.1][0.2.1] - 5/02/2016

Fixed:

* compile in the directory holding the script


## [0.2.0][0.2.0] - 5/02/2016

Added:

* allow configuring the cache/out directory (issue #2)

Fixed:

* fix using globs in the CC_FLAGS e.g. `/* ../deps/*/*.c */`
* fix unquoted path variable


## [0.1.0][0.1.0] - 4/02/2016

Added:

* allow detecting source code on 2nd line (issue #1)

Fixed:

* fix unquoted path variables, susceptible to splitting and globbing


## [0.0.0][0.0.0] - 20/01/2016

This is the very first version of `crun`.


<!-- Release links are placed here for easier updating -->
[0.0.0]:https://github.com/GochoMugo/crun/releases/tag/v0.0.0
[0.1.0]:https://github.com/GochoMugo/crun/releases/tag/v0.1.0
[0.2.0]:https://github.com/GochoMugo/crun/releases/tag/v0.2.0
[0.2.1]:https://github.com/GochoMugo/crun/releases/tag/v0.2.1
[0.3.0]:https://github.com/GochoMugo/crun/releases/tag/v0.3.0
[0.4.0]:https://github.com/GochoMugo/crun/releases/tag/v0.4.0
[0.5.0]:https://github.com/GochoMugo/crun/releases/tag/v0.5.0
[0.6.0]:https://github.com/GochoMugo/crun/releases/tag/v0.6.0
