def table_to_csv(table_string)
  doc = Nokogiri::HTML(table_string)

  doc.xpath('//tr').each do |row|
    row.xpath('th | td').each do |cell|
      print '"', cell.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m, '\1'), "\", "
    end
    print "\n"
  end
end

def table_to_tsv(table_string)
  doc = Nokogiri::HTML(table_string)

  doc.xpath('//tr').each do |row|
    row.xpath('th | td').each do |cell|
      print cell.text.gsub("\n", ' ').gsub('\t', '\\t').gsub(/(\s){2,}/m, '\1'), "\t"
    end
    print "\n"
  end
end

def print_table(options, table_string)
  if options[:tsv]
    table_to_tsv(table_string)
  elsif options[:csv]
    table_to_csv(table_string)
  elsif options[:markdown]
    puts ReverseMarkdown.convert(table_string)
  elsif options[:asciidoc]
    puts ReverseAsciidoctor.convert(table_string)
  elsif options[:html]
    puts table_string
  else
    table_to_tsv(table_string)
  end
end

def single_table(tables, options, numstring)
  num = numstring.to_i

  if num > tables.length
    abort("  Table number out of range")
  end

  if options[:interactive]
    puts "  Converting table #{numstring}..."
  else
    puts "==Table ##{numstring}=="
  end

  table_string = tables[num - 1].inner_html

  print_table(options, table_string)
end

def multiple_tables(tables, options, numstring)
  num_array = numstring.split(",")
  num_array.each do |n|
    if !n.match(/\d/) then next end
    single_table(tables, options, n)
    puts
  end
  exit
end

def all_tables(tables, options)
  counter = 1
  tables.each do |table|
    table_string = table.inner_html
    puts "==Table ##{counter.to_s}=="
    print_table(options, table_string)
    puts
    counter += 1
  end
  exit
end
