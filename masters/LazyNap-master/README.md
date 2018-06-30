# LazyNap

[![CI Status](http://img.shields.io/travis/3zcurdia/LazyNap.svg?style=flat)](https://travis-ci.org/3zcurdia/LazyNap)
[![Version](https://img.shields.io/cocoapods/v/LazyNap.svg?style=flat)](http://cocoapods.org/pods/LazyNap)
[![License](https://img.shields.io/cocoapods/l/LazyNap.svg?style=flat)](http://cocoapods.org/pods/LazyNap)
[![Platform](https://img.shields.io/cocoapods/p/LazyNap.svg?style=flat)](http://cocoapods.org/pods/LazyNap)

Network services layer designed to match RESTFUL endpoints and based on api conventions allowing to create a CRUD services per endpoint with minimal effort.

## Installation

LazyNap is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LazyNap'
```

## Setup

Even when LazyNap is based in convention over configuration principle, there are few things to setup.

### NapConfig Protocol

You must implement a structure or a class conforming the `NapConfig`  protocol where
it will be defined the base url and the session for your connections, among with the authentication structure
if needed.

```swift
public protocol NapConfig {
  var session: URLSession { get }
  var baseURL: URL { get }
  var auth: Authentication? { get }
}
```

#### Example

```swift
class Config: NapConfig {
    let session: URLSession
    let scheme: String
    let host: String
    let port: Int?
    var auth: Authentication?

    convenience init(session: URLSession) {
        self.init(session: session, scheme: "http", host: "localhost", port: 3000)
    }

    init(session: URLSession, scheme: String, host: String, port: Int) {
        self.session = session
        self.scheme = scheme
        self.host = host
        self.port = port
    }
}
```

### Identifiables Protocols

To parse and manage your request the models must be conforming the `Codable`  protocol from **Swfit 4.0**
- if the identificator for your REST services is an ***id*** iteger you must use the `Identifiable`  protocol.
- If the identificator for your REST services is  an  ***slug*** string you must use the `Slugable` protocol.

#### Example Identifiable

```swift
struct User: Identifiable, Codable {
  let id: Int?
  let name: String
  let email: String
  let role: String
}
```

#### Example Slugable

```swift
struct Group: Slugable {
  let slug: String?
  let name: String
}
```

## Usage

To initialize a service you must create an instance with the Codable you desire
to parse a config and the path where all the RESTFUL routes reside.


|   Method   |   URI Pattern   |   Action   |
|:-----------|:--------------- |:-----------|
| GET        |    /users       |  index     |
| POST       |    /users       |  create    |
| GET        |    /users/:id   |  show      |
| PUT        |    /users/:id   |  update    |
| DELETE     |    /users/:id   |  destroy   |


Then for each method you can call the correspondent action

### Example Unauthenticated

```swift
  let session = USRSession.shared
  let config = Config(session: session, scheme: "https", host: "example.com", port: 8080)
  let service = NapService<User>(config: config, path: "users")  

  service.index(completion: { (users, response) in
    // your code goes here...
  }, error: nil)
```

### Authentication

LazyNap has an authentication protocol, that allows params auth via token or with headers

```swift
public enum AuthMethod {
  case params
  case basicHeader
  case bearerHeader
}

public protocol Authentication {
  var method: AuthMethod { get }
  var token: String { get }
}
```

### Example Authenticated

```swift
struct Auth: Authentication {
  let method: AuthMethod
  var token: String
}
```

```swift
let session = USRSession.shared
let config = Config(session: session, scheme: "https", host: "example.com", port: 8080)
config.auth = Auth(method: .basicHeader, token: "secret-token-1234")
let service = NapService<User>(config: config, path: "users")  

service.index(completion: { (users, response) in
  // your code goes here...
}, error: nil)
```

**Note**: NapService internally implements `dataTask` other methods from `URLSession`  could be supported in the future.

## Contribute to the project

To contribute, just follow the next steps:

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* It is desired to add some tests for it.
* Make a Pull Request

## License

LazyNap is available under the MIT license. See the LICENSE file for more info.
