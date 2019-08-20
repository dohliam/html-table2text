# HTML Table to Text - Script for extracting and converting HTML tables

This is a simple interactive script that can extract any or all tables from a given HTML file. The data can be output to CSV (comma-separated values), or TSV (tab-separated values).

## Requirements

This script relies on Nokogiri to parse HTML. You can install it with:

    gem install nokogiri

## Usage

To extract tables from an arbitrary URL, just run the `webtable_to_text` script with the URL as an argument:

    ./webtable_to_text.rb [URL]

For example:

    ./webtable_to_text.rb "https://en.wikipedia.org/wiki/Gabon"

This will print a message with the total number of tables found in the document. If you enter a number at the prompt, it will print the corresponding table. Otherwise, pressing ENTER or RETURN will print all tables found.

For example, pressing `3` will print something like the following:

    Population in Gabon
    Year	Million 
    1950	0.5 
    2000	1.2 
    2016	2

The script also works with local files, e.g.:

    ./webtable_to_text.rb some_file.html

To run tests, just enter the following command:

    ruby tests.rb

## To do

* add options and non-interactive mode
* output to raw html
* output to markdown
* output to AsciiDoc

## Credits

* Table extaction to CSV based on [this Stack Overflow answer](https://stackoverflow.com/a/1403325) by user audiodude.

## License

MIT.