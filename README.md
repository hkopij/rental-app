HERTZ

In this exercise we'll be building a car rental app. Some basic models and
migrations are already in place as a starting point/suggestion of the direction
of further development. Those models are:

- User
- Office
- Car

There's also an authorization flow implemented.

We'll be working under following assumptions:

1) There 3 user roles: Owner, Clerk, Customer
  - Owner can have many offices
  - Clerk works in a single office only, but an Office can have many Clerks
  - Customer can rent no more than one car at the same time from any office
2) All users can sign in to the application but have different access permissions:
  - The owner can do anything in any office
  - The clerk can only handle rentals in their office
  - The customer can handle only their own rentals
3) A rental should be implemented in a way that allows to:
  - make sure a Car is not rented to more than one person at the same time
  - list all office rentals, current and past
  - list all rentals for a given Customer
  - list all rentals done by a given Clerk (we need to know who's slacking off :) )
  - list all rentals for a given car

The user story I want us to implement is:

As a signed-in Clerk or Owner I want to be able to perform a rental by assigning
an available car from the current office's pool to a customer

Because we're working on a JSON API app, there's obviously no frontend input. Let's
assume the frontend devs are willing to build forms to our specifications - in other
words, they'll deliver what we tell them to :)






