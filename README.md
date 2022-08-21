# Setup development environment
Setup development environment with Makefile for Ubuntu.

## Getting started
```bash
# 1. Install all
$ make install

# 2. Reload shell
$ exec $SHELL -l

# 3. Check all installed software versions
$ make version
```

## Usage
```
Usage: make [task] ...
Tasks:
  help            Display usage (default task)
  install         Run all install tasks
  uninstall       Run all uninstall tasks
  version         Display all installed versions
  sdkman          Install sdkman and latest SDKs(Java, Kotlin, Gradle)
  fnm             Install fnm and latest Node.js
  docker          Install docker and compose plugin
  go              Install latest golang
  rust            Install latest rust with rustup
```

## Add new task

```bash
# Create <TASK_NAME>.mk file from skelton
$ make tasks/<TASK_NAME>.mk
# ... Edit new <TASK_NAME>.mk file ...
```
