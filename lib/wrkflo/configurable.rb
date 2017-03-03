module WRKFLO
  module Configurable
    module ClassMethods
      # A list of properties defined by the owner
      def properties
        @properties ||= {}
      end

      # Define a new property for the owning object
      def property name, required: false, type: Object, default: nil
        properties[name] = Property.new(name, required, type, default)
      end
    end

    def self.included base
      base.extend ClassMethods
    end


    def apply_configuration raw_config
      final_config = self.class.properties.each.with_object({}) do |(name, prop), h|
        provided_value = raw_config[name.to_s] rescue nil
        # Determine the real value based on the property's definition
        real_value = prop.resolve_value(provided_value)
        # Remember the real value in the actual configuration
        h[name.to_sym] = real_value
      end

      # Create a struct from the configuration hash to enable dot-access.
      @configuration = Struct.new(*final_config.keys).new(*final_config.values)
    end

    # Returns `true` if the configuration is valid. Otherwise, returns a pair
    # of the property and a reason. If a block is given, this pair is also
    # passed to the block.
    def validate_configuration
      self.class.properties.values.each do |prop|
        if prop.required?
          unless config.respond_to?(prop.name)
            return [prop, nil, :required].tap{ |f| yield f if block_given? }
          end
        end

        value = config.send(prop.name)

        return [prop, value, :type].tap{ |f| yield f if block_given? } unless prop.matches_type?(value)
      end

      return true
    end

    def config
      @configuration
    end
  end
end
