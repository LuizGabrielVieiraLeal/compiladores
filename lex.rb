require './lib/patterns'
require './token'

class Lex
  attr_reader :text, :tokens

  def initialize(filename)
    @text = format_text filename
    @tokens = []
    sort_tokens
  end

  private

  def format_text filename
    lines = []
    File.foreach(filename) do |line|
      line = line.strip!
      lines.push(line) unless line.match(Patterns::COMMENT_LINE[:REGEXP])
    end
    lines.join(' ').gsub(Patterns::COMMENT_BLOCK[:REGEXP], '')
  end

  def sort_tokens
    index = 0
    while index < @text.length
      word = ''
      if @text[index].match?(Patterns::ID[:REGEXP])
        while @text[index].match?(Patterns::ID[:REGEXP])
          word << @text[index]
          index += 1
        end
        @tokens.push(Token.new(word, Patterns::KEYWORDS[:KEYS].include?(word.downcase) ? Patterns::KEYWORDS[:TYPE] : Patterns::ID[:TYPE]))
      elsif @text[index].match?(Patterns::SINGLE_QUOTE[:REGEXP])
        word << @text[index]
        index += 1
        until @text[index].match?(Patterns::SINGLE_QUOTE[:REGEXP])
          word << @text[index]
          index += 1
        end
        word << @text[index]
        index += 1
        @tokens.push(Token.new(word, Patterns::CHAR[:TYPE]))
      elsif @text[index].match?(Patterns::DOUBLE_QUOTE[:REGEXP])
        word << @text[index]
        index += 1
        until @text[index].match?(Patterns::DOUBLE_QUOTE[:REGEXP])
          word << @text[index]
          index += 1
        end
        word << @text[index]
        index += 1
        @tokens.push(Token.new(word, Patterns::STRING[:TYPE]))
      end

      index += 1
    end
  end
end
