class AuthenticationError < StandardError; end

class DotcomError < StandardError
  attr_accessor :errors_array
  
  def initialize errors_array
    @errors_array = errors_array
  end

  def generate_error_notifications_hash
    ret = []
    errors_array.each do |error|
      ret << error_notification(error)
    end
    { :notifications => ret }
  end

  def error_notification(error)
    {
      level: 'error',
      subject: error['error_description'],
      description: error['error_description']
    }
  end
end
