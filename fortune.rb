#! /usr/bin/env ruby -w

require 'optparse'
require 'erb'

require_relative 'quote'

options = {}

OptionParser.new do |opts|
  opts.on('-fFILE', '--fortune-file=FILE', 'Generate an XML representation from the Fortune file.') do |file|
    raise "#{file} doesn't exist" unless File.exists?(file)
    options[:fortune] = file
  end
end.parse!


separator = /^%$/

file = File.read(options[:fortune])
@collection = file.split(separator)

# remove anything that's just whitespace
@collection.reject! do |str|
  str =~ /^\s$/
end

# separate quotes from authors
@collection.map! do |quote|
  quote_and_author = quote.split(/    -- /)
  quote_and_author.map! do |str|
    str.strip!
  end
  Quote.new(quote_and_author)
end



puts ERB.new(File.read("template.xml.erb")).result(binding)

