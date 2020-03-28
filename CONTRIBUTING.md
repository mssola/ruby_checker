# Contributing to ruby_checker

## Running tests

First of all, make sure that you have all the dependencies. In order to do that,
simply run:

```bash
$ bundle
```

After that, running tests is as easy as doing the following:

```bash
$ rake
```

Unit tests are located inside of the `tests` directory and they are using
[minitest](https://github.com/seattlerb/minitest).

Note that this will also run other checkers. More on that later.

### Checking the style

This project uses [rubocop](https://github.com/rubocop-hq/rubocop) in order to
check the style of the Ruby code. So, in order to check the style just run:

```bash
$ bundle exec rubocop
```

### Git validation

In order to ensure that the git log is as maintainable as possible, the
[git-validation](https://github.com/vbatts/git-validation) tool is used. You can
install this tool by running:

```bash
$ go get -u github.com/vbatts/git-validation
```

If you already have this tool installed, then simply perform:

```bash
$ rake git-validation
```

Note that if you don't have this tool installed the task will do nothing (it
will just print a help message). This is done so when running the default make
task this doesn't interrupt it.

## Issue reporting

I'm using [Github](https://github.com/mssola/ruby_checker) in order to host the
code. Thus, in order to report issues you can do it on its [issue
tracker](https://github.com/mssola/writer-mode/issues). A couple of notes on
reports:

- Check that the issue has not already been reported or fixed in `master`.
- Try to be concise and precise in your description of the problem.
- Provide a step by step guide on how to reproduce this problem.
- Provide the version you are using (the commit SHA, if possible), and the
version of related dependencies, as well as the version of the GNU Emacs you are
using and the operating system.

## Pull requests

- Write a [good commit message](https://chris.beams.io/posts/git-commit/).
- Make sure that tests are passing on your local machine (it will also be
checked by the CI system whenever you submit the pull request).
- Update the [changelog](./CHANGELOG.md).
- Try to use the same coding conventions as used in this project.
- Open a pull request with *only* one subject and a clear title and
description. Refrain from submitting pull requests with tons of different
unrelated commits.
