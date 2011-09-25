require File.join(File.dirname(__FILE__), 'remember_the_meeting', 'version')
require File.join(File.dirname(__FILE__), 'remember_the_meeting', 'platform')
include Platform

require 'viewpoint'
require 'yaml'
require 'growl' unless linux?

require File.join(File.dirname(__FILE__), 'remember_the_meeting', 'calendar_item_patch')

module RememberTheMeeting

  class << self
    include Platform

    def notify(subject, start_time, end_time, location)
      message = "#{start_time}-#{end_time}\n#{location}"
      if linux?
        system "notify-send \"#{subject}\" \"#{message}\""
      else
        Growl.notify(message, {:title => subject, :sticky => true})
      end
    end
    
    def setup
      Viewpoint::EWS::EWS.endpoint = config['server']
      Viewpoint::EWS::EWS.set_auth(config['user'], config['pass'])
      @cal = Viewpoint::EWS::CalendarFolder.get_folder :calendar
      @cal.subscribe
    end

    def configure
      system "#{editor} #{config_filepath}"
    end

    def editor
      editor = `echo $EDITOR`.chomp
      editor.blank? ? 'vim' : editor
    end

    def config
      YAML.load(File.read(config_filepath))
    end

    def config_filepath
      File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'exchange.yml'))
    end
    
    def start
      loop do
        items = @cal.todays_items
        
        # d1 = DateTime.parse('2011-09-24')
        # d2 = DateTime.parse('2011-09-30')
        # items = @cal.items_between(d1, d2)
        
        now = Time.now
        in_15_minutes = Time.now + 60 * 15
        upcoming = items.select {|item| item.start_time > now && item.start_time < in_15_minutes }
        upcoming.each do |appointment|
          start_time = appointment.start_time_formatted
          end_time   = appointment.end_time_formatted
          subject    = appointment.subject
          location   = appointment.location
          notify(subject, start_time, end_time, location)
        end
        sleep(300)
      end
    end

    def enable!
      setup
      start
    end
  end
end
