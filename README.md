#Foundation-Server

##Dependencies
Ruby 2.2.2
Postgresql 9.4.0

If you don't have these already set up, you can do so [here] [1].

##Configuration

Clone this repo by running
`$ git clone https://github.com/motelis/foundation`

Be sure to have the latest Rails gem:
`gem install rails`

then
`bundle install`
`bundle update`

Run `cp .sample.env .env` to generate a copy of the env variables to replace with your local environment variables.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

[1]: https://github.com/thoughtbot/laptop
[2]: http://activeadmin.info/index.html
