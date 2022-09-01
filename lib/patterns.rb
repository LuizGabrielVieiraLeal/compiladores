module Patterns
  # Lang types
  KEYWORDS = { TYPE: 'keyword'.upcase, KEYS: %w[class else false fi if in inherits isvoid let loop pool then while case esac new of not true] }.freeze
  OBJECT_ID = { TYPE: 'object_id'.upcase, REGEXP: /[_[A-Za-z]]\w*?/ }.freeze
  TYPE_ID = { TYPE: 'type_id'.upcase, REGEXP: /[A-Z]\w*?/ }.freeze
  CHAR = { TYPE: 'char'.upcase, REGEXP: /'.'/ }.freeze
  STRING = { TYPE: 'string'.upcase, REGEXP: /".*?"/ }.freeze
  INT = { TYPE: 'int'.upcase, REGEXP: /\d+/ }.freeze
  WHITE_SPACE = { TYPE: 'white_space'.upcase, REGEXP: /\s+/ }.freeze
  # BRACES = { TYPE: 'braces', REGEXP: /[{}]/ }.freeze
  # BRACKETS = { TYPE: 'brackets', REGEXP: /[\[\]]/ }.freeze
  # DIGIT = { TYPE: 'digit', REGEXP: /[[:digit:]]/ }.freeze
  # OPERATOR = { TYPE: 'operator', REGEXP: /[%><=\+\-\*\/\\]/ }.freeze
  # OTHER = { TYPE: 'other', REGEXP: /\H/ }.freeze
  # PARENTHESES = { TYPE: 'parentheses', REGEXP: /[()]/ }.freeze
  # PUNCT = { TYPE: 'punct', REGEXP: /[[:punct:]]/ }.freeze

  # Utils
  COMMENT_LINE = /\A--/.freeze
  COMMENT_BLOCK = /\(\*.+?\*\)/.freeze
  SINGLE_QUOTE = /'/.freeze
  DOUBLE_QUOTE = /"/.freeze
end
