#! /usr/bin/perl -w # -Dv

##
## <BOT> mds_parse.pl
##
## mds_parse.pl - parse Microcode Discovery Service HTML output.
##
## GitHub  : https://github.com/STVIN/chk_invscout
## Author  : Don Thornton Jr.
##

# [ pragma declarations ]

	use English ;

# [ global constants ]

	$DEBUG = $ENV { 'DEBUG' } ;

	%TAB_HASH = ( ) ;

# [ script body ]

	$i = 1 ;

	while ( <> )
	{
		chop ;

		if ( /<table class='ibm-data-table' / .. /<\/table/ )
		{
			next if ( /<table class='ibm-data-table' / ) ;

			if ( /<\/table/ )
			{
				print ( ">>>\n" , join ( "\n" , @lines ) , "\n<<<\n" ) if ( $DEBUG ) ;

				map { s:</td>:,:g ; s:</th>:,:g ; s:<br/>: :g ; s:<.*?>::g ; s:&nbsp;: :g } @lines ;

				@{ $TAB_HASH{$i++} } = @lines ;

				@lines = ( ) ;
			}
			else
			{
				push ( @lines , $_ ) ;
			}
		}
	}

	if ( $DEBUG ) { for $key ( keys %TAB_HASH ) { print ( "$key => $TAB_HASH{$key}\n" ) } }

	$table = 1 ;

	print ( "Microcode by Host\n" ) ;

	$line = "" ;

	$i = 0 ;

	foreach ( @{$TAB_HASH{$table}} )
	{
		# next if ( /^ $/ ) ;

		# printf ( "%d - >>>$_<<<\n" , $i++ ) ;

		if ( /^$/ )
		{
			# print ( "LINE: " , $line , "<<<\n" ) ;
			print ( "$line\n" ) if ( length ( $line ) ) ;

			$line = "" ;
		}
		else
		{
			s/^  *//g ;

			s/  *$//g ;

			$line .= "$_," ;
		}
	}

	print ( "$line\n" ) if ( length ( $line ) ) ;

	print ( "\n" ) ;

	$table = 2 ;

	$line = "" ;

	$i = 4 ;

	foreach ( @{$TAB_HASH{$table}} )
	{
		# next if ( /^ $/ ) ;

		# printf ( "%d - >>>$_<<<\n" , $i++ ) ;

		if ( /^$/ )
		{
			# print ( "LINE: " , $line , "<<<\n" ) ;
			print ( "$line\n" ) if ( length ( $line ) ) ;

			$line = "" ;
		}
		else
		{
			s/^  *//g ;

			s/  *$//g ;

			$line .= "$_" ;
		}
	}

	print ( "$line\n" ) if ( length ( $line ) ) ;

	print ( "\n" ) ;

	$table = 3 ;

	print ( "Microcode by Type\n" ) ;

	$line = "" ;

	$i = 0 ;

	foreach ( @{$TAB_HASH{$table}} )
	{
		# next if ( /^ $/ ) ;

		# printf ( "%d - >>>$_<<<\n" , $i++ ) ;

		if ( /^$/ )
		{
			# print ( "LINE: " , $line , "<<<\n" ) ;
			print ( "$line\n" ) if ( length ( $line ) ) ;

			$line = "" ;
		}
		else
		{
			s/^  *//g ;

			s/  *$//g ;

			$line .= "$_" ;
		}
	}

	print ( "$line\n" ) if ( length ( $line ) ) ;

	exit ( 0 ) ;

##
## <EOT> mds_parse.pl
##
