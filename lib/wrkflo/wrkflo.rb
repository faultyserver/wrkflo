require 'wrkflo/project'

class WrkFlo
  attr_accessor :direction, :profile, :profile_source

  def initialize options
    @profile = YAML.load(File.open(options[:profile]))
    @profile_source = options[:profile]
    @direction = options[:backward] ? :backward : :forward
  end

  # Get a specific project out of the profile. If the profile does not define
  # the given project, return nil.
  def [] project
    Project.new(project, @profile[project])
  end
end
