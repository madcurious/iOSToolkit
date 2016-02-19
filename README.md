# Mold

Mold is a library of boilerplate code for iOS apps written in Swift.

## Installation

Currently, Mold can only be added to an Xcode project as a git submodule.

```
$ cd MyApp
$ git submodule add https://github.com/mattquiros/Mold.git
```

Next steps:

* Open your Xcode project.
* Expand the folder where you cloned Mold.
* In the top-level `Mold` folder, keep only the `.xcodeproj` and remove references to the following files, **but DO NOT move them to the Trash:**
* .gitignore
* Mold (folder)
* In the project target's *Build Phases > Target Dependencies*, click on the plus sign and add `Mold.framework`.
* In the project target's *General* tab, scroll to `Embedded Binaries`, click on the plus sign, and add `Mold.framework`.