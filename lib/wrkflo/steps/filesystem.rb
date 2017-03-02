class FileSystem < Step
  add_alias :filesystem
  add_alias :fs

  property :which,        required: false,  type: String, default: Profile.options['filesystem']
  property :host,         required: true,   type: String
  property :remote_path,  required: true,   type: String
  property :local_path,   required: true,   type: String

  def init
    @filesystem = config.which
    @step = Step.create(@filesystem.to_sym, @raw_config, project)
    @name = "filesystem[#{@step.name}]"
  end

  def run;    @step.run;    end
  def unrun;  @step.unrun;  end
end
