#!usr/bin/perl

print "Konwersja <br> i <br/> na <br />\n";
print 'Podaj katalog: ';
my $dirname = <>;
chomp $dirname;
opendir my $dir,$dirname;

for (readdir $dir) {
		if ($_ =~ m/\.html|\.php/) {
		print $_."\n";
		open $file,$_;
		@data = <$file>;
		close $file;
		open $writehandle,">$_";
		$_ =~ s/<br>|<br\/>/<br \/>/g for @data;
		print $writehandle @data;
		close $writehandle;
	}
}
print 'Skrypt zakonczyl prace.';
<>;