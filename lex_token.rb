require './lib/patterns'

class LexToken
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
    @text.each_char.with_index do |char, index|
      if char.match(Patterns::IDENTIFIER[:REGEXP])
        puts char
        puts index
      end
    end
  end
end
