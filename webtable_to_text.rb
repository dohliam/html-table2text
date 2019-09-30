#!/usr/bin/ruby -KuU
# encoding: utf-8

require 'nokogiri'
require 'open-uri'
require 'optparse'

require_relative 'libhtmltable.rb'

def print_table(options, table_string)
  if options[:tsv]
    table_to_tsv(table_string)
  elsif options[:csv]
    table_to_csv(table_string)
  elsif options[:markdown]
  #   table_to_md(table_string)
  else
    table_to_tsv(table_string)
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = "  Usage: webtable_to_text.rb [options]"

  opts.on("-a", "--all", "Print all tables found on the specified page") { options[:all] = true }
  opts.on("-n", "--number NUM", "Print specific table number only") { |v| options[:number] = v }
  opts.on("-c", "--csv", "Output in CSV / comma separated values format") { options[:csv] = true }
  opts.on("-f", "--file FILE", "Specify HTML file as source for extracting tables") { |v| options[:file] = v }
  opts.on("-i", "--interactive", "Interactive mode") { options[:interactive] = true }
  opts.on("-t", "--tsv", "Output in TSV / tab separated values format (default)") { |v| options[:tsv] = v }
  opts.on("-m", "--markdown", "Output in markdown format") { options[:markdown] = true }
  opts.on("-o", "--output FILE", "Specify output file (default: output to STDOUT)") { |v| options[:output] = v }
  opts.on("-u", "--url URL", "Specify URL as source for extracting tables") { |v| options[:url] = v }

end.parse!

url = options[:url]

if !url
  abort("  Please provide a url")
end

doc = Nokogiri::HTML(open(URI.encode(url)))

tables = doc.xpath('//table')
len = tables.length

if len < 1
  abort("  No tables found at #{url}")
end

numstring = "all"
if options[:number]
  numstring = options[:number]
end

if options[:interactive]
  puts "  There were #{len.to_s} tables found at the URL: #{url}"
  puts "  Please enter the number of the table you would like to convert, or <Enter> for all:"
  numstring = $stdin.gets.chomp
end

if !numstring.match(/^\d+$/)
  counter = 1
  doc.xpath('//table').each do |table|
    table_string = table.inner_html
    puts "==Table ##{counter.to_s}=="
    print_table(options, table_string)
    puts
    counter += 1
  end
  exit
end

num = numstring.to_i

if num > len
  abort("  Table number out of range")
end

if options[:interactive]
  puts "  Converting table #{numstring}..."
else
  puts "==Table ##{numstring}=="
end

table_string = doc.xpath('//table')[num - 1].inner_html

print_table(options, table_string)
