module Patterns
  BRACES = { TYPE: 'braces', REGEXP: /[{}]/ }
  BRACKETS = { TYPE: 'brackets', REGEXP: /[\[\]]/ }
  DIGIT = { TYPE: 'digit', REGEXP: /[[:digit:]]+/ }
  OPERATOR = { TYPE: 'operator', REGEXP: /[%><=\+\-\*\/\\]/ }
  OTHER = { TYPE: 'other', REGEXP: /\H/ }
  PARENTHESES = { TYPE: 'parentheses', REGEXP: /[()]/ }
  PUNCT = { TYPE: 'punct', REGEXP: /[[:punct:]]/ }
  QUOTE = { TYPE: 'quote', REGEXP: /["']/ }
  WORD = { TYPE: 'word', REGEXP: /[_[A-Za-z]]+/ }
end
