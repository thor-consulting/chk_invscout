chk_invscout
============

Perform automated check of AIX inventory scout procedure.


== INSTALL ==

	clone chk_invscout from github:

	$ git clone git://github.com/STVIN/chk_invscout.git

	chdir to chk_invscout

	$ cd chk_invscout

	copy files to /usr/local/bin

	$ sudo cp -i chk_invscout.ksh mds_upload.pl mds_parse.pl /usr/local/bin/


== RUN ==

	run chk_invscout.ksh as root:

	$ sudo /usr/local/bin/chk_invscout.ksh


== NOTES ==

	The output from uploading the inventory scout file (.mup) is an HTML file that is emailed as an attachment to root.

