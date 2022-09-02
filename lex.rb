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
    current_index = @tk_index
    @tk_index += 1
    @tokens[current_index]
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

      case @text[index]
      when /[_[A-Za-z]]/
        while @text[index] =~ Patterns::OBJECT_ID[:REGEXP]
          str << @text[index]
          index += 1
        end

        if Patterns::KEYWORDS[:KEYS].include?(str.downcase)
          @tokens.push(Token.new(str, Patterns::KEYWORDS[:TYPE]))
        elsif Patterns::REFERENCE[:KEYS].include?(str)
          @tokens.push(Token.new(str, Patterns::REFERENCE[:TYPE]))
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
      when /\s/
        @tokens.push(Token.new(str, Patterns::WHITE_SPACE[:TYPE])) if str =~ Patterns::WHITE_SPACE[:REGEXP]
      end
      index += 1
    end
  end
end
