![Romit](https://dl.dropboxusercontent.com/u/36906193/websol/logo_romit.gif)

[ ![Codeship Status for AlexBelov/romit](https://codeship.com/projects/88f1fd30-115b-0134-8e80-3e3a95c3b5c9/status?branch=master)](https://codeship.com/projects/157239)
[![Code Climate](https://codeclimate.com/github/AlexBelov/romit/badges/gpa.svg)](https://codeclimate.com/github/AlexBelov/romit)
[![Test Coverage](https://codeclimate.com/github/AlexBelov/romit/badges/coverage.svg)](https://codeclimate.com/github/AlexBelov/romit/coverage)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/1c581319e3a2482eac5f445b89c0b50c)](https://www.codacy.com/app/git_11/romit?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=AlexBelov/romit&amp;utm_campaign=Badge_Grade)
[![Gem Version](https://badge.fury.io/rb/romit.svg)](https://badge.fury.io/rb/romit)

The Romit Ruby bindings provide a small SDK for convenient access to the Romit API from applications written in the Ruby language. It provides a pre-defined set of classes for API resources that initialize themselves dynamically from API responses.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'romit'
```

## Configuration

```ruby
Romit.api_base = 'https://api.sandbox.romit.io/v1'
Romit.client_key = 'your client key'
Romit.client_secret = 'your client secret key'
```

## Usage

To start working with Romit, please define place to store Romit member's access and refresh keys. Something like this class (can be ActiveRecord model):

```ruby
class ExampleToken
  attr_reader :romit_access_token, :romit_refresh_token
  attr_accessor :romit_access_token_expires, :romit_refresh_token_expires

  def save_access_token(token)
    # saving access_token and expiration to database
    # token structure:
    # {
    #   type: token_type,
    #   token: 'token',
    #   expires: date
    # }
  end

  def save_refresh_token(token)
    #saving refresh_token and expiration to database
  end
end
```

Then you're able to make Romit requests:

```ruby
romit = Romit::Member.new(your_model)
romit.transfer.list
romit.banking.list
romit.user.retrieve
```

And so on, check [Romit API docs](http://docs.romit.io/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AlexBelov/romit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
