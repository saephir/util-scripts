#!/usr/bin/perl
# 
# Dominik Jastrzębski
# 
# Skrypt zmieniający podaną frazę na inną.
# Tablica substitutions zawiera dwuelementowe
# tablice [wzorzec, zastąpienie].
# 
# Przykładowe użycie (wszystkie skrypty w kat.roboczym):
# ./substitute.pl *.py
# Wszystkie skrypty Pythona w katalogu i podkatalogach:
# find . -name "*.py" -type f -exec ./substitute.pl {} \;
#
# Na wszelki wypadek powstaje kopia zapasowa o nazwie
# ZMIENIONY_PLIK.bak. Kopie zapasowe można zbiorczo usunąć:
# find . -name "*.bak" -type f -exec rm -f {} \;

# rozszerzenie dla kopii zapasowej
$^I = '.bak'; 

my $substitutions = [ 
                     ['from libs.i18n_response import', 'from libs.i18n import'],
                     ['import libs.i18n_response', 'import libs.i18n'],
                    ];

while(<>) {
    foreach $array (@$substitutions) {
        my $from = $$array[0];
        my $to = $$array[1];
        s/\Q$from\E/$to/g;
    }
    print;
}

