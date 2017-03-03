module WRKFLO
  class Profile
    def self.load source
      @projects = YAML.load_file(source)
      @options = @projects.delete("options")
    rescue
      Notifier.error_out("Could not load configuration at '#{source}'.", type: "ConfigurationError")
    end

    def self.projects;  @projects;  end
    def self.options;   @options;   end
  end
end
