# Apple Logger

This is an open-source command-line tool to write to Apple's Unified Logging
interface.  It's very small and simple and easy to read.  It's shorter than
this README.

It takes logs from stdin and writes them to the platform's logging interface
using the subsystem ID of your choice.

It is **not** endorsed by or written by Apple.  It is named because of the
Apple-created interface it logs to.

## Usage

For example, to log a single message from a shell script:

```sh
echo "This is a log message" | ./apple-logger com.myappname
```

Or if you want to stream many logs from an app:

```sh
my_app | ./apple-logger com.myappname
```

In these examples, `com.myappname` is an arbitrary subsystem ID.  You can use
this to look up your logs later using Apple's built-in tools:

```sh
log show --info --style=compact \
    --predicate 'subsystem=="com.myappname"' \
    --last 1d
```

All logs are written at "info" severity level, and by default, the "category"
is set to the word "default".  You can change that category with a second
argument to the logger:

```sh
echo "This is a log message" | ./apple-logger com.myappname mycategory
```

You can filter on categories with something like:

```sh
log show --info --style=compact \
    --predicate 'subsystem=="com.myappname" AND category=="mycategory"' \
    --last 1d
```

## Compilation

```sh
swiftc apple-logger.swift
```

## Alternatives

I really couldn't find a single command-line utility for this in late 2023.  I
may have overlooked some.  :shrug:

With Apple having introduced these APIs in 2016 from what I can tell, I was
shocked not to find a "unixy" utility for this.  So I wrote this one.

One alternative that's built-in is to use the standard unixy command line
utility `logger`, however, this doesn't let you set a subsystem ID.  You can
really only filter based on the process name, which would be `logger`, and you
would have to set appropriate prefixes on all your log lines.  I found this
cluttered the logs and was hard to use for filtering and logging of multiple
services.
