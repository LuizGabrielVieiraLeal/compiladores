module Patterns
  KEYWORDS = { TYPE: 'keyword'.upcase, KEYS: %w[class else false fi if in inherits isvoid let loop pool then while case esac new of not true] }.freeze
  COMMENT_BLOCK = { TYPE: 'comment_block'.upcase, REGEXP: /\(\*.+?\*\)/ }.freeze
  COMMENT_LINE = { TYPE: 'comment_line'.upcase, REGEXP: /\A--/ }.freeze
  ID = { TYPE: 'id'.upcase, REGEXP: /[_[A-Za-z]]\w*?/ }.freeze
  CHAR = { TYPE: 'char'.upcase, REGEXP: /'.'/ }.freeze
  STRING = { TYPE: 'string'.upcase, REGEXP: /".*?"/ }.freeze
  SINGLE_QUOTE = { TYPE: 'single_quote'.upcase, REGEXP: /'/ }.freeze
  DOUBLE_QUOTE = { TYPE: 'double_quote'.upcase, REGEXP: /"/ }.freeze
  # BRACES = { TYPE: 'braces', REGEXP: /[{}]/ }.freeze
  # BRACKETS = { TYPE: 'brackets', REGEXP: /[\[\]]/ }.freeze
  # DIGIT = { TYPE: 'digit', REGEXP: /[[:digit:]]/ }.freeze
  # OPERATOR = { TYPE: 'operator', REGEXP: /[%><=\+\-\*\/\\]/ }.freeze
  # OTHER = { TYPE: 'other', REGEXP: /\H/ }.freeze
  # PARENTHESES = { TYPE: 'parentheses', REGEXP: /[()]/ }.freeze
  # PUNCT = { TYPE: 'punct', REGEXP: /[[:punct:]]/ }.freeze
  # SPACE = { TYPE: 'space', REGEXP: /[[:space:]]+/ }.freeze
end
