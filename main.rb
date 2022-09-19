require './sin'

ARGV.each do |filename|
  sin = Sin.new(filename)
  sin.top_down_analyze
end
