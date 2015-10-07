class DashboardController < ApplicationController

  before_action :authenticate_user!

  

  def main
      if Survey.all.count == 0
        redirect_to new_survey_path
      end

      @locs = LocationRecord.last(5)
      @hash = Gmaps4rails.build_markers(@locs) do |loc, marker|
        marker.lat loc.latitude.round(4)
        marker.lng loc.longitude.round(4)
        marker.picture({
                          :url    => ActionController::Base.helpers.asset_path(loc.source == "gps" ? "gps_red2.png" : "gps_orange2.png"),
                          :width  => 24,
                          :height => 24
                        })
        marker.infowindow "#{ (loc.participant.name ? loc.participant.name : loc.participant.email) } <br/> #{DateTime.strptime((loc.date / 1000).to_s,'%s').in_time_zone("Auckland").strftime('%r')} <br/>Accuracy: #{loc.accuracy.to_i}m"
      end
  end

  def participants
    
  end

  

end