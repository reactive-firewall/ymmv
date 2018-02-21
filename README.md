# About #
This repo is basically my template for new bash repos/projects

# CI Template #

By default this template will assume that the Travis CI Service is used for CI/CD

# Status #

### master ###
[![status](https://travis-ci.org/reactive-firewall/bash-repo.svg?branch=master)](https://travis-ci.org/reactive-firewall/bash-repo)
[![code coverage](https://codecov.io/gh/reactive-firewall/bash-repo/branch/master/graph/badge.svg)](https://codecov.io/gh/reactive-firewall/bash-repo/branch/master/)

### Stable ###
[![status](https://travis-ci.org/reactive-firewall/bash-repo.svg?branch=stable)](https://travis-ci.org/reactive-firewall/bash-repo)
[![code coverage](https://codecov.io/gh/reactive-firewall/bash-repo/branch/stable/graph/badge.svg)](https://codecov.io/gh/reactive-firewall/bash-repo/branch/stable/)

# How do I use this to create a new project repo? #

(assuming new project is already forked on github to `MY-NEW-REPO`)

```bash
# cd /MY-AWSOME-DEV-PATH
git clone https://github.com/reactive-firewall/MY-NEW-REPO.git MY-NEW-REPO
# cd ./MY-NEW-REPO
```

# Dev Testing Template #

In a rush? Then use this:

```bash
make clean ; # cleans up from any previous tests hopefully
make test ; # runs the tests
make clean ; # cleans up for next test
```

# Example Usage Template #

Want to use the Example `speed_test.bash` script then try this:

### Running... ###

```bash
speed_test.bash
```

### ...Outputs ###

```plain
Local:  4620K
Server: 1472K
```

# Example installing Template #

The following describes how to install the example script:

### Download... ###

```bash
cd /tmp
git clone https://github.com/reactive-firewall/bash-repo.git bash-repo
cd ./bash-repo
make clean
```

### ...install ###

(might need sudo)

```bash
make install
```

### ...uninstall ###

uninstall is similar

```bash
make uninstall
```

# License - MIT

## Copyright (c) 2017 Mr. Walls
### 
### THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
### IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
### FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
### AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
### LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
### OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
### SOFTWARE.
###
### Permission is hereby granted, free of charge, to any person obtaining a copy
### of this software and associated documentation files (the "Software"), to deal
### in the Software without restriction, including without limitation the rights
### to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
### copies of the Software, and to permit persons to whom the Software is
### furnished to do so, subject to the following conditions:
###
### The above copyright notice and this permission notice shall be included in all
### copies or substantial portions of the Software.

## USE AT OWN RISK.

