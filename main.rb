require 'colorize'
require './lex_token'

begin
  ARGV.each do |filename|

    lex_token = LexToken.new(filename)
  end
rescue Errno::ENOENT
  puts 'Arquivo não encontrado'.red
end
