# Train Station CLI: Flatiron Module 1 Project

A CLI application making use of ActiveRecord, SQLite, and OO Ruby.

## Installation

The following Ruby Gems, via rubygems.org, were used for this project:

```bash
gem 'activerecord', '~> 5.0'
gem "sinatra-activerecord"
gem "sqlite3"
gem "pry"
gem "require_all"
gem "faker"
gem 'artii', '~> 2.1', '>= 2.1.2'
gem 'tty-prompt'
gem 'rainbow'
gem 'tty-progressbar'
gem 'tty-spinner'
gem 'table_print'
```

Please see the Gemfile for reference.

## Usage

Run the following command from the main project directory to launch the CLI. Follow the desired commands.

```ruby
ruby bin/run.rb
```

## Project Requirements
- Ruby
- Object Orientation
- Relationships (via ActiveRecord)
- Problem Solving (via creating a Command Line Interface (CLI))

1. Contains at least three models with corresponding tables, including a join table.
2. Accesses a Sqlite3 database using ActiveRecord.
3. Has a CLI that allows users to interact with your database as defined by your _user stories_ (minimum of four; one for each CRUD action).
4. Uses good OO design patterns. You should have separate models for your runner and CLI interface.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)