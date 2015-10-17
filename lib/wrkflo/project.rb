require 'wrkflo/step'

class Project
  attr_accessor :name, :steps

  def initialize name, steps
    # The name of this project workflow
    @name = name
    # The steps that make up this workflow
    @steps = steps.map{ |name, config| Step.create(name, config, self) }
    # The step currently being executed
    @current_step = 0
  end

  # Run each step in the order they are specified
  def run
    meta_log "Running workflow '#{@name}'"
    # Reset the current step number
    @current_step_num = 0
    # Run the steps
    @steps.each do |step|
      # Remember the step being run
      @current_step = step
      # Increment the current step so that the first step is 1
      @current_step_num += 1
      # Run the step
      @current_step.run
    end

    meta_log "Workflow complete"
  end

  # Undo the steps in reverse order
  def unrun
    meta_log "Reversing workflow '#{@name}'"
    # Reset the current step number
    @current_step_num = @steps.size
    # Run the steps
    @steps.each do |step|
      # Track the step being run
      @current_step = step
      # Run the step
      @current_step.unrun
      # Decrement the current step so that the last step is 1
      @current_step_num -= 1
    end

    meta_log "Workflow reversed"
  end

  # Post a message to the terminal with some identifying information
  def log message
    puts "> Step ##{@current_step_num} (#{@current_step.name}): #{message}"
  end


  private
    # Write a log message with a different prefix marker to visually
    # indicate a meta-type message
    def meta_log message
      puts "- #{message}"
    end
end
