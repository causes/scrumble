require 'rubygems'
require 'pivotal-tracker'

Project = PivotalTracker::Project

class PivotalTracker::Project
  def self.active(date)
    all.select{|p| p.active_stories(date).any?}
  end

  def active_stories(date)
    @active_stories ||= {}
    @active_stories[date] ||=
      stories.all(:modified_since => date.strftime("%Y/%m/%d"))
  end
end
