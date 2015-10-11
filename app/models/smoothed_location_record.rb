class SmoothedLocationRecord

  def average_latitude
    tot_lat = 0
    @raw_locations.each do |r|
      tot_lat += r.latitude
    end
    return tot_lat / @raw_locations.length
  end

  def average_longitude
    tot_lon = 0
    @raw_locations.each do |r|
      tot_lon += r.longitude
    end
    return tot_lon / @raw_locations.length
  end

  def first
    return @raw_locations.first
  end

  def last
    return @raw_locations.last

  end

  def count
    return @raw_locations.length
  end


  def add(location_record)
    if @raw_locations == nil
      @raw_locations = Array.new
    end
    @raw_locations << location_record
  end

end