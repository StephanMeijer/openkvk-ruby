##
# This module represents a wrapper for the Openkvk.nl API.
module OpenKVK

  ##
  # Custom HTTP Client Error.
  #
  # Throw this if HTTP STATUS CODE indicates an error. (>= 400)
  class HTTPClientError < StandardError; end

  ##
  # Request a list with companies using the string +query+.
  # +query+ contains the keywords to search with.
  #
  # This function requests all companies according to the keywords in the strings +query+,
  # and returns a hash.
  #
  # * *Args*      :
  #   - +query+ -> keywords to search with in the OpenKVK API
  # * *Returns*   :
  #   - search results (with type Hash)
  # * *Raises*    :
  #   - +SocketError+ -> if OpenKVK changed their hostname without telling people
  #   - +HTTPClientError+ -> if HTTP STATUS CODE equals or is higher than 400
  def search(query)
    JSON.parse(get(query))
  end

  private

    ##
    # Magic happens here. This function requests a JSON document, and returns it.
    #
    # * *Args*    :
    #   - +query+ -> keywords to search with in the OpenKVK API
    #   - +protocol+ -> protocol to use, currently only support for HTTP
    #   - +host+ -> hostname of our API, might change once in a while
    # * *Returns* :
    #   - String with searchresults in JSON
    # * *Raises*  :
    #   - +SocketError+ -> if OpenKVK changed their hostname without telling people
    #   - +HTTPClientError+ -> if HTTP STATUS CODE equals or is higher than 400
    def get(query, protocol="http", host="officieel.openkvk.nl")
      # Use 'net/http' to request. Avoid as many depencies as possible.
      url = URI.parse(
         protocol +
         "://" +
         host +
         "/" +
         CGI::escape(query)
       )

       # HTTP magic happens here.
       req = Net::HTTP::Get.new(url.to_s)
       res = Net::HTTP.start(url.host, url.port) do |http|
         http.request(req)
       end

      # If HTTP STATUS not OK (STATUS >= 400), raise error.
      raise(HTTPClientError, "Status code " + res.code) if res.code.to_i >= 400

       res.body
    end

  module_function :search, :get

end
