# Bedrock

Bedrock is a Swift framework of boilerplate code for building iOS apps.

**IMPORTANT:** As this framework is built for my personal use, updates break source and I have no plans of providing a smooth upgrade path. If you wish to use this library as a template, fork it and then clone your fork instead.

## Installation

Bedrock can be added to an Xcode project as a git submodule.

```
$ cd YOUR_APP_FOLDER
$ git submodule add https://github.com/mattquiros/Bedrock.git
```

Next:

* Open your app's Xcode project.
* Add `Bedrock.xcodeproj` to your app's Xcode project.
* Go to your main target's `Build Phases`.
* In `Link Binary With Libraries` and `Embed Frameworks`, add `Bedrock.framework`.

Updating is simply a matter of going to the Bedrock folder and doing a `git pull` on the `master` branch.

```
$ cd MyApp/Bedrock
$ git pull
```

To use Bedrock in a Swift file, just import.

```
import Bedrock
```

## License

The MIT License (MIT)

Copyright (c) [2016] [Matt Quiros]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
