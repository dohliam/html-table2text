#!/usr/bin/ruby -KuU
# encoding: utf-8

require 'nokogiri'
require 'open-uri'

require_relative 'libhtmltable.rb'

url = ARGV[0]

if !url
  abort("  Please provide a url")
end

doc = Nokogiri::HTML(open(URI.encode(url)))

tables = doc.xpath('//table')
len = tables.length

if len < 1
  abort("  No tables found at #{url}")
end

puts "  There were #{len.to_s} tables found at the URL: #{url}"
puts "  Please enter the number of the table you would like to convert, or <Enter> for all:"
numstring = $stdin.gets.chomp
num = numstring.to_i

if !numstring.match(/^\d+$/)
  counter = 1
  doc.xpath('//table').each do |table|
    table_string = table.inner_html
    puts "==Table ##{counter.to_s}=="
    table_to_tsv(table_string)
    puts
    counter += 1
  end
  exit
end

if num > len
  abort("  Table number out of range")
end

puts "  Converting table #{numstring}..."

table_string = doc.xpath('//table')[num - 1].inner_html

table_to_tsv(table_string)
# table_to_csv(table_string)
