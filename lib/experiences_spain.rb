require 'httparty'
require 'facets/kernel/deep_clone'
require 'facets/hash/deep_rekey'
require 'facets/string/camelcase'
require 'facets/string/snakecase'

require 'experiences_spain/client'

require 'experiences_spain/api_operations/list'
require 'experiences_spain/api_operations/find'
require 'experiences_spain/api_operations/search'
require 'experiences_spain/api_operations/save'
require 'experiences_spain/api_operations/translate'
require 'experiences_spain/api_operations/validate'

require 'experiences_spain/resource'
require 'experiences_spain/api_resource'

require 'experiences_spain/experience'
require 'experiences_spain/image'
require 'experiences_spain/validation'

# Exceptions
require 'experiences_spain/experience_not_found'

# Version
require 'experiences_spain/version'

module ExperiencesSpain
  @locale = 'es_ES'
  @base_uri = 'http://experiences.spain.info'
  @auth_token = ''

  class << self
    attr_accessor :auth_token, :locale, :base_uri

    def client
      @client ||= ExperiencesSpain::Client.new
    end
  end
end
