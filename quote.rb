class Quote
  attr_reader :text, :author

  def initialize(array)
    @text = array[0].strip.gsub(/\n/, ' ').gsub(/\. /, ".  ").gsub(/\.   /, ".  ")
    @author = array[1].strip
  end
end
