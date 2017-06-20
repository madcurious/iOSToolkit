![Mold](mold-banner.png)

Mold is a Swift 4 framework of boilerplate code for iOS apps.

## IMPORTANT

Updates to Mold often break source. I refactor mercilessly. I have no plans of providing a smooth upgrade path since that takes a lot of work and I have a life to live. This project is open-source simply to serve as a starting template. You may modify it as you wish.

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

To use Mold in a Swift file, just import.

```
import Mold
```

## License

Mold is released under the MIT License. See LICENSE for details.
