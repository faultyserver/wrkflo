class FileSystem < Step
  add_alias :filesystem
  add_alias :fs

  property :which,        required: false,  default: Profile.options['filesystem']
  property :host,         required: true
  property :remote_path,  required: true
  property :local_path,   required: true

  def init
    @filesystem = config.which
    @step = Step.create(@filesystem.to_sym, @raw_config, project)
    @name = "filesystem[#{@step.name}]"
  end

  def run;    @step.run;    end
  def unrun;  @step.unrun;  end
end
