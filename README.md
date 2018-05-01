<div align="center"><img src="./Sources/Lib/Html/XcodeTestReporter.svg" height="80px"></div>
====

The `Xcode Test Reporter` generates JUnit or HTML report from Xcode `plist` test report files.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Supported platforms:
- macOS 10.12 (High Sierra) or higher

### Installing

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

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
