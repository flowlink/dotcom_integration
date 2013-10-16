require './lib/errors'

require 'pry'
require 'httparty'
require 'nokogiri'

class DotcomConfig
  include HTTParty
  base_uri 'https://cwa.dotcomdistribution.com/dcd_api_test/DCDAPIService.svc/'
  format :xml

  attr_accessor :api_key, :password, :algorithm

  def initialize config
    @password  = config['dotcom.password']
    @api_key   = config['dotcom.api_key']

    @algorithm = 'md5'

    authenticate!
  end

  def authenticate!
    raise AuthenticationError if api_key.nil? || password.nil?
  end

  def send!
    self.class.post(request_path, :body => generate_xml, :headers => {'Authorization' => authorization_header, 'Content-Type' => 'application/xml'})
  end

  private
  def authorization_header
    api_key + ":" + computed_hash
  end

  def computed_hash
    unless @computed_hash_value
      password_bytes = password.bytes.join
      uri_bytes = (self.class.base_uri + request_path).bytes.join

      digest = OpenSSL::HMAC.digest(algorithm, password_bytes, uri_bytes)
      
      @computed_hash_value = Base64.encode64(digest)
    end
    @computed_hash_value
  end
end

# class ShipWireSubmitOrderError < StandardError; end
# class SendError < StandardError; end