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

    # puts @lex.tokens.inspect
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
    while @current_token && @current_token.type != Patterns::CLOSE_SCOPE[:TYPE]
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

    next_token

    if @current_token.type == Patterns::PUNCT[:TYPE] && @current_token.value == ';'
      next_token
      if @current_token && @current_token.value.downcase == 'class'
        next_token
        class_validate
      else
        return
      end
    end
  end

  def feature_validate
    loop do
      if @current_token.type == Patterns::OBJECT_ID[:TYPE]
        next_token
        if @current_token.type == Patterns::OPEN_EXP[:TYPE]
          next_token
          if @current_token.type == Patterns::OBJECT_ID[:TYPE]
            formal_validate
            if @current_token.type == Patterns::CLOSE_EXP[:TYPE]
              next_token
              if @current_token.type == Patterns::PUNCT[:TYPE] && @current_token.value == ':'
                next_token
                if @current_token.type == Patterns::TYPE_ID[:TYPE]
                  next_token
                  if @current_token.type == Patterns::OPEN_SCOPE[:TYPE]
                    next_token
                    expr_validate
                  else
                    @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
                  end
                else
                  @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
                end
              else
                @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
              end
            else
              @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
            end
          elsif @current_token.type == Patterns::CLOSE_EXP[:TYPE]
            next_token
            if @current_token.type == Patterns::PUNCT[:TYPE] && @current_token.value == ':'
              next_token
              if @current_token.type == Patterns::TYPE_ID[:TYPE]
                next_token
                if @current_token.type == Patterns::OPEN_SCOPE[:TYPE]
                  next_token
                  expr_validate
                else
                  @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
                end
              else
                @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
              end
            else
              @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
            end
          else
            @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
          end
        elsif @current_token.type == Patterns::PUNCT[:TYPE] && @current_token.value == ':'
          next_token
          if @current_token.type == Patterns::TYPE_ID[:TYPE]
            next_token
            if @current_token.type == Patterns::OPERATORS[:TYPE] && @current_token.value == '<-'
              next_token
              expr_validate
            else
              @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
            end
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
      break if @current_token.type == Patterns::CLOSE_SCOPE[:TYPE]
    end

    next_token

    if @current_token.type == Patterns::PUNCT[:TYPE] && @current_token.value == ';'
      next_token
      if @current_token && @current_token.type == Patterns::OBJECT_ID[:TYPE]
        feature_validate
      else
        return
      end
    end
  end

  def formal_validate
    if @current_token.type == Patterns::OBJECT_ID[:TYPE]
      next_token
      if @current_token.type == Patterns::PUNCT[:TYPE] && @current_token.value == ':'
        next_token
        if @current_token.type == Patterns::TYPE_ID[:TYPE]
          next_token
          if @current_token.type == Patterns::PUNCT[:TYPE] && @current_token.value == ','
            next_token
            formal_validate
          elsif @current_token.type == Patterns::CLOSE_EXP[:TYPE]
            return
          else
            @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
          end
        else
          @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
        end
      else
        @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
      end
    else
      @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
    end
  end

  def expr_validate
    if @current_token.type == Patterns::BOOL[:TYPE]
      next_token
      return
    elsif @current_token.type == Patterns::KEYWORDS[:TYPE]
      case @current_token.value
      when 'not'
      when 'isvoid'
        next_token
        expr_validate
      when 'let'
        puts @current_token.inspect
      end
    else
      @errors.push("Unexpected token #{@current_token.value} in file #{@filename}")
    end
  end

  def next_token
    @current_token = @lex.next_token
  end
end
