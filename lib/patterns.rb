module Patterns
  BRACES = { TYPE: 'braces', REGEXP: /[{}]/ }
  BRACKETS = { TYPE: 'brackets', REGEXP: /[\[\]]/ }
  DIGIT = { TYPE: 'digit', REGEXP: /[[:digit:]]/ }
  LETTER = { TYPE: 'letter', REGEXP: /[_[A-Za-z]]/ }
  OPERATOR = { TYPE: 'operator', REGEXP: /[%><=\+\-\*\/\\]/ }
  OTHER = { TYPE: 'other', REGEXP: /\H/ }
  PARENTHESES = { TYPE: 'parentheses', REGEXP: /[()]/ }
  PUNCT = { TYPE: 'punct', REGEXP: /[[:punct:]]/ }
  QUOTE = { TYPE: 'quote', REGEXP: /["']/ }
  SPACE = { TYPE: 'space', REGEXP: /[[:space:]]+/ }
end
