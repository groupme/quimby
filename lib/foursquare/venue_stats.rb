# This class taken from the fourmer gem, using the Trash hash in order to make Ruby style property values
module Foursquare
  class VenueStats < Hashie::Trash
    property :sharing
    property :total_checkins,         :from => :totalCheckins
    property :new_checkins,           :from => :newCheckins
    property :unique_visitors,        :from => :uniqueVisitors
    property :gender_breakdown,       :from => :genderBreakdown
    property :age_breakdown,          :from => :ageBreakdown
    property :hour_breakdown,         :from => :hourBreakdown
    property :visit_count_histogram,  :from => :visitCountHistogram
    property :top_visitors,           :from => :topVisitors
    property :recent_visitors,        :from => :recentVisitors
  end
end