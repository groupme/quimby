# John Mayer

It's a Foursquare API wrapper.

## Usage

Get a foursquare:

    foursquare = Foursquare.new("ACCESS_TOKEN")

Find a user:

    foursquare.users.find("USER_ID")

Find a checkin:

    foursquare.checkins.find("CHECKIN_ID")

Find a venue:

    foursquare.venues.find("VENUE_ID")

## Users

    user = foursquare.users.find("USER_ID")
    user.checkins
    user.