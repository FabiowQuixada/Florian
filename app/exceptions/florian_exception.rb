class FlorianException < StandardError
  attr_reader :message
  
  def initialize(data)
    @message = data
  end
end