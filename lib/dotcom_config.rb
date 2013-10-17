require './lib/errors'

require 'pry'
require 'httparty'
require 'nokogiri'

class DotcomConfig
  include HTTParty
  base_uri 'http://cwa.dotcomdistribution.com/dcd_api_test/DCDAPIService.svc/'
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
    response = self.class.post(request_path, :body => generate_xml, :headers => {'Authorization' => authorization_header, 'Content-Type' => 'application/xml'})
    response['response']
  end

  private
  def authorization_header
    "#{api_key}:#{computed_hash}"
  end

  def computed_hash
    unless @computed_hash_value
      digest = OpenSSL::Digest::Digest.new('md5')
      hash = OpenSSL::HMAC.digest(digest, password, (self.class.base_uri + request_path))
      @computed_hash_value = Base64.encode64(hash)
    end
    @computed_hash_value
  end
end

# class ShipWireSubmitOrderError < StandardError; end
# class SendError < StandardError; end