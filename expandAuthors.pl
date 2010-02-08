#!/usr/bin/perl

$separator = ", ";
while(<>)
{
	print $_;
	if( $_ =~ m#\\paper\{[^}]+\}\{([^}]+)\}#)
	{
		#split the line
		split /$separator/,$1;

		foreach $author (@_)
		{
			#split on the first space
			if($author =~ m/^([^ ]+)[\s+](.*)$/)
			{
				print "\\index{$2, $1}\n";
			}
		}
	}
}
