module Patterns
  # Types
  KEYWORDS = { TYPE: 'keyword'.upcase, KEYS: %w[class else false fi if in inherits isvoid let loop pool then while case esac new of not true] }.freeze
  REFERENCE = { TYPE: 'reference'.upcase, KEYS: %w[self SELF_TYPE] }.freeze
  OBJECT_ID = { TYPE: 'object_id'.upcase, REGEXP: /[_[A-Za-z]]\w*?/ }.freeze
  TYPE_ID = { TYPE: 'type_id'.upcase, REGEXP: /[A-Z]\w*?/ }.freeze
  CHAR = { TYPE: 'char'.upcase, REGEXP: /'.'/ }.freeze
  STRING = { TYPE: 'string'.upcase, REGEXP: /".*?"/ }.freeze
  INT = { TYPE: 'int'.upcase, REGEXP: /\d+/ }.freeze
  WHITE_SPACE = { TYPE: 'white_space'.upcase, REGEXP: /\s*/ }.freeze

  # Utils
  COMMENT_LINE = /\A--/.freeze
  COMMENT_BLOCK = /\(\*.+?\*\)/.freeze
end
