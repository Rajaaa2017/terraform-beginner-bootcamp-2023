# Terraform Beginner Bootcamp 2023 - Week2

## Working with Ruby

### Bundler

Bundler is a package manager for Ruby. It is the primary way to install Ruby packages, known as gems, for Ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command.

This will install the gems on the system globally. (unlike Node.js, which installs packages in a folder called 'node_modules')

A 'Gemfile.lock' will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to instruct future Ruby scripts to use the gems we installed. This is how we set the context.

### Sinatra

Sinatra is a micro web framework for Ruby used to build web apps.

It's great for mock or development servers and for very simple projects.

You can create a web server in a single file.

[Sinatra](https://sinatrarb.com/)

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.