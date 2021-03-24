# DDAnalytics

[![CI Status](https://img.shields.io/travis/etDev24/DDAnalytics.svg?style=flat)](https://travis-ci.org/etDev24/DDAnalytics)
[![Version](https://img.shields.io/cocoapods/v/DDAnalytics.svg?style=flat)](https://cocoapods.org/pods/DDAnalytics)
[![License](https://img.shields.io/cocoapods/l/DDAnalytics.svg?style=flat)](https://cocoapods.org/pods/DDAnalytics)
[![Platform](https://img.shields.io/cocoapods/p/DDAnalytics.svg?style=flat)](https://cocoapods.org/pods/DDAnalytics)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DDAnalytics is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DDAnalytics'
```

## Usage
To use `DDAnalytics` you need to create an object of `DDEventTracker` this class is the key responsible for managing analytics.
Currently `DDAnalytics` support following types of events.
```
DDEventTypeBranch
DDEventTypeCustom
DDEventTypeFB
DDEventTypeBraze
DDEventTypeFirebase
```
`DDAnalytics` pod doesn't post any analytics to server neither on Custom nor on any third party like facebook & braze.

## How to track event?
After creating object of `DDEventTracker` store it some where in your own singleton class or you can use `DDAnalyticsManager` for creating & retain `DDEventTracker`

### Fetch & Get `DDEventTracker`
```
//To create object use bellow method.
[DDAnalyticsManager.shared addEventWithCompany:@"some_company_for_event_tracking"];

//To access above created object you can use bellow line.
[DDAnalyticsManager.shared eventForCompany:@"some_company_for_event_tracking"];
```

### Event Tracking
To track any event you must have an object of `DDEventTracker` with that object you can track any event.

## Author

etDev24, et_dev24@ThedynamicdeliveryMe.com

## License

DDAnalytics is available under the MIT license. See the LICENSE file for more info.
