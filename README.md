# Sinatra with Active Record: POST/PATCH/DELETE Requests Lab

## Learning Goals

- Handle non-`GET` requests in a controller
- Access data in the request body with the params hash
- Perform CRUD actions with Active Record from the controller

## Setup

In this application, we'll continue working on our JSON API for the bakeries
domain. As a reminder, here's what the ERD for these tables looks like:

![Bakeries ERD](https://curriculum-content.s3.amazonaws.com/phase-3/sinatra-with-active-record-get-lab/bakeries-baked_goods-erd.png)

To set up the application, run these commands:

```sh
bundle install
bundle exec rake db:migrate db:seed
```

You can run the app and explore your API in the Postman by using the custom Rake
task:

```sh
bundle exec rake server
```

## Instructions

This is a test-driven lab, so run the tests to get started! You'll be
responsible for building out the associations between the models, and then
working on adding routes to the `ApplicationController` for the different
endpoints described in the test spec.

You should also test your routes using Postman as you go in order to get a sense
of how to send data to and receive data from the server.

### Routes

Define routes that do the following:

`POST /baked_goods`: creates a new baked good in the database, and returns
data for the newly created baked good as JSON. The request will receive an object like this as params:

```json
{
  "name": "Lemon Poppyseed Muffin",
  "price": 3,
  "bakery_id": 1
}
```

`PATCH /bakeries/:id`: updates the name of the bakery in the database, and
returns data for the updated bakery as JSON. The request will receive an object
like this as params:

```json
{
  "name": "Northwestside Bakery"
}
```

`DELETE /baked_goods/:id`: deletes the baked_good from the database.

## Resources

- [Sinatra Routes](https://rubydoc.info/gems/sinatra#routes)
