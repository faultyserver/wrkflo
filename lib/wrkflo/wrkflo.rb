require 'wrkflo/notifier'
require 'wrkflo/version'
require 'wrkflo/profile'
require 'wrkflo/project'

class WrkFlo
  attr_accessor :direction, :profile, :profile_source

  DEFAULT_STEP_PATHS = [
    File.join(__dir__, 'steps'),
    File.join(ENV['HOME'], '.wrkflo', 'steps'),
    File.join('.', '.wrkflo', 'steps')
  ]

  def initialize options
    @profile_source = options[:profile]
    Profile.load(@profile_source)
    load_step_definitions
    @direction = options[:backward] ? :backward : :forward
  end

  # Load all step definitions from various default and configured paths.
  def load_step_definitions
    # For the default directories, try to scan them if they exist.
    DEFAULT_STEP_PATHS.each do |path|
      if Dir.exists?(path)
        Dir[File.join(path, '*')].each{ |step_file| require step_file }
      end
    end

    # For configured paths, try to require each entry and error out if one is
    # not available.
    configured_step_paths.each do |path|
      if Dir.exists?(path)
        Dir[File.join(path, '*')].each{ |step_file| require step_file }
      else
        require path
      end
    end
  end

  # Get a specific project out of the profile. If the profile does not define
  # the given project, return nil.
  def [] project
    Project.new(project) if Profile.projects[project]
  end


  private

    def configured_step_paths
      Profile.options['step_definitions'] || []
    end
end
