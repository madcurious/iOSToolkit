# Bedrock

Bedrock is a library of boilerplate Swift code for building iOS apps.

## Installation

Clone the repository to your machine and manually add to your project only the files that you need. It's that simple.

As a historical note, Bedrock used to be packaged as a Swift framework and added as a git submodule, a setup that allowed me to update the framework as I worked on my projects and discovered my needs. However, my philosophy on dependencies, code ownership, and separation of concerns developed over time. I now believe that:

1. Less dependencies result in less complex codebases and project configurations, which can also dramatically reduce build times.
2. Projects (and therefore, its clients) should have its own sandbox of all the code that it runs. Code must be tailor-fit to the exact needs of the project and must not come with worrying about code or architecture breakage in other apps which are none of its business.
3. Programmers ought to focus on building the project at hand instead of building and maintaining a framework and its version control setup.

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
