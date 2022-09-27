require 'colorize'
require './lib/patterns'
require './lex'

class Sin
  attr_reader :errors

  def initialize(filename)
    @filename = filename
    @lex = Lex.new(@filename)
    @current_token = nil
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
    next_token
    if @current_token.type == Patterns::KEYWORDS[:TYPE] && @current_token.value.downcase == 'class'
      next_token
      class_validate
    else
      @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
    end
  end

  def class_validate
    while @current_token && @current_token.value.downcase != 'class'
      if @current_token.type == Patterns::TYPE_ID[:TYPE]
        next_token
        if @current_token.type == Patterns::KEYWORDS[:TYPE] && @current_token.value.downcase == 'inherits'
          next_token
          if @current_token.type == Patterns::TYPE_ID[:TYPE]
            next_token
            if @current_token.type == Patterns::OPEN_SCOPE[:TYPE]
              next_token
              feature_validate
            else
              @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
            end
          else
            @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
          end
        elsif @current_token.type == Patterns::OPEN_SCOPE[:TYPE]
          next_token
          feature_validate
        else
          @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
        end
      else
        @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
      end
      next_token
    end
  end

  def feature_validate
    loop do
      if @current_token.type == Patterns::OBJECT_ID[:TYPE]
        next_token
        if @current_token.type == Patterns::OPEN_EXP[:TYPE]
          next_token
          formal_validate
        elsif @current_token.type == Patterns::PUNCT[:TYPE] && @current_token.value == ':'
          next_token
          if @current_token.type == Patterns::TYPE_ID[:TYPE]
            next_token

          else
            @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
          end
        else
          @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
        end
      else
        @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
      end
      next_token
      break if @current_token.type == Patterns::OBJECT_ID[:TYPE]
    end
  end

  def formal_validate
    puts @current_token.inspect
  end

  def next_token
    @current_token = @lex.next_token
  end
end
