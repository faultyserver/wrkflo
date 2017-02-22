# Wrkflo

`wrkflo` is a Ruby Gem that helps you get working on things faster with
predefined wrkflos.

## Requirements

At present `wrkflo` is MacOS dependent and requires Ruby >= 2.2.0.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wrkflo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wrkflo

## Usage

The [.wrkflorc.example](.wrkflorc.example) file contains a simple `wrkflo`
example that:
1. Locally mounts a specific directory on a remote file system.
2. Opens a terminal window and an ssh session into that remote directory.
3. Opens a local instance of the [Sublime](https://www.sublimetext.com/) editor
in the locally mounted remote directory.

To setup the work environment for `my_site` just copy the example file into
place with `cp .wrkflorc.example ~/.wrkflorc` and run `wrkflo my_site`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

GitHub's guide for
[Contributing to Open Source](https://guides.github.com/activities/contributing-to-open-source/)
offer's the best advice.

#### tl;dr
1. [Fork it](https://help.github.com/articles/fork-a-repo/)!
1. Create your feature branch: `git checkout -b cool-new-feature`
1. Commit your changes: `git commit -am 'Added a cool feature'`
1. Push to the branch: `git push origin cool-new-feature`
1. [Create new Pull Request](https://help.github.com/articles/creating-a-pull-request/).

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
