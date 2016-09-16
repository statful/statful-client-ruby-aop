Statful client for Ruby applications using Aspect-Oriented Programming
==============

Statful client for Ruby applications using Aspect-Oriented Programming.

[![Build Status](https://travis-ci.org/statful/statful-client-ruby-aop.svg?branch=master)](https://travis-ci.org/statful/statful-client-ruby-aop)
[![Gem Version](https://badge.fury.io/rb/statful-client-aop.svg)](https://badge.fury.io/rb/statful-client-aop)

Staful client for Ruby usgin AOP. This client is intended to gather metrics and send them to Statful.

## Table of Contents

* [Supported Versions of Ruby](#supported-versions-of-ruby)
* [Installation](#installation)
* [Quick Start](#quick-start)
* [Examples](#examples)
* [Reference](#reference)
* [Development](#development)
* [Authors](#authors)
* [License](#license)

## Supported Versions of Ruby

| Tested Ruby versions  |
|:---|
|  `2.1.8`, `2.2.4`, `2.3.0` |

## Installation

```bash
$ gem install statful-client-aop
```

## Quick start

This gem requires a valid initialized statful client - refer to the [documentation](https://github.com/statful/statful-client-ruby) on how to do it.

```ruby
require 'statful-client-aop'

config = {
  :transport => 'http',
  :token => 'test_token',
}

statful = StatfulClient.new(config)
statful_aspects = StatfulAspects.new(statful)
```

## Examples

### Annotate method with a timer

Creates a simple client configuration and use it to send some metrics.

```ruby
# consider statful_aspects is an instance of the previously created StatfulAspects

class MyClass
  # measure how long my_method takes to execute in ms
  # save it as a metric timer called 'execution' with a custom tag
  statful_aspects.timer(self, 'my_method', 'execution', { :tags => {:host => 'test_host', :status => 'SUCCESS' } })
  def my_method
    # do stuff
  end
end
```

## Reference

Detailed reference if you want to take full advantage from Statful.

### Global configuration

The custom options that can be set on config param are detailed below.

| Option | Description | Type | Default | Required |
|:---|:---|:---|:---|:---|
| _statful_ | Initialized Statful client to be used on annotations. | `Object` | **none** | **YES** |

### Timer

```ruby
- staful_aspects.timer(myClass, 'my_method', 'my_metric_name', { :namespace => 'sandbox' });
```

Arguments for the `timer` method are much like the `timer` method from the Ruby client with the exceptions:

* the first argument is the class [`Object`] of the method to be annotated
* the second argument is the name [`String`] of the method to be annotated
* not possible to set a value for the timer

## Development

### Dependencies

Use bundle to install all dev dependencies:

```
$ bundle install
```

### Tests

It uses [rspec](http://rspec.info/) and [minitest](http://docs.seattlerb.org/minitest/) to specify the unit tests suite.

There's a rake task which runs the specs:

```
$ rake spec
```

### Build

Use gem to build a gem according to the spec if required:

```
$ gem build statful-client-aop.gemspec
```

### Docs

It uses [yard](http://yardoc.org/) to generate documentation.

There's a rake task which generates the doc directory with the output:

```
$ rake yard
```

## Authors

[Mindera - Software Craft](https://github.com/Mindera)

## License

Statful Client For Ruby using AOP is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/statful/statful-client-ruby/master/LICENSE) file for more information.
