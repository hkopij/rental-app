HERTZ

In this exercise you'll be building a car rental app - a simple JSON-based API
that implements basic JWT authentication, user roles and several associated
database models.

GENRAL SETUP

The app is `dockerized` - it has functional `Dockerfile` and `docker-compose.yml` files.
If you're familiar with Docker, you can probably skip this section. If you're not,
we strongly encourage you to read about containers in general and Docker in
particular, as it is an everyday tool in our backend development.

Using Docker for the purposes of this task is optional, if it's too much for you,
you can set the app up the regular way. The database we use is PostgreSQL, so we
recommend you use it as well.

THE APP

The app itself is a typical Rails API, which means it does not have any frontend
assets part or views - all responses rendered in controller actions are JSONs.
The authentication is handled by generating JWT tokens which are then attached in the request's
header. All the work is done by the preinstalled gem [Knock](https://github.com/nsarno/knock), which
handles everything out of the box and adds the `current_user` helper in all controllers it's
used in.

The tl;dr version of JWT flow is - user submits email and password to the sign-in endpoint,
the endpoint returns a `token`, that is then attached to every subsequent request's
`Authorization` header and used to authorize the request's maker.

Some basic models and migrations are already in place as a starting point/suggestion
of the direction of further development. These models are:

- User
- Office
- Car

All these models have some columns in the database - you don't have to use all or any of them,
it's just a suggestion as to how they could behave. Feel free to implement your own
fields if desired/necessary.

THE GOAL

The goal of this task is to create an API endpoint, available only to a signed-in
Owner, that allows them to assign an `available` (not being rented at the time)
car to a Customer by passing their IDs and the rental time. The car being rented
 MUST belong to the Owner's office and it MUST be available (not already rented to
  someone else), so you'll have to implement some kind of validation for both of these cases.

Additionally the User needs to have 2 separate roles implemented:
- The Owner, who runs a single office and `cannot` rent cars him/herself,
- The Customer, who can rent cars from any office, but cannot have Owner's access privileges.

There are multiple ways to achieve that separation, use any you want, just remember that
all Users need to use the same database table and the User model as it employs the
`has_secure_password` method used for authentication.

In bullet points:
- Implement user authentication in a rentals controller
- Implement 2 separate User roles: Owner and Customer
- Owner has one office and can assign its cars to any eligible Customer
- Customer can be assigned to any car that is not currently rented
- Success response contains serialized customer, rental and car data
- Error responses have 422 status code and error messages.

SPECS

The entire flow is covered by a spec file in the RSPec `/spec` folder, that has to pass all green
- it will require you to add some models, routes and controllers to the application and some
FactoryBot factories as well. However please don't change the specs themselves (specs
being the `it { }` blocks), as they test the correctness of your implementation.










