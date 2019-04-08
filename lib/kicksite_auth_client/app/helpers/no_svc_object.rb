# An object that acts sort of similar to an ActiveResource object
# but without all the extras ActiveResource gives that doesn't exist for this.
class NoSvcObject
  BASE_DATETIME_KEYS = %w[
    updated_at
    created_at
  ].freeze

  def initialize(payload)
    BASE_DATETIME_KEYS.each do |key|
      payload[key] = to_datetime(payload[key])
    end

    payload.each do |key, value|
      define_instance_variable(key, value.is_a?(Hash) ? NoSvcObject.new(value) : value)
      define_getter(key)
      define_setter(key, value.is_a?(Hash) ? NoSvcObject.new(value) : value)
    end
  end

  def to_hash
    hash = {}
    instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

  def respond_to_missing?(method_name, include_private = false)
    (method_name.to_s.end_with?('=') && args.count == 1) || super
  end

  private

  # Allows setting of new methods onto the object. Thanks ActiveResource.
  def method_missing(method, *args, &block)
    if method.to_s.end_with?('=') && args.count == 1
      key = method.to_s.sub('=', '')
      value = args.first

      define_instance_variable(key, value.is_a?(Hash) ? NoSvcObject.new(value) : value)
      define_getter(key)
      define_setter(key, value.is_a?(Hash) ? NoSvcObject.new(value) : value)
    else
      super
    end
  end

  def define_instance_variable(key, value)
    instance_variable_set("@#{key}", value)
  end

  def define_getter(key)
    define_singleton_method(key) do
      instance_variable_get("@#{key}")
    end
  end

  def define_setter(key, _value)
    define_singleton_method("#{key}=") do |value|
      instance_variable_set("@#{key}", value)
    end
  end

  protected

  def to_datetime(datetime_string)
    return datetime_string unless datetime_string.present?
    return datetime_string unless datetime_string.is_a?(String)

    Time.parse(datetime_string)
  end
end
