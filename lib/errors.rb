class AuthenticationError < StandardError; end
class MethodNotImplemented < StandardError; end
class DotcomEndpointError < StandardError; end

class DotcomError < StandardError
  attr_accessor :errors_array
  
  def initialize errors_array
    @errors_array = errors_array
  end

  def message
    errors_array.join(", ")
  end
end
