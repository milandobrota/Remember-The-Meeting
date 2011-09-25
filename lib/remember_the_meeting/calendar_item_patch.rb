Viewpoint::EWS::CalendarItem.class_eval do
  def start_time
    @start_time ||= Time.parse(self.start.to_s)
  end

  def end_time
    @end_time ||= Time.parse(self.end.to_s)
  end

  def start_time_formatted
    start_time.strftime('%H:%M')
  end
  
  def end_time_formatted
    end_time.strftime('%H:%M')
  end
end

