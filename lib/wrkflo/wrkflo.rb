require 'wrkflo/project'
require 'wrkflo/profile'

class WrkFlo
  attr_accessor :direction, :profile, :profile_source

  def initialize options
    @profile_source = options[:profile]
    Profile.load(@profile_source)
    @direction = options[:backward] ? :backward : :forward
  end

  # Get a specific project out of the profile. If the profile does not define
  # the given project, return nil.
  def [] project
    Project.new(project) if Profile.projects[project]
  end
end
