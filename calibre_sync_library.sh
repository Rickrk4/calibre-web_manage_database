#!/bin/sh

apt update
apt install -y inotify-tools

MONITORDIR=$1
LIBRARYDIR=$2

calibredb add -r $MONITORDIR --with-library $LIBRARYDIR
echo "MONITORING $MONITORDIR"
inotifywait -mr -e move -e create -e delete -e modify --format '%w%f;%e' "${MONITORDIR}" | while read string
do
	
	file=\"$(echo $string | awk -F\; '{print $1}')\"
	event=$(echo $string | awk -F\; '{print $2}')

	case ${event} in
		CREATE|CREATE,ISDIR|MOVED_TO)
		echo "ADD $file"
		bash -c "calibredb add ${file} --with-library $LIBRARYDIR"
		;;
		DELETE|DELETE,ISDIR|MOVED_FROM)
		echo "REMOVE $file"
		#bash -c "calibredb remove ${file} --with-library $LIBRARYDIR"
		;;
	esac
done

