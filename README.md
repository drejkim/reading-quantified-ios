# reading-quantified-ios

An iOS app for [Reading Quantified](https://esthermakes.tech/projects/reading-quantified/).

## Related Projects

* [reading-quantified](https://github.com/drejkim/reading-quantified): A [Metabase](https://metabase.com/) dashboard for analyzing my reading habits
* [reading-quantified-server](https://github.com/drejkim/reading-quantified-server): A Django REST API server
* [reading-quantified-trello](https://github.com/drejkim/reading-quantified-trello): A client that interfaces w/ the Trello & Reading Quantified APIs

## Usage

Install gems:

```bash
bundle install --path=.gems
```

Install pods:

```bash
cd ReadingQuantified
bundle exec pod install
```

## Implementation Overview

This project is primarily a learning exercise in leveraging the latest frameworks & design patterns for creating iOS apps.

### Frameworks Used

* [Moya](https://moya.github.io/): Network abstraction layer written in Swift
* [Realm Database](https://realm.io/): A simple alternative to SQLite and Core Data
* [RxSwift & RxCocoa](https://github.com/ReactiveX/RxSwift): A Reactive programming framework for Swift & iOS
* [Swinject](https://github.com/Swinject/Swinject) & [SwinjectStoryboard](https://github.com/Swinject/SwinjectStoryboard): A dependency injection framework for Swift