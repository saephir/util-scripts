#!/usr/bin/perl
#
# autor: Dominik Jastrzębski
#
# Skrypt generuje automatycznie komentarze
# docstring dla kodu pythona wraz ze znacznikiem TODO
# we wszystkich miejscach, gdzie jeszcze nie występują.
#
# Przykładowe użycie (wszystkie skrypty w kat.roboczym):
# ./autocomment.pl *.py
# Wszystkie skrypty Pythona w katalogu i podkatalogach:
# find . -name "*.py" -type f -exec ./autocomment.pl {} \;
#
# Na wszelki wypadek powstaje kopia zapasowa o nazwie
# ZMIENIONY_PLIK.bak. Kopie zapasowe można zbiorczo usunąć:
# find . -name "*.bak" -type f -exec rm -f {} \;

# rozszerzenie dla kopii zapasowej
$^I = '.bak';
# szerokość wcięcia w spacjach
my $INDENT_WIDTH = 4;
# treść komentarza
my $comment = '""" TODO: dodać komentarz """';

sub process_token {
    ($_) = @_;
    print;
    if(m/^(\s*)(def|class).+/)  {
        my $whitespace = $1;
        # odczytaj następny wiersz
        my $next_line = <>;
        unless($next_line =~ m/\"\"\"/) {
            print $whitespace;
            for($i = 0; $i < $INDENT_WIDTH; $i++) {
                print ' ';
            }
            print $comment."\n";
        }
        process_token($next_line);
    }
}

while(<>) {
    process_token($_);
}
