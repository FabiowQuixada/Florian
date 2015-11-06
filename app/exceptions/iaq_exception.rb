class IaqException < StandardError
  attr_reader :message
  
  def initialize(data)
    @message = data
  end
end