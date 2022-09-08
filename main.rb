require 'colorize'
require './lex'

begin
  ARGV.each do |filename|

    lex = Lex.new(filename)
    lex.tokens.each { |token| puts token.inspect }
    lex.errors.each { |error| puts error.red }
  end
rescue Errno::ENOENT
  puts 'Arquivo não encontrado'.red
end
