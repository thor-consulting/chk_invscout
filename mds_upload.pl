#! /usr/bin/perl -w # -Dv

##
## <BOT> mds_upload.pl
##
## mds_upload.pl - upload Inventory Scout survey file (.mup file) to Microcode Discovery Service.
##
## GitHub  : https://github.com/STVIN/chk_invscout
## Author  : Don Thornton Jr.
##

# [ pragma declarations ]

	require LWP::UserAgent ;

# [ global constants ]

	$DEBUG = $ENV { 'DEBUG' } ;

	$HOSTNAME = $ENV { 'HOSTNAME' } ;

	warn ( "HOSTNAME = |$HOSTNAME|" ) if ( $DEBUG ) ;

# [ script body ]

	$ua = LWP::UserAgent -> new ;

	$ua -> timeout ( 10 ) ;

	$ua -> env_proxy ;

	my $response = $ua -> post (
		'http://www14.software.ibm.com/webapp/set2/mds/mds' ,
        	Content_Type => 'form-data' ,
        	Content      => [ submit => 1 , mdsData =>  [ "/var/adm/invscout/$HOSTNAME.mup" ] ]
	) ;

	if ( $response -> is_success )
	{
		warn (  $response -> content ) if ( $DEBUG ) ;

		$output = $response -> content ;

		$output =~ s@</head>@<base href="http://www14.software.ibm.com/" />\n\n</head>@g ;

		print $output ;
	}
	else
	{
		die $response -> status_line ;
	}

	exit ( 0 ) ;

##
## <EOT> mds_upload.pl
##
