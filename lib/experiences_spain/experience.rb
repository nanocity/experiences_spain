module ExperiencesSpain
  class Experience < Resource
    include APIResource
    include APIOperations::List
    include APIOperations::Find
    include APIOperations::Search
    include APIOperations::Save
    include APIOperations::Translate
    include APIOperations::Validate

    LIST_URL = "/experiences/json/%<locale>s/getallporposals"
    SEARCH_URL = "/experiences/json/%<locale>s/findporposalbytitle"
    FIND_URL = "/experiences/json/%<locale>s/findporposalbyid"
    SAVE_URL = "/experiences/json/%<locale>s/create-update-porposal"
    TRANSLATE_URL = "/experiences/json/%<locale>s/%<id>s/create-update-localizedporposal"
    VALIDATE_URL = '/experiences/json/validate-porposal'

    attributes :id, :title, :description,
      :price, :book_url, :book_email, :locations, :georeferences, :languages,
      :start_date, :end_date, :date_description, :days, :hours, :minutes, :type, :categories, :profiles,
      :videos

    nested_resources :images

    def initialize(attributes = {})
      @id = -1

      super

      # For some reason List returns just one image on "image" field
      # Whereas Search and Find return a field called "images" been an Array
      @images = [Image.new(attributes[:image])] if attributes.keys.include?(:image)
    end

    def persisted?
      @id != -1
    end

    def process_response(data)
      result = super(data)
      @id = data['data']['id'] if result
      result
    end
  end
end
