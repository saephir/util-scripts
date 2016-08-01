#!/usr/bin/perl
# 
# autor: Dominik Jastrzębski
#
# Skrypt poprawia kolejność docstringów Pythona.
# Przerzuca komentarze sprzed definicji funkcji i klas
# do pierwszej linijki za deklaracją.
# 
# Przykładowe użycie (wszystkie skrypty w kat.roboczym):
# ./move_comments.pl *.py
# Wszystkie skrypty Pythona w katalogu i podkatalogach:
# find . -name "*.py" -type f -exec ./move_comments.pl {} \;
#
# Na wszelki wypadek powstaje kopia zapasowa o nazwie
# ZMIENIONY_PLIK.bak. Kopie zapasowe można zbiorczo usunąć:
# find . -name "*.bak" -type f -exec rm -f {} \;

# rozszerzenie dla kopii zapasowej
$^I = '.bak';
# szerokość wcięcia w spacjach
my $INDENT_WIDTH = 4;
# bufor na kolejne linie komentarzy
my @comment_buffer = ();
# czy jesteśmy bezpośrednio po deklaracji?
# wtedy należy zignorować pierwszy blok komentarzy
my $just_after_decl = 0;

sub process_token {
    ($_) = @_;
    # deklaracja funkcji lub klasy
    if(m/^(\s*)(def|class).+/)  {
        print;
        # wypisz i opróżnij bufor komentarzy
        foreach(@comment_buffer) {
            # zwiększ wcięcie
            for($i = 0; $i < $INDENT_WIDTH; $i++) {
                print ' ';
            }
            print;
        }
        @comment_buffer = ();
        $just_after_decl = 1;
    }
    # komentarz
    elsif(m/"""/) {
        if(!$just_after_decl) {
            push @comment_buffer, $_;
        }
        else {
            print;
        }
    }
    # linia niebędąca komentarzem ani deklaracją
    else {
        # wypisz i opróżnij bufor
        for(@comment_buffer) {
            print;
        }
        @comment_buffer = ();
        print;
        if($just_after_decl) {
            $just_after_decl = 0;
        }
    }
}

while(<>) {
    process_token($_);
}

# opróżnij bufor komentarzy, jeśli coś jeszcze zostało
for(@comment_buffer) {
    print;
}

