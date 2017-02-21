class Step
  attr_accessor :name, :config, :project

  # A hash of step aliases to their respective classes. This map determines
  # the class that a given step in a project will be transformed into.
  @@step_map = { }

  class << self
    # Add an alias for this class to the step map. Used by subclasses to
    # register their definitions
    def add_alias name
      @@step_map[name.to_sym] = self
    end

    # Create a new instance of a Step based on the step map entry. If none
    # exists, a generic Step is created.
    def create name='', config={}, project=nil
      @@step_map[name.to_sym].new(name, config, project) or Step.new(name, config, project)
    end
  end

  def initialize name, config, project=nil
    # The name for this step
    @name = name
    # The options that define this step
    @config = config
    # The project that this step belongs to
    @project = project
  end

  # A pass through to this step's project's log. If this step has no project,
  # a simple puts call is used instead.
  def log message
    @project ? @project.log(message) : puts(message)
  end

  # STEP METHODS
  #
  # These methods should be defined by all Step subclasses as given by their
  # descriptions.

  # Common work done before running and unrunning.
  def setup; end

  # The code to run when running this step normally
  def run
    log "Nothing to do."
  end
  # The code to run when running this step backwards
  def unrun
    log "Nothing to do."
  end
end

# Require all step definitions
Dir[File.join(__dir__, 'steps', '*')].each{ |step_file| require step_file }
