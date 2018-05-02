<div align="center"><img src="./Sources/Lib/Html/XcodeTestReporter.svg" height="80px"></div>
====

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)
[![Build Status](https://travis-ci.org/taisukeh/xcode-test-reporter.svg?branch=master)](https://travis-ci.org/taisukeh/xcode-test-reporter)
![apm](https://img.shields.io/apm/l/vim-mode.svg)
![platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)

The `Xcode Test Reporter` generates JUnit or HTML report from Xcode `plist` test report files.

## Prerequisites

Supported platforms:
- macOS 10.12 (High Sierra) or higher

## Installing

You can use Homebrew:
```
brew tap taisukeh/xcode-test-reporter
brew install xcode-test-reporter
```

Or download from [GitHub releases](https://github.com/taisukeh/xcode-test-reporter/releases).

## Usage

You can use as follows:
```
xcode-test-reporter --format html,junit --path ~/Library/Developer/Xcode/DerivedData/MyApp-*/Logs/Test  --output-directory myreport
```

Options:
- `path`: Path containing the plist files. Current directory by default.
- `output-directory`: Directoy in which the report files should be written to.  Same directory as source by default.
- `format`: The report format to output for (one of 'html', 'junit', or comma-separated values). JUnit by default.


## VS.

- [trainer](https://github.com/KrauseFx/trainer) - `trainer` is developed by @KrauseFx who is the author of [fastlane](https://github.com/KrauseFx/trainer), and it works well fastlane. `Xcode Test Reporter` can generate HTML report while `trainer` can generate only JUnit report.

## Contributing

Iusses or PRs are welcome.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **HORI Taisuke** - *Initial work* - [taisukeh](https://github.com/taisukeh)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
