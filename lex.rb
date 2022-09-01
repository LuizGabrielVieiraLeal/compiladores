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
      lines.push(line) unless line.match(Patterns::COMMENT_LINE)
    end
    lines.join(' ').gsub(Patterns::COMMENT_BLOCK, '')
  end

  def sort_tokens
    index = 0
    while index < @text.length
      word = ''
      if @text[index] =~ Patterns::OBJECT_ID[:REGEXP]
        while @text[index] =~ Patterns::OBJECT_ID[:REGEXP]
          word << @text[index]
          index += 1
        end

        type = if word =~ Patterns::TYPE_ID[:REGEXP]
                 Patterns::TYPE_ID[:TYPE]
               else
                 Patterns::KEYWORDS[:KEYS].include?(word.downcase) ? Patterns::KEYWORDS[:TYPE] : Patterns::OBJECT_ID[:TYPE]
               end
        @tokens.push(Token.new(word, type))
      elsif @text[index] =~ Patterns::SINGLE_QUOTE
        word << @text[index]
        index += 1
        until @text[index] =~ Patterns::SINGLE_QUOTE
          word << @text[index]
          index += 1
        end
        word << @text[index]
        index += 1
        @tokens.push(Token.new(word, Patterns::CHAR[:TYPE]))
      elsif @text[index] =~ Patterns::DOUBLE_QUOTE
        word << @text[index]
        index += 1
        until @text[index] =~ Patterns::DOUBLE_QUOTE
          word << @text[index]
          index += 1
        end
        word << @text[index]
        index += 1
        @tokens.push(Token.new(word, Patterns::STRING[:TYPE]))
      elsif @text[index] =~ Patterns::INT[:REGEXP]
        word << @text[index]
        index += 1
        while @text[index] =~ Patterns::INT[:REGEXP]
          word << @text[index]
          index += 1
        end
        @tokens.push(Token.new(word, Patterns::INT[:TYPE]))
      # elsif @text[index] =~ Patterns::WHITE_SPACE[:REGEXP]
      #   while @text[index] =~ Patterns::WHITE_SPACE[:REGEXP]
      #     word << @text[index]
      #     index += 1
      #   end
      #   @tokens.push(Token.new(word, Patterns::WHITE_SPACE[:TYPE]))
      end

      index += 1
    end
  end
end
