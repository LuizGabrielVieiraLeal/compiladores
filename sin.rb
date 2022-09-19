require 'colorize'
require './lex'

class Sin
  attr_reader :errors

  def initialize(filename)
    @filename = filename
    @lex = Lex.new(@filename)
    @errors = []
  end

  def top_down_analyze
    if @lex.errors.empty?
      token = @lex.next_token
      if token.value == 'class'
        puts 'ok'
      else
        @errors.push("Unexpected token #{token.value} at begin of file #{@filename}")
      end
    else
      @lex.errors.each { |error| puts error.red }
    end
  end
end
