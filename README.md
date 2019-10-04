# HTML Table to Text - Script for extracting and converting HTML tables

This is a simple (optionally interactive) script that can extract any or all tables from a given HTML file or URL. The data can be output to CSV (comma-separated values), TSV (tab-separated values), Markdown, or raw HTML.

## Requirements

This script relies on [Nokogiri](https://nokogiri.org/) to parse HTML. You can install it with:

    gem install nokogiri

Markdown conversion uses [reverse_markdown](https://github.com/xijo/reverse_markdown) which can be installed the same way:

    gem install reverse_markdown

## Usage

To extract tables from an arbitrary URL, just run the `webtable_to_text` script with the `-u` option followed by the URL:

    ./webtable_to_text.rb -u [URL]

For example:

    ./webtable_to_text.rb -u "https://en.wikipedia.org/wiki/Gabon"

This will print out all the tables found on the specified page.

To output a specific table only, use the `n` option, followed by the number of the table:

    ./webtable_to_text.rb -u "https://en.wikipedia.org/wiki/Gabon" -n 3

The script also works with local files, using the `f` option, e.g.:

    ./webtable_to_text.rb -f some_file.html

### Interactive mode

To use interactive mode, add the `-i` option to the command and specify a URL or file as normal. For example:

    ./webtable_to_text.rb -u "https://en.wikipedia.org/wiki/Gabon" -i

This will print a message with the total number of tables found in the document. If you enter a number at the prompt, it will print the corresponding table. Otherwise, pressing ENTER or RETURN will print all tables found.

For example, pressing `3` will print something like the following:

    Population in Gabon
    Year	Million 
    1950	0.5 
    2000	1.2 
    2016	2

To run tests, just enter the following command:

    ruby tests.rb

### Options

The following options are available:

* `-a`, `--all`: _Print all tables found on the specified page_
* `-c`, `--csv`: _Output in CSV / comma separated values format_
* `-f`, `--file FILE`: _Specify HTML input file as source for extracting tables_
* `-h`, `--help`: _Print help text_
* `-i`, `--interactive`: _Interactive mode_
* `-m`, `--markdown`: _Output in markdown format_
* `-n`, `--number NUM`: _Print specific table number only; separate multiple numbers with commas_
* `-o`, `--output FILE`: _Specify output file (default: output to STDOUT)_
* `-r`, `--raw`: _Output raw table HTML_
* `-t`, `--tsv`: _Output in TSV / tab separated values format (default)_
* `-u`, `--url URL`: _Specify URL as source for extracting tables_

## To do

* ~~add options and non-interactive mode~~
* ~~output to raw HTML~~
* ~~output to Markdown~~
* output to AsciiDoc

## Credits

* Table extaction to CSV based on [this Stack Overflow answer](https://stackoverflow.com/a/1403325) by user audiodude.

## License

MIT.
