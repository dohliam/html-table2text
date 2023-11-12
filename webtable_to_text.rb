#!/usr/bin/env ruby

require 'cgi'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'reverse_markdown'
require 'reverse_adoc'

require_relative 'libhtmltable.rb'

options = {}
OptionParser.new do |opts|
  opts.banner = <<BANNER
 usage:
   webtable_to_text.rb [options] [-f FILE | -u URL]
   curl [options] URL | webtable_to_text.rb
   wget -O- [options] URL | webtable_to_text.rb

 options:
BANNER

  opts.on("-A", "--all", "Print all tables found on the specified page") { options[:all] = true }
  opts.on("-a", "--asciidoc", "Output in asciidoc/asciidoctor format") { options[:asciidoc] = true }
  opts.on("-c", "--csv", "Output in CSV / comma separated values format") { options[:csv] = true }
  opts.on("-f", "--file FILE", "Specify HTML input file as source for extracting tables; use '-' to read from stdin") { |v| options[:file] = v }
  opts.on("-i", "--interactive", "Interactive mode") { options[:interactive] = true }
  opts.on("-m", "--markdown", "Output in markdown format") { options[:markdown] = true }
  opts.on("-n", "--number NUM", "Print specific table number only; separate multiple numbers with commas") { |v| options[:number] = v }
  opts.on("-o", "--output FILE", "Specify output file (default: output to STDOUT)") { |v| options[:output] = v }
  opts.on("-r", "--raw", "Output raw table HTML") { options[:html] = true }
  opts.on("-t", "--tsv", "Output in TSV / tab separated values format (default)") { options[:tsv] = true }
  opts.on("-u", "--url URL", "Specify URL as source for extracting tables") { |v| options[:url] = v }

end.parse!

url = options[:url]
file = options[:file]

if url
  source_location = url
  escaped = escape_url(url)
  source_content = URI.open(escaped).read
elsif file
  source_location = file
  if file == "-"
    # h/t: https://stackoverflow.com/a/273841
    source_content = ARGF.read
  else
    source_content = File.read(file)
  end
else
  if $stdin.isatty
    abort("  Please provide a source file or URL as input. See '--help'.")
  end
  if options[:interactive]
    abort("  Interactive mode not supported when reading from a pipe.")
  end
  source_location = '(stdin)'
  source_content = ARGF.read
end

doc = Nokogiri::HTML(source_content)

tables = doc.xpath('//table')
len = tables.length

if len < 1
  abort("  No tables found in page at #{source_location}.")
end

numstring = "all"
if options[:number]
  numstring = options[:number]
end

if options[:interactive]
  puts "  There were #{len.to_s} tables found in the page at: #{source_location}"
  puts "  Please enter the number of the table you would like to convert, or <Enter> for all:"
  numstring = $stdin.gets.chomp
end

if numstring.match(/,/)
  multiple_tables(tables, options, numstring)
end

if !numstring.match(/^\d+$/)
  all_tables(tables, options)
end

single_table(tables, options, numstring)
