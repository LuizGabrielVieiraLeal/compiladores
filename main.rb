require 'colorize'
require './lex'

begin
  ARGV.each do |filename|

    lex = Lex.new(filename)

    puts lex.next_token.inspect
  end
rescue Errno::ENOENT
  puts 'Arquivo não encontrado'.red
end
