# Quimby

### Formerly named after a pop star whose lawyers decided they didn't like us using his name.

It's a Foursquare API wrapper. It uses objects instead of hashes, and tries to be smart about when to load things. 

## Installation

Install it as a gem (in your `Gemfile`)

    gem "quimby"

## Usage

Get a foursquare:

    foursquare = Foursquare::Base.new("ACCESS_TOKEN")

You can also user `client_id` and `client_secret`

    foursquare = Foursquare::Base.new("CLIENT_ID", "CLIENT_SECRET")
    
### Authentication

First, you need to [register your application](https://foursquare.com/oauth).

#### Web server application

Get a foursquare with your `client_id` and `client_secret`

    foursquare = Foursquare::Base.new("CLIENT_ID", "CLIENT_SECRET")
  
Redirect users to the Foursquare authentication page. You need to pass your `callback_url`. Get the url to redirect to with:

    foursquare.authorize_url("CALLBACK_SESSION_URL")
  
Then Foursquare will redirect the user to your callback url with a code parameter in the url. Exchange this code for an access token using:

    access_token = foursquare.access_token(params["code"], "CALLBACK_SESSION_URL")
    
Now you can get a foursquare using only an access token and make requests on user's behalf:

    foursquare = Foursquare::Base.new("ACCESS_TOKEN")

### Users

Find a user:

    user = foursquare.users.find("USER_ID")

Now we've got a `Foursquare::User` object. You can call sweet methods like `user.name` and even
`user.last_checkin`. **In general, John Mayer's Foursquare object methods are just snake-cased
versions of the attributes returned in the JSON.** Now let's accidentally that user's friends:

    user.friends

This will return an array of `Foursquare::User` objects. Don't worry about the fact that they're
populated by limited JSON. Quimby will fetch the extra JSON if you need it. For example:

    friend = user.friends.first
    friend.name # Will not trigger a network call, since we already have it
    friend.twitter # Will trigger a network to load the user's contact information

### Checkins

But wait, Foursquare isn't just users! It's checkins too! So let's find some checkins:

    user.checkins

Now we have an array of `Foursquare::Checkin` objects. We can also grab a specific checkin:

    checkin = foursquare.checkins.find("CHECKIN_ID")
    
You also have a convenient method if you want to get all the user checkins:

    user.all_checkins

### Venues

We can get at a checkin's venue by calling `checkin.venue`. Pretty easy, RIGHT? Right. If you want to
find a venue directly, here ya go:

    foursquare.venues.find("VENUE_ID")

You can also search venues:

    foursquare.venues.search(:ll => "40.7236307,-73.9999479") # Returns all resulting groups
    foursquare.venues.nearby(:ll => "40.7236307,-73.9999479") # Returns only nearby venues
    foursquare.venues.trending(:ll => "40.7236307,-73.9999479") # Returns only trending venues
    foursquare.venues.favorites(:ll => "40.7236307,-73.9999479") # Returns only favorite venues

The `:ll` option is required for venue searches. You can also feel free to pass any of the other
available Foursquare API options, as specified in the docs.

### Logging

If you want to see what's going on up in there, you can set `Foursquare.verbose` to `true`

    Foursquare.verbose = true

Right now it'll log to `STDOUT`. Maybe I'll add nicer logging later. If you're lucky. In the meantime,
if you want to use your own logger, and you're kind of a jerk like me, you can do something like this:

    Foursquare.verbose = true
    def Foursquare.log(message)
      Rails.logger.info("[foursquare] #{message}") # HAX, SORRY BRANDON
    end

## TODO

* Creating checkins works, but it should really return notifications. Also, if the
  checkin can't be created, it should return errors.
* I don't know, so much other stuff.