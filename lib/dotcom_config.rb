require './lib/errors'

require 'httparty'
require 'nokogiri'

class DotcomConfig
  include HTTParty
  base_uri 'http://cwa.dotcomdistribution.com/dcd_api_test/DCDAPIService.svc/'
  format :xml

  attr_accessor :api_key, :password

  def initialize config
    @password  = config['dotcom.password']
    @api_key   = config['dotcom.api_key']

    validate!
  end

  def send!
    response = self.class.post(request_path, :body => generate_xml, :headers => {'Authorization' => authorization_header, 'Content-Type' => 'application/xml'})
    response['response']
  end

  def poll!
    self.class.get(request_path, :headers => {'Authorization' => authorization_header, 'Content-Type' => 'application/xml'})
    response['response']
  end

  private
  def validate!
    raise AuthenticationError, "API key and Password must be provided" if api_key.nil? || password.nil?
  end

  def authorization_header
    "#{api_key}:#{computed_hash}"
  end

  def computed_hash
    digest = OpenSSL::Digest::Digest.new('md5')
    hash = OpenSSL::HMAC.digest(digest, password, (self.class.base_uri + request_path))
    Base64.encode64(hash)
  end

  # TODO Require request_path, etc. methods to be implemented.
end