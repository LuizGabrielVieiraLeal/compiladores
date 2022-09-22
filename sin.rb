require 'colorize'
require './lib/patterns'
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
      program_validate
    else
      @lex.errors.each { |error| puts error.red }
    end
  end

  private

  def program_validate
    token = @lex.next_token
    if token.type == Patterns::KEYWORDS[:TYPE] && token.value.downcase == 'class'
      class_validate
    else
      @errors.push("Unexpected token #{token.value} in file #{@filename}")
    end
  end

  def class_validate
    token = @lex.next_token
    if token.type == Patterns::TYPE_ID[:TYPE]
      token = @lex.next_token
      if token.type == Patterns::KEYWORDS[:TYPE] && token.value.downcase == 'inherits'
        token = @lex.next_token
        if token.type == Patterns::TYPE_ID[:TYPE]
          token = @lex.next_token
          token.type == Patterns::OPEN_SCOPE[:TYPE] ? feature_validate : @errors.push("Unexpected token #{token.value} in file #{@filename}")
        else
          @errors.push("Unexpected token #{token.value} in file #{@filename}")
        end
      elsif token.type == Patterns::OPEN_SCOPE[:TYPE]
        feature_validate
      else
        @errors.push("Unexpected token #{token.value} in file #{@filename}")
      end
    else
      @errors.push("Unexpected token #{token.value} in file #{@filename}")
    end
  end

  def feature_validate
    token = @lex.next_token
    if token.type == Patterns::OBJECT_ID[:TYPE]
      token = @lex.next_token
      puts token.inspect
    else
      @errors.push("Unexpected token #{token.value} in file #{@filename}")
    end
  end
end
