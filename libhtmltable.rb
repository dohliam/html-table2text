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
