require 'os'
require 'wrkflo/configurable'

class Step
  attr_accessor :name, :raw_config, :project

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
      @@step_map[name.to_sym].new(name, config, project) || Step.new(name, config, project)
    end
  end


  include Configurable


  def initialize name, raw_config, project=nil
    # The name for this step
    @name = name
    # The options that define this step
    @raw_config = raw_config
    # The project to which this step belongs
    @project = project
    # Generate the finalized step configuration
    apply_configuration(@raw_config)
    # Always validate the new configuration unless specifically told not to.
    ensure_valid_configuration
    # Run step-specific initialization
    init
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

  # Work done immediately after initializing this step
  def init;   end
  # Common work done before running and unrunning.
  def setup;  end
  # The code to run when running this step normally
  def run
    log "Nothing to do."
  end
  # The code to run when running this step backwards
  def unrun
    log "Nothing to do."
  end


  protected

    # Return true if being run on the given platform. If a block is given, run
    # the block only if being run on the given platform and return the result.
    def on platform
      return OS.send("#{platform}?").tap{ |yn| yield yn if block_given? }
    end


  private

    def ensure_valid_configuration
      validate_configuration do |prop, value, reason|
        prop_name = "`#{@name}.#{prop.name}`"
        case reason
        when :required
          Notifier.error_out("required property #{prop_name} not provided for `#{@project.name}`.", type: "ConfigurationError")
        when :type
          Notifier.error_out(
            "property #{prop_name} for `#{@project.name}` does not match expected type.",
            "expected: #{prop.type_as_string}",
            "got:      #{prop.value_type_as_string(value)}")
        else
          Notifier.error_out("Unknown error", type: "ConfigurationError")
        end
      end
    end
end
