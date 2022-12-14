require './lib/patterns'
require './token'

class Lex
  attr_reader :tokens, :errors

  def initialize(filename)
    @tokens = []
    @tk_index = 0
    @lines = []
    @errors = []
    @removing_block = false

    File.foreach(filename) { |line| @lines.push(line) }
    @lines.each_with_index { |text, index| sort_tokens(text, index + 1, filename) }
  end

  def next_token
    @tk_index += 1
    @tokens[@tk_index - 1] ? @tokens[@tk_index - 1] : nil
  end

  def prev_token
    @tokens[@tk_index - 2]
  end

  private

  def sort_tokens(text, line_index, filename)
    index = 0
    while index < text.length
      str = ''

      case text[index]
      when /[_[A-Za-z]]/
        while text[index + 1] =~ /[_[A-Za-z]]/
          str << text[index]
          index += 1
        end

        str << text[index] if text[index] =~ /[a-z]/

        if Patterns::KEYWORDS[:KEYS].include?(str.downcase)
          @tokens.push(Token.new(str, Patterns::KEYWORDS[:TYPE]))
        elsif Patterns::BOOL[:KEYS].include?(str.downcase)
          @tokens.push(Token.new(str, Patterns::BOOL[:TYPE]))
        elsif Patterns::SELF_REFERENCE[:KEYS].include?(str)
          @tokens.push(Token.new(str, Patterns::SELF_REFERENCE[:TYPE]))
        elsif str =~ Patterns::TYPE_ID[:REGEXP]
          @tokens.push(Token.new(str, Patterns::TYPE_ID[:TYPE]))
        elsif str =~ Patterns::OBJECT_ID[:REGEXP]
          @tokens.push(Token.new(str, Patterns::OBJECT_ID[:TYPE]))
        else
          @tokens.push(Token.new(text[index], 'UNDEFINED'))
          @errors.push("Unexpected token '#{str}' at line #{line_index}:#{index + 1} in #{filename}")
        end
      when /'/
        index += 1
        while text[index] !~ /['[\n]]/
          str << text[index]
          index += 1
        end

        str.prepend("'", '')
        str.concat("'", '') if text[index] =~ /'/

        if str =~ Patterns::CHAR[:REGEXP]
          @tokens.push(Token.new(str, Patterns::CHAR[:TYPE]))
        else
          @tokens.push(Token.new(text[index], 'UNDEFINED'))
          @errors.push("Expected token ' at line: #{line_index} in #{filename}")
        end
      when /"/
        index += 1
        while text[index] !~ /["[\n]]/
          str << text[index]
          index += 1
        end

        str.prepend('"', '')
        str.concat('"', '') if text[index] =~ /"/

        if str =~ Patterns::STRING[:REGEXP]
          @tokens.push(Token.new(str, Patterns::STRING[:TYPE]))
        else
          @tokens.push(Token.new(text[index], 'UNDEFINED'))
          @errors.push("Expected token \" at line: #{line_index} in #{filename}")
        end
      when /\d/
        while text[index] =~ /\d/
          str << text[index]
          index += 1
        end
        @tokens.push(Token.new(str, Patterns::INT[:TYPE])) if str =~ Patterns::INT[:REGEXP]
      when Patterns::PUNCT[:REGEXP]
        @tokens.push(Token.new(text[index], Patterns::PUNCT[:TYPE]))
      when /[(){}]/
        @tokens.push(Token.new(text[index], Patterns::OPEN_EXP[:TYPE])) if text[index] =~ Patterns::OPEN_EXP[:REGEXP]
        @tokens.push(Token.new(text[index], Patterns::CLOSE_EXP[:TYPE])) if text[index] =~ Patterns::CLOSE_EXP[:REGEXP]
        @tokens.push(Token.new(text[index], Patterns::OPEN_SCOPE[:TYPE])) if text[index] =~ Patterns::OPEN_SCOPE[:REGEXP]
        @tokens.push(Token.new(text[index], Patterns::CLOSE_SCOPE[:TYPE])) if text[index] =~ Patterns::CLOSE_SCOPE[:REGEXP]
      when /<(?!-)/
        @tokens.push(Token.new("#{text[index]}#{text[index + 1]}", Patterns::OPERATORS[:TYPE]))
        index += 1
      when /<(?!=)/
        @tokens.push(Token.new("#{text[index]}#{text[index + 1]}", Patterns::OPERATORS[:TYPE]))
        index += 1
      when />(?!=)/
        @tokens.push(Token.new("#{text[index]}#{text[index + 1]}", Patterns::OPERATORS[:TYPE]))
        index += 1
      when /-(?!-)/
        index = text.length
      when Patterns::OPERATORS[:REGEXP]
        @tokens.push(Token.new(text[index], Patterns::OPERATORS[:TYPE]))
      else
        if text[index] !~ /\s/
          @tokens.push(Token.new(text[index], 'UNDEFINED'))
          @errors.push("Unexpected token '#{text[index]}' at line #{line_index}:#{index + 1} in #{filename}")
        end
      end

      index += 1
    end
  end
end
