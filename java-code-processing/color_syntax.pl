#!/usr/local/bin/perl
use warnings;

# Dominik Jastrzębski (Saephir).
# Skrypt koloruje składnię Javy
# w podanym pliku tekstowym.

print "Podaj nazwe pliku do otwarcia\r\n";
chomp(my $filename = <STDIN>);

open(UCHWYT,$filename) or die "Plik o nazwie $filename nie istnieje!";

my @plik = <UCHWYT>;
close UCHWYT;
my $total = '';
foreach(@plik) {
	$total .= $_;
}

my %colortable = ("class" => "orchid","public" => "orange","abstract" => "orange","static" => "orange",
		"protected" => "orange","void" => "lightblue","int" => "lightblue","float" => "lightblue","double" => "lightblue",
		"char" => "lightblue","byte" => "lightblue","interface" => "orchid","private" => "orange","if" => "orchid",
		"while" => "orchid", "for" => "orchid", "try" => "orchid", "catch" => "orchid", "else" => "orchid",
		"import" => "yellow", "new" => "lightgreen","extends" => "pink","implements" => "pink","boolean" => "lightblue",
		"short" => "lightblue", "long" => "lightblue","return" => "lightgreen", "true" => "lightblue",
		"false" => "lightblue", "this" => "lightgreen", "super" => "lightgreen", "null" => "lightblue"); 
my @keys = keys(%colortable);
foreach (@keys) {
	$total =~ s{(\b)$_(\b)}{$1<font style=\"color: $colortable{$_}; font-weight: bold; font-family: Courier New; font-size: 10pt;\">$_</font>$2}g;
}

print "Podaj nazwe pliku do zapisu (zostaw puste dla standardowego wyjscia)\r\n";
chomp(my $filename2 = <STDIN>);
if(length($filename2) != 0) {
	open(UCHWYT2,'>',$filename2);
	print UCHWYT2 $total;
	close UCHWYT2;
	print 'Skrypt zakonczyl prace.';
}
else {
	print $total;
}
<STDIN>;
