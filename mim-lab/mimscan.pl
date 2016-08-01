#!/usr/bin/perl

#
# Skaner portów dla komputerów
# Laboratorium Komputerowego MiM
# 
# Domyślnie skanowany jest port 22 (SSH).
#
# Przykładowe użycie:
# ./mimscan
# informacja o statusie wszystkich maszyn
# ./mimscan | grep on
# wypisz tylko te maszyny,
# które mają otwarty port.
#
# autor: Dominik Jastrzębski
#

use Term::ANSIColor;
use IO::Socket;

# maszyny w labach
my @colors = sort ('red', 'pink', 'orange', 'brown', 'yellow',
	   			'khaki', 'green', 'cyan', 'blue', 'violet');
my @numbers = 1..16;

# inne maszyny
my @other = sort('duch', 'zodiac', 'rainbow', 'spider', 'students');

# port, który skanujemy (domyślnie SSH: 22)
my $port = 22;

# czas timeoutu w sekundach
my $timeout = 0.1;

# wszystkie
my @all = @other;

foreach(@colors) {
	my $color = $_;
	foreach(@numbers) {
		my $number = $_;
		my $total = $color;
		$total .= '0' if $number < 10;
		$total .= $number;
		push @all, $total;
	}
}

sort @all;

foreach(@all) {
	# Udane połączenie
	if(IO::Socket::INET->new(PeerAddr => $_, PeerPort => $port,
				   	Proto => 'tcp', Timeout => $timeout))
	{
		print $_.' ';
		print color("green"), "on", color("reset");
		print "\n";
	}
	# Błąd połączenia
	else {
		print $_.' ';
		print color("red"), "off", color("reset");
		print "\n";
	}
}
