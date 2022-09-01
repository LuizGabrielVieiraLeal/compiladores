require 'colorize'
require './lex'

begin
  ARGV.each do |filename|

    lex = Lex.new(filename)

    # puts lex.text

    lex.tokens.each { |t| puts t.inspect }
  end
rescue Errno::ENOENT
  puts 'Arquivo não encontrado'.red
end
