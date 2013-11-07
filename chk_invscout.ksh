#! /usr/bin/ksh

##
## <BOT> chk_invscout.ksh
##
## chk_invscout.ksh - perform automated check of AIX inventory scout procedure.
##
## GitHub  : https://github.com/STVIN/chk_invscout
## Author  : Don Thornton Jr.
##

	export HOSTNAME="`/usr/bin/hostname -s `"

	export TODAY="`date '+%Y_%m_%d'`"

	[ -d /var/adm/invscout/log ] || mkdir /var/adm/invscout/log

	[ -d /var/adm/invscout/tmp ] || mkdir /var/adm/invscout/tmp

	mv -f /var/adm/invscout/microcode/catalog.mic /var/adm/invscout/microcode/catalog.mic.bak

	/opt/freeware/bin/wget http://techsupport.services.ibm.com/server/mdownload/catalog.mic \
		-O /var/adm/invscout/microcode/catalog.mic 2>> /tmp/wget.err

	/usr/sbin/invscout 1>/var/adm/invscout/log/invscout-`date '+%Y_%m_%d-%H:%M:%S'`

	if [ -s /var/adm/invscout/${HOSTNAME}.mup ]
	then
		/usr/local/bin/mds_upload.pl > /var/adm/invscout/tmp/mds_${HOSTNAME}-${TODAY}.htm

		if /usr/bin/egrep -q "<font color='red'>" /var/adm/invscout/tmp/mds_${HOSTNAME}-${TODAY}.htm
		then
			echo "" | \
				# /opt/freeware/bin/mutt -e 'my_hdr Content-Type: text/html' -e 'my_hdr Content-Disposition: inline' -s "chk_invscout : ${HOSTNAME}" \
				/opt/freeware/bin/mutt -s "chk_invscout : ${HOSTNAME}" \
					-a /var/adm/invscout/tmp/mds_${HOSTNAME}-${TODAY}.htm root

			break
		fi

		if /usr/bin/egrep -q "<font color=red>" /var/adm/invscout/tmp/mds_${HOSTNAME}-${TODAY}.htm
		then
			echo "" | \
				# /opt/freeware/bin/mutt -e 'my_hdr Content-Type: text/html' -e 'my_hdr Content-Disposition: inline' -s "chk_invscout : ${HOSTNAME}" \
				/opt/freeware/bin/mutt -s "chk_invscout : ${HOSTNAME}" \
					-a /var/adm/invscout/tmp/mds_${HOSTNAME}-${TODAY}.htm root

			break
		fi

		/usr/bin/mv -f /var/adm/invscout/${HOSTNAME}.mup /var/adm/invscout/${HOSTNAME}.mup.bak
	else
		print -u2 "chk_invscout: invscout failed to create .mup file"
	fi

##
## <EOT> chk_invscout.ksh
##
