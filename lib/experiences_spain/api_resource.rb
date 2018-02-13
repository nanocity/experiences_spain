module ExperiencesSpain
  module APIResource

    def self.included(base)
      base.extend ClassMethods
    end

    def process_response(data)
      return true if data['status'] == 'success'

      @errors << data['message']
      @warnings << data['warning']

      @errors.compact!
      @warnings.compact!

      return false
    end

    module ClassMethods
      def client
        ExperiencesSpain.client
      end

      private

      def initialize_from_response(response)
        data = response.parsed_response

        # List and Search always return an Array even though it may be empty.
        if data.is_a? Array
          data.map { |element| new(element.deep_rekey { |k| k.underscore.to_sym }) }

        # Find and Save returns a Hash with a status associated
        elsif data.is_a? Hash
          resource = new(data['data'].deep_rekey { |k| k.underscore.to_sym })
          if data['status'] == 'error'
            resource.errors << data['message']
          end
          resource
        end
      end
    end
  end
end
