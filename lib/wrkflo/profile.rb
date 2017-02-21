class Profile
  def self.load source
    @projects = YAML.load_file(source)
    @options = @projects.delete("options")
  end

  def self.projects;  @projects;  end
  def self.options;   @options;   end
end
