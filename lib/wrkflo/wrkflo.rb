require 'wrkflo/profile'
require 'wrkflo/project'

class WrkFlo
  attr_accessor :direction, :profile, :profile_source

  def initialize options
    @profile_source = options[:profile]
    Profile.load(@profile_source)
    load_step_definitions
    @direction = options[:backward] ? :backward : :forward
  end

  # Load step definitions from all paths in the include path.
  # Currently, this is just `./steps/`.
  def load_step_definitions
    Dir[File.join(__dir__, 'steps', '*')].each{ |step_file| require step_file }
  end

  # Get a specific project out of the profile. If the profile does not define
  # the given project, return nil.
  def [] project
    Project.new(project) if Profile.projects[project]
  end
end
