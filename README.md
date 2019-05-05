# Rails Engine

## About

Rails Engine is a solo project during Module 3 at the Turing School of Software Design, Module 3. <a href="http://backend.turing.io/module3/projects/rails_engine">Project Specs</a>. The project learning goals are 

- Advanced ActiveRecord
- Single Responsibility controllers to provide a well-designed and versioned API
- Controller tests to drive design

Ruby on Rails and ActiveRecord were used to build a versioned JSON API with sales data. 

## Installation & Setup 

The program can run in development from the Rails server after following the following steps in your console:

* clone to a local repository using ` git clone git@github.com:chitasan/rails_engine.git`
* open the project directory with a text editor `cd rails_egine` and `code .` 
* install gem packages `bundle install`
* initialize the database with `rake db:{drop,create,migrate,seed}`
* import the CSVs with `rake import:{customers,merchants,invoices,items,invoice_items,transactions}`
* start the rails server with `rails s`
* on your browner, enter endpoints you want to see, ex: to see all merchants `http://localhost:3000/api/v1/merchants`

## Testing

The project uses <a href="https://github.com/colszowka/simplecov"> SimpleCov</a> and <a href="https://github.com/rspec/rspec"> RSpec</a> to test. 

`rspec` runs the tests.

## System Requirements

Ruby, version 2.4.1
Ruby on Rails, version 5.1.7.  

