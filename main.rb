require './sin'

ARGV.each do |filename|
  sin = Sin.new(filename)
  sin.top_down_analyze

  sin.errors.each { |error| puts error }
end
