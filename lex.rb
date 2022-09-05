require './lib/patterns'
require './token'

class Lex
  attr_reader :text, :tokens

  def initialize(filename)
    @text = format_text filename
    @tokens = []
    @tk_index = 0
    sort_tokens
  end

  def next_token
    @tk_index += 1
    @tokens[@tk_index - 1]
  end

  private

  def format_text filename
    lines = []
    File.foreach(filename) do |line|
      line = line.strip!
      lines.push(line) unless line.match(Patterns::COMMENT_LINE)
    end
    lines.join(' ').gsub(Patterns::COMMENT_BLOCK, '')
  end

  def sort_tokens
    index = 0
    while index < @text.length
      str = ''

      if @text[index] =~ /[\(\)\{\}]/
        @tokens.push(Token.new(@text[index], Patterns::OPEN_EXP[:TYPE])) if @text[index] =~ Patterns::OPEN_EXP[:REGEXP]
        @tokens.push(Token.new(@text[index], Patterns::CLOSE_EXP[:TYPE])) if @text[index] =~ Patterns::CLOSE_EXP[:REGEXP]
        @tokens.push(Token.new(@text[index], Patterns::OPEN_SCOPE[:TYPE])) if @text[index] =~ Patterns::OPEN_SCOPE[:REGEXP]
        @tokens.push(Token.new(@text[index], Patterns::CLOSE_SCOPE[:TYPE])) if @text[index] =~ Patterns::CLOSE_SCOPE[:REGEXP]
        index += 1
      end

      if @text[index] =~ /[\+\-\*\/~><=]/ && (@text[index] =~ />(?!=)/ || @text[index] =~ /<(?!=)/ || @text[index] =~ /<(?!-)/)
        @tokens.push(Token.new("#{@text[index]}#{@text[index + 1]}", Patterns::OPERATORS[:TYPE]))
        index += 2
      elsif @text[index] =~ /[\+\-\*\/~><=]/
        @tokens.push(Token.new(@text[index], Patterns::OPERATORS[:TYPE])) if @text[index] =~ Patterns::OPERATORS[:REGEXP]
        index += 1
      end

      case @text[index]
      when /[_[A-Za-z]]/
        while @text[index] =~ Patterns::OBJECT_ID[:REGEXP]
          str << @text[index]
          index += 1
        end

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
        end
      when /'/
        index += 1
        while @text[index] !~ /'/
          str << @text[index]
          index += 1
        end
        str.prepend("'", '')
        str.concat("'", '')
        @tokens.push(Token.new(str, Patterns::CHAR[:TYPE])) if str =~ Patterns::CHAR[:REGEXP]
      when /"/
        index += 1
        while @text[index] !~ /"/
          str << @text[index]
          index += 1
        end
        str.prepend('"', '')
        str.concat('"', '')
        @tokens.push(Token.new(str, Patterns::STRING[:TYPE])) if str =~ Patterns::STRING[:REGEXP]
      when /\d/
        while @text[index] =~ /\d/
          str << @text[index]
          index += 1
        end
        @tokens.push(Token.new(str, Patterns::INT[:TYPE])) if str =~ Patterns::INT[:REGEXP]
      end
      index += 1
    end
  end
end
