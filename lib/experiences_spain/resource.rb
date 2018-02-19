module ExperiencesSpain
  class Resource
    class << self
      def attributes(*attributes)
        attr_accessor(*attributes)
        (@attributes ||= []).push(*attributes)
      end

      def nested_resources(*resources)
        attr_accessor(*resources)
        (@nested_resources ||= []).push(*resources)
      end

      def new_from_hash(attrs)
        ExperiencesSpain.const_get(attrs['type'].capitalize).new(attrs)
      end
    end

    attr_reader :errors, :warnings

    def initialize(attributes = {})
      clear_errors
      set_attributes(attributes)
    end

    def set_attributes(attributes)
      attributes.each do |key, value|
        if self.class.attributes.include?(key.to_sym)
          send("#{key}=", value)
        elsif self.class.nested_resources.include?(key.to_sym)
          send("#{key}=", (value || []).map{ |attrs| Resource.new_from_hash(attrs) })
        end
      end
    end

    def valid?
      errors.empty?
    end

    def to_hash
      Hash[
        self.class.attributes.map do |attribute|
          [attribute, send(attribute)]
        end + 
        self.class.nested_resources.map do |resources|
          [resources, send(resources)&.map(&:to_hash)]
        end
      ].delete_if { |_, v| v.nil? }
    end

    private

    def clear_errors
      @errors = []
      @warnings = []
    end
  end
end
