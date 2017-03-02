module Configurable
  class Property
    # The name of the property as it should appear in the configuration
    attr_accessor :name
    # Whether the property is required to be provided by the user
    attr_accessor :required
    alias_method  :required?, :required
    # The expected type of the value
    attr_accessor :type
    # The default value to be given to this property if one is not provided
    attr_accessor :default


    def initialize name, is_required, expected_type, default_value
      @name     = name
      @required = is_required
      @default  = default_value
      @type     = expected_type
    end


    # Assign a value to this property
    def resolve_value value
      value.nil? ? @default : value
    end

    # Returns true if `value` is of the type expected by this property. Returns
    # false otherwise.
    # For simple types, this is a simple `is_a?` check.
    # For arrays, two different rules apply:
    #   - `Array[]` expects an arbitrary array of values.
    #   - `Array[Float]` expects an arbitrary-length array of `Float` values.
    #   - `Array[Float, String, ...]` expects an Array of exactly those types.
    def matches_type? value, expected_type: type
      case expected_type
      # Raw class types
      when Array
        case expected_type.length
        when 0
          return value.is_a?(Array)
        when 1
          return value.all?{ |v| matches_type?(v, expected_type: expected_type[0]) }
        else
          return expected_type.zip([value].flatten(1)).all?{ |t, v| matches_type?(v, expected_type: t) }
        end
      else
        value.is_a?(expected_type)
      end
    end

    def type_as_string expected_type: type
      case expected_type
      when Array
        value_types = expected_type.map{ |t| t.to_s }
        "Array[#{value_types.join(',')}]"
      else
        expected_type.to_s
      end
    end

    def value_type_as_string value
      case value
      when Array
        value_types = value.map{ |v| v.class.to_s }
        "Array[#{value_types.join(',')}]"
      else
        value.class.to_s
      end
    end
  end
end
