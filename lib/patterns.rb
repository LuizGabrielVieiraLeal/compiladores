module Patterns
  KEYWORDS = { TYPE: 'keyword'.upcase, KEYS: %w[class else fi if in inherits isvoid let loop pool then while case esac new of not] }.freeze
  SELF_REFERENCE = { TYPE: 'self_reference'.upcase, KEYS: %w[self SELF_TYPE] }.freeze
  OBJECT_ID = { TYPE: 'object_id'.upcase, REGEXP: /[_[A-Za-z]]\w*?/ }.freeze
  TYPE_ID = { TYPE: 'type_id'.upcase, REGEXP: /[A-Z]\w*?/ }.freeze
  CHAR = { TYPE: 'char'.upcase, REGEXP: /'.?'/ }.freeze
  STRING = { TYPE: 'string'.upcase, REGEXP: /".*?"/ }.freeze
  INT = { TYPE: 'int'.upcase, REGEXP: /\d+/ }.freeze
  BOOL = { TYPE: 'boolean'.upcase, KEYS: %w[false true] }.freeze
  OPERATORS = { TYPE: 'operator'.upcase, REGEXP: /[\+\-\*\/~><=]/ }.freeze
  OPEN_EXP = { TYPE: 'open_exp'.upcase, REGEXP: /\(/ }.freeze
  CLOSE_EXP = { TYPE: 'close_exp'.upcase, REGEXP: /\)/ }.freeze
  OPEN_SCOPE = { TYPE: 'open_scope'.upcase, REGEXP: /\{/ }.freeze
  CLOSE_SCOPE = { TYPE: 'close_scope'.upcase, REGEXP: /}/ }.freeze
  PUNCT = { TYPE: 'punct'.upcase, REGEXP: /[.,;:]/ }.freeze
end
