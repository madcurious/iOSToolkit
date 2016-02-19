![Mold](mold-banner.png)

# Mold

Mold is a library of boilerplate code for iOS apps written in Swift.

## Requirements

* Minimum target of iOS 8
* Xcode 7
* Swift 2.0

## Installation

Currently, Mold can only be added to an Xcode project as a git submodule.

```
$ cd MyApp
$ git submodule add https://github.com/mattquiros/Mold.git
```

Next steps:

* Open your Xcode project.
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

**IMPORTANT:** Updates often break source. I refactor a lot. I have no plans of providing a smooth upgrade path since that takes a lot of work and I have a life to live. This project is open-source simply to serve as a template--you may modify it as you wish. If you don't want updates to break your code, fork Mold to your Github account and `git clone` your fork instead.

## Usage

```
import Mold
```