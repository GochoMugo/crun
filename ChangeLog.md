
# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).


## Unreleased


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
[0.0.0]:https://raw.githubusercontent.com/GochoMugo/crun/43d7201f07cabfb01fe68ba5ba68b5156db78c27/crun.sh
[0.1.0]:https://raw.githubusercontent.com/GochoMugo/crun/411cecc2423344226863fd84d1241b0eebe1ae24/crun.sh
[0.2.0]:https://raw.githubusercontent.com/GochoMugo/crun/4aacc7b2be57f1a467d2abc72f97d7b4ebfcd2a4/crun.sh
[0.2.1]:https://raw.githubusercontent.com/GochoMugo/crun/fddd4bdc3a3b73d988551529da2ba2cd8f6b566e/crun.sh
[0.3.0]:https://raw.githubusercontent.com/GochoMugo/crun/b37deaecfda33533f0e1a9333bef2e5bfece5c8b/crun.sh
[0.4.0]:https://raw.githubusercontent.com/GochoMugo/crun/4dfcaaf30ea7a2703f1168155e85dbb50a4f61c2/crun.sh
[0.5.0]:https://raw.githubusercontent.com/GochoMugo/crun/dade44e94e7cb153b004b6756d70f22ef8b4f2e5/crun.sh
