require 'json'
require 'net/http'

module Nehm

  class HTTPClient

    ##
    # SoundCloud API client ID

    CLIENT_ID = '11a37feb6ccc034d5975f3f803928a32'

    ##
    # Exception classes

    class Status404 < StandardError; end

    def get(api_version, uri_string)
      uri =
        case api_version
        when 1
          'https://api.soundcloud.com'
        when 2
          'https://api-v2.soundcloud.com'
        end
      uri += uri_string
      uri += "&client_id=#{CLIENT_ID}" if api_version == 1

      get_hash(uri)
    end

    def resolve(url)
      response = get(1, "/resolve?url=#{url}")

      errors = response['errors']
      if errors
        if errors[0]['error_message'] =~ /404/
          raise Status404
        end
      end

      if response['status'] =~ /302/
        get_hash(response['location'])
      end
    end

    private

    def get_hash(uri)
      response = Net::HTTP.get_response(URI(uri))
      JSON.parse(response.body)
    end

  end
end