module Patterns
  COMMENT_BLOCK = { TYPE: 'comment_block', REGEXP: /\(\*.+?\*\)/ }.freeze
  COMMENT_LINE = { TYPE: 'comment_line', REGEXP: /\A--/ }.freeze
  BRACES = { TYPE: 'braces', REGEXP: /[{}]/ }.freeze
  BRACKETS = { TYPE: 'brackets', REGEXP: /[\[\]]/ }.freeze
  DIGIT = { TYPE: 'digit', REGEXP: /[[:digit:]]/ }.freeze
  IDENTIFIER = { TYPE: 'identifier', REGEXP: /[_[A-Za-z]]\w*?/ }.freeze
  OPERATOR = { TYPE: 'operator', REGEXP: /[%><=\+\-\*\/\\]/ }.freeze
  OTHER = { TYPE: 'other', REGEXP: /\H/ }.freeze
  PARENTHESES = { TYPE: 'parentheses', REGEXP: /[()]/ }.freeze
  PUNCT = { TYPE: 'punct', REGEXP: /[[:punct:]]/ }.freeze
  QUOTE = { TYPE: 'quote', REGEXP: /["']/ }.freeze
  SPACE = { TYPE: 'space', REGEXP: /[[:space:]]+/ }.freeze
end
