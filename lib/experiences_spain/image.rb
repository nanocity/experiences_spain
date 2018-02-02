module ExperiencesSpain
  class Image < Resource
    include APIResource
    include APIOperations::Save

    SAVE_URL = '/experiences/json/upload-image'

    attributes :image, :url, :alt, :type, :position

    def process_response(data)
      result = super(data)
      if result
        @image = nil
        @url = data['data']
      end
      result
    end
  end
end
