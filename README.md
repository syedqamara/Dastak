# theDDERTAINER

[![CI Status](https://img.shields.io/travis/etDev24/theDDERTAINER.svg?style=flat)](https://travis-ci.org/etDev24/theDDERTAINER)
[![Version](https://img.shields.io/cocoapods/v/theDDERTAINER.svg?style=flat)](https://cocoapods.org/pods/theDDERTAINER)
[![License](https://img.shields.io/cocoapods/l/theDDERTAINER.svg?style=flat)](https://cocoapods.org/pods/theDDERTAINER)
[![Platform](https://img.shields.io/cocoapods/p/theDDERTAINER.svg?style=flat)](https://cocoapods.org/pods/theDDERTAINER)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

theDDERTAINER is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'theDDERTAINER'
```

## Import Rules.

### Public Accessable Classes.
Please import public accessible all classes in a single .h file which have same name as your module name.

For Example there is a module named `DDAuth`. It might contain `Login`,`Registration`,`ForgotPassword`,`Demographics` etc so instead of giving an overhead to user that he has to import 4 header files to use above four screen you should give him a single file named `DDAuth.h` which it self import all the necessory headers inside. 

## Author

etDev24, et_dev24@TheEntertainerMe.com

## License

theDDERTAINER is available under the MIT license. See the LICENSE file for more info.
