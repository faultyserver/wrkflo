class Profile
  def self.load source
    @projects = YAML.load_file(source)
    @options = @projects.delete("options")
  rescue
    $stderr.puts "Could not load configuration at '#{source}'."
    $stderr.puts "Make sure the file exists before running `wrkflo`."
    exit 1
  end

  def self.projects;  @projects;  end
  def self.options;   @options;   end
end
