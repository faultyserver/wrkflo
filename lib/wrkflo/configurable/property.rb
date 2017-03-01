module Configurable
  class Property
    # The name of the property as it should appear in the configuration
    attr_accessor :name
    # Whether the property is required to be provided by the user
    attr_accessor :required
    alias_method  :required?, :required
    # The default value to be given to this property if one is not provided
    attr_accessor :default


    def initialize name, is_required, default_value
      @name     = name
      @required = is_required
      @default  = default_value
    end


    # Assign a value to this property
    def resolve_value value
      value.nil? ? @default : value
    end
  end
end
