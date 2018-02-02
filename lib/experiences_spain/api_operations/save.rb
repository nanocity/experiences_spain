module ExperiencesSpain
  module APIOperations
    module Save
      def save
        clear_errors

        process_response(
          self.class.client.request(
            self.class::SAVE_URL,
            to_hash.deep_rekey { |k| k.to_s.camelcase(:lower) }
          ).parsed_response
        )
      end
    end
  end
end
