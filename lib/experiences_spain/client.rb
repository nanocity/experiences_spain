module ExperiencesSpain
  class Client
    include HTTParty
    base_uri 'http://experiences.spain.info/experiences' 
    format :json

    attr_accessor :locale

    def request(url, body = {}, headers = {}, opts = {})
      self.class.base_uri ExperiencesSpain.base_uri

      self.class.post(
        url % { locale: ExperiencesSpain.locale }.merge(opts),
        body: body.to_json,
        headers: default_headers.merge(headers)
      )
    end

    private

    def default_headers
      {
        'Content-Type' => 'application/json; charset=utf8',
        'token' => ExperiencesSpain.auth_token
      }
    end
  end
end
