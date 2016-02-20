![Mold](mold-banner.png)

Mold is a Swift framework for iOS boilerplate code.

## Requirements

* Minimum target of iOS 8
* Xcode 7
* Swift 2.0

## IMPORTANT

Updates to Mold often break source. I refactor mercilessly. I have no plans of providing a smooth upgrade path since that takes a lot of work and I have a life to live. This project is open-source simply to serve as a starting template. You may modify it as you wish. In fact, you're expected to.

If you don't want updates to break your code, fork Mold to your Github account and `git clone` your fork instead.

## Installation

Currently, Mold can only be added to an Xcode project as a git submodule.

```
$ cd MyApp
$ git submodule add https://github.com/mattquiros/Mold.git
```

Next:

* Open your app's Xcode project.
* Expand the folder where you cloned Mold.
* In the `Mold` group, keep only `Mold.xcodeproj` and remove references to the following files, **but DO NOT move them to the Trash:**
    * .gitignore
    * Mold/
    * Mold/README.md
* In the project target's *Build Phases > Target Dependencies*, click on the plus sign and add `Mold.framework`.
* In the project target's *General* tab, scroll to `Embedded Binaries`, click on the plus sign, and add `Mold.framework`.

Updating is simply a matter of going to the Mold folder and doing a `git pull` on the `master` branch.

```
$ cd MyApp/Mold
$ git pull
```

## Usage and Features

To use Mold in a Swift file, just import.

```
import Mold
```

### Error Handling

`MDError` subclasses `NSError` to make it easy to create an error object by just providing an error message.

```
let error = MDError("Invalid email and password.")
```

`MDErrorType` extends the `ErrorType` protocol and has a function `object()` where you return an `MDError` representation of your error enum case. This solves the problem where if you `throw` an `ErrorType` and cast it to `NSError`, you lose the `userInfo`.

```
enum ParseError: MDErrorType {
    case CantParseJSON

    func object() -> MDError {
        switch self {
        case .CantParseJSON:
            return MDError("Failed to parse JSON.")
        }
    }
}

try {
    parseJSON()
} catch {
    guard let customError = error as? MDErrorType
        else {
            print("error: \(error.description)")
    }
    print("error: \(error.message)")
}
```

### Stateful Operations

### Stateful View Controllers

### File Storage with Swift Value Types

### Main Thread Dispatcher

### Forms

### Useful Extensions

### ...And many more!

See the wiki for the complete documentation.

## License

Mold is released under the MIT License. See LICENSE for details.