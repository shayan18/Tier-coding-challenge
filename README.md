<a href="https://codeclimate.com/github/shayan18/Tier-coding-challenge/maintainability"><img src="https://api.codeclimate.com/v1/badges/903ff241bc8aab0d34be/maintainability" /></a>
<a href="https://codeclimate.com/github/shayan18/Tier-coding-challenge/test_coverage"><img src="https://api.codeclimate.com/v1/badges/903ff241bc8aab0d34be/test_coverage" /></a>

# Tier-coding-challenge

## Goal
Create an app that allows users to visualize the scooters on a map in an optimal way (eg. markers, clustering), and display the details of the vehicle (eg. in a bottom sheet) closest to the user's location. Feel free to add any feature that you feel is relevant to the use case.

## Prereqs

- Xcode 13.4.1
- iOS 13+

## Demo
![](demo.gif)

## Usage
```
Just open the project in Xcode 13+ and let SwiftPM do it's magic. :)
```
## Features
- App is consist of single Map view showing vehicles. Tap on one of the pins to see more details of the vehicle.
- Clusting is used to cluster pins.

## Overall Architecture

App is based on **MVVM** architecture. Structure is broken down by the general purpose of contained source files. Below are the dependencies used in the project

- [ApiClient](https://github.com/shayan18/ApiClient-iOS) : Networking swift package for the app.
- [Toast](https://github.com/scalessec/Toast-Swift) : Used to show alerts
- [Microya](https://github.com/FlineDev/Microya) : Light weight inspired version of Moya.

## Tools
- [SwiftGen](https://github.com/SwiftGen/SwiftGen)
- [Phrase](https://phrase.com/) for managing translations
- [GitHub actions](https://github.com/shayan18/Tier-coding-challenge/actions) GitHub actions are used for continuous integration with custom runners powered by [MacStadium](https://www.macstadium.com/)
- [Code-Climate](https://codeclimate.com/) drive continuous improvement with the leading Engineering Intelligence Solution.
- [Fastlane](https://fastlane.tools/) used for continous delivery.


## Unit Testing

App is using XCTest for unit tests.

## Code-Climate report
[https://codeclimate.com/github/shayan18/Tier-coding-challenge](report)

## Decision made because of restricted time/improvements with more time:
- Modularization (create separate swift packages for Models/Extensions/components)
- Implementation of Snapshot tests for UI.
- Implementation of Unit and UI testing but i tried to write as much testable code as possible.
- Add more tracking tools i.e Instabug/MixPanel

