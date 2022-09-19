class Token
  attr_reader :value, :type
  
  def initialize(value = nil, type = nil)
    @value = value
    @type = type
  end
end
