require './lib/patterns'

class LexToken
  attr_reader :value, :type

  def initialize(character)
    @value = character
    @type = sort_token(character)
  end

  private

  def sort_token(character)
    @type = if character.match(Patterns::DIGIT[:REGEXP])
              Patterns::DIGIT[:TYPE]
            elsif character.match(Patterns::WORD[:REGEXP])
              Patterns::WORD[:TYPE]
            elsif character.match(Patterns::OPERATOR[:REGEXP])
              Patterns::OPERATOR[:TYPE]
            elsif character.match(Patterns::BRACES[:REGEXP])
              Patterns::BRACES[:TYPE]
            elsif character.match(Patterns::BRACKETS[:REGEXP])
              Patterns::BRACKETS[:TYPE]
            elsif character.match(Patterns::PARENTHESES[:REGEXP])
              Patterns::PARENTHESES[:TYPE]
            elsif character.match(Patterns::QUOTE[:REGEXP])
              Patterns::QUOTE[:TYPE]
            elsif character.match(Patterns::PUNCT[:REGEXP])
              Patterns::PUNCT[:TYPE]
            elsif character.match(Patterns::OTHER[:REGEXP])
              Patterns::OTHER[:TYPE]
            end
  end
end
