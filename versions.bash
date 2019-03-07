#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
exitCode=0

getEntry() {
	while IFS=',' read -r appname appversion appcmd; do
		case $appname in
			"aws") actualVersion="$(aws --version 2>&1 | awk '{aws=$1; split(aws,awsarr,"/"); print awsarr[2]}')";;
			"curl") actualVersion="$(curl --version 2>&1 | head -n1 | awk '{print $2}')";;
			"docker") actualVersion="$(docker version | grep Version | head -n1 | awk '{print $2}')";;
			"g++") actualVersion="$(g++ -dumpversion)";;
			"gcc") actualVersion="$(gcc -dumpversion)";;
			"gradle") actualVersion="$(gradle --version | grep Gradle | awk '{print $2}')";;
			"grunt") actualVersion="$(grunt --version | awk '{print $2}' | head -n1)";;
			"java") actualVersion="$(java -version 2>&1 | head -n 1 | cut -d'"' -f2)";;
			"kernel") actualVersion="$(uname -r)";;
			"mvn") actualVersion="$(mvn --version 2>&1 | head -n1 | awk '{print $3}')";;
			"node") actualVersion="$(node --version)";;
			"perl") actualVersion="$(perl -e 'print $];')";;
			"php") actualVersion="$(php --version 2>&1 | head -n1 | awk '{print $2}')";;
			"pip") actualVersion="$(pip --version 2>&1 | awk '{print $2}')";;
			"puppet") actualVersion="$(puppet --version)";;
			"python") actualVersion=$(python --version 2>&1 | awk '{print $2}');;
			"ruby") actualVersion="$(ruby --version 2>&1 | head -n1 | awk '{print $2}')";;
			"wget") actualVersion="$(wget --version 2>&1 | head -n1 | awk '{print $3}')";;
			*) actualVersion="$($appcmd)";;
		esac
		if [ "$actualVersion" == "" ]; then
			actualVersion="null"
		fi
		if [ "$actualVersion" == "line" ]; then
			actualVersion="null"
		fi
		checkVersion "$appname" "$appversion" "$actualVersion"
	done < $1
	IFS=$' \t\n'
}

checkVersion() {
	# $1 - app name
	# $2 - min version
	# $3 - current version
	if [ "$3" == "null" ]; then
		echo -e "[${red}FAIL${reset}] $1 version $2 is not found"
		exitCode=1
	fi
	if [ "$(printf '%s\n' "$2" "$3" | sort -V | head -n1)" = "$2" ]; then 
		echo -e "[${green}PASS${reset}] $1 version $3 > $2"
	else
		echo -e "[${red}FAIL${reset}] $1 version $3 < $2"
		exitCode=1
	fi
}

if [ $1 ]; then
	getEntry "$1"
else
	getEntry "app.csv"
fi

exit $exitCode
