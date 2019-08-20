require_relative 'libhtmltable.rb'

table_1 = '<table style="width:100%">
  <tr>
    <th>City</th>
    <th>Country</th>
    <th>Population</th>
  </tr>
  <tr>
    <td>Conakry</td>
    <td>Guinea</td>
    <td>1,660,973</td>
  </tr>
  <tr>
    <td>Freetown</td>
    <td>Sierra Leone</td>
    <td>1,055,964</td>
  </tr>
  <tr>
    <td>Monrovia</td>
    <td>Liberia</td>
    <td>1,010,970</td>
  </tr>
</table>'

table_2 = '<table style="width:100%">
  <tr>
    <th>城市</th>
    <th>国家</th>
    <th>人口</th>
  </tr>
  <tr>
    <td>科纳克里</td>
    <td>几内亚</td>
    <td>1,660,973</td>
  </tr>
  <tr>
    <td>弗里敦</td>
    <td>塞拉利昂</td>
    <td>1,055,964</td>
  </tr>
  <tr>
    <td>蒙罗维亚</td>
    <td>利比里亚</td>
    <td>1,010,970</td>
  </tr>
</table>'

table_3 = '<table style="width:100%">
  <tr>
    <th>City</th>
    <th>Country</th>
    <th>Population</th>
  </tr>
  <tr>
    <td>
      <table>
        <tr><td>nested table</td></tr>
        <tr><td>nested table</td></tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>Conakry</td>
    <td>Guinea</td>
    <td>1,660,973</td>
  </tr>
  <tr>
    <td>Freetown</td>
    <td>Sierra Leone</td>
    <td>1,055,964</td>
  </tr>
  <tr>
    <td>Monrovia</td>
    <td>Liberia</td>
    <td>1,010,970</td>
  </tr>
</table>'

puts "Test: Basic table (CSV)"
puts
table_to_csv(table_1)
puts
puts "Test: Basic table (tabs)"
puts
table_to_tsv(table_1)
puts

puts "Test: Table with Unicode (CSV)"
puts
table_to_csv(table_2)
puts
puts "Test: Table with Unicode (tabs)"
puts
table_to_tsv(table_2)
puts

puts "Test: Nested table (CSV)"
puts
table_to_csv(table_3)
puts
puts "Test: Nested table (tabs)"
puts
table_to_tsv(table_3)
puts
