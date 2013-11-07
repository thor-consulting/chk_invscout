chk_invscout
============

Perform automated check of AIX inventory scout procedure.


== DOWNLOAD ==

	using git: clone chk_invscout from github:

	$ git clone git://github.com/STVIN/chk_invscout.git

	using wget: download chk_invscout from github:

	$ wget https://github.com/STVIN/chk_invscout/archive/master.zip


== INSTALL ==

	chdir to chk_invscout

	$ cd chk_invscout

	copy files to /usr/local/bin

	$ sudo cp -i chk_invscout.ksh mds_upload.pl mds_parse.pl /usr/local/bin/


== RUN ==

	run chk_invscout.ksh as root:

	# /usr/local/bin/chk_invscout.ksh


== NOTES ==

	The output from uploading the inventory scout file (.mup) is an HTML file that is emailed as an attachment to root.

