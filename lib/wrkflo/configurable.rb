require 'wrkflo/configurable/property'

module Configurable
  module ClassMethods
    # A list of properties defined by the owner
    def properties
      @properties ||= {}
    end

    # Define a new property for the owning object
    def property name, required: false, default: nil
      properties[name] = Property.new(name, required, default)
    end
  end

  def self.included base
    base.extend ClassMethods
  end


  def apply_configuration raw_config
    final_config = self.class.properties.each.with_object({}) do |(name, prop), h|
      provided_value = raw_config[name.to_s]
      # Determine the real value based on the property's definition
      real_value = prop.resolve_value(provided_value)
      # Remember the real value in the actual configuration
      h[name.to_sym] = real_value
    end

    # Create a struct from the configuration hash to enable dot-access.
    @configuration = Struct.new(*final_config.keys).new(*final_config.values)
  end

  def config
    @configuration
  end
end
