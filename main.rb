require 'colorize'
require './lib/patterns'
require './lex_token'

begin
  ARGV.each do |filename|
    file = File.open(filename, 'r')
    file_data = file.read.gsub(Patterns::SPACE[:REGEXP], '')

    file_data.each_char do |character|
      lex_token = LexToken.new(character)
      puts lex_token.inspect
    end
  end
rescue Errno::ENOENT
  puts 'Arquivo não encontrado'.red
end
