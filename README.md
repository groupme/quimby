# John Mayer

It's a Foursquare API wrapper.

## Usage

Get a foursquare:

    foursquare = Foursquare::Base.new("ACCESS_TOKEN")

Find a user:

    foursquare.users.find("USER_ID")

Find a checkin:

    foursquare.checkins.find("CHECKIN_ID")

Find a venue:

    foursquare.venues.find("VENUE_ID")

### Logging

If you want to see what's going on up in there, you can set `Foursquare.verbose` to `true`

    Foursquare.verbose = true

Right now it'll log to `STDOUT`. Maybe I'll add nicer logging later. If you're lucky.