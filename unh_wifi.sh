#!/bin/bash
# Contribution of the President, Keith M. Hoodlet, 04.13.2016
#
# Written by the UNH Linux Club... and Jake!
check_reqs() {
	# Make sure we're running Linux and not on a Mac
	OS_NAME=`uname`
	if [ ! $OS_NAME == "Linux" ]
	then
		return 0
	fi

	return 1
}

intro() {
	echo "======================================"
	echo "===== UNH Easy WiFi Setup Script ====="
	echo "======================================"
	echo "NOTE: Before running, download and install"
	echo "the user certificates from wifi.unh.edu (can"
	echo "be accessed by connecting to UNH-Open first)."
	echo "When you get to the cloudpath download link, "
	echo "click \"Show all operating systems\", select "
	echo "\"Other Operating Systems\", then download "
	echo "as well as install the certificates from step 2"
	echo "and step 3 (should be a .cer and .p12 file)"
	echo "respectively. Then, place both files in the same"
	echo "folder as this shell script; This script should"
	echo "handle the configuration from there."


	check_reqs
	if [ ! $? -eq 1 ]
	then
		echo "Error: distribution not supported."
		exit 1
	fi
}

run_nmcli() {
	echo "Finding network interface..."
	interface=$(ip link | grep wlan)

	if [ $? == 0 ]; then
		interface=$(ip link | grep wlan | cut -d ':' -f 2 | xargs)
	else
		interface=$(ip link | grep wlp)

		if [ $? == 0 ]; then
			interface=$(ip link | grep wlp | cut -d ':' -f 2 | xargs)
		else
			ip link
			echo
			echo "Cannot find interface! Is your wireless card working?"
		fi
	fi

	echo "Creating eduroam profile..."
	nmcli con add type wifi ifname $interface con-name eduroam ssid eduroam

	temp=$(/bin/pwd)
	ca=$(find ${temp} -name '*.cer')
	pk=$(find ${temp} -name '*.p12')

	# The main reason fro this script is to set up the options that would
	# have to be set up manually, such as peap and disabling the certificate.
	# I would like to have the certificate working, however, but that may
	# be done at a later date.
	echo "Editing eduroam profile..."
	nmcli con modify eduroam \
		802-11-wireless-security.auth-alg open \
		802-11-wireless-security.key-mgmt wpa-eap \
		802-1x.ca-cert "${ca}" \
		802-1x.client-cert "${pk}" \
		802-1x.domain-suffix-match clearpass.unh.edu \
		802-1x.eap tls \
		802-1x.identity $user \
		802-1x.private-key "${pk}" \
		802-1x.private-key-password $passw

	if [ $? == 0 ]; then
		echo "Done!"
	else
		exit 1
	fi
}

check_if_already_registered() {
	if [ -f /etc/NetworkManager/system-connections/eduroam ]
	then
		echo "There is already a network named eduroam registered with the system."
		echo "Please forget it and then try again."

		read -n 1 -p "Would you like us to remove it? [yn] " yn
		echo # read -n 1 doesn't make a new line

		case $yn in
			[Yy]* )
				nmcli con delete eduroam
				echo
				;;
			[Nn]* )
				exit 1
				;;
			* ) echo "Please answer Yes or No"; exit;;
		esac
	fi
}

get_info() {
	read -p "Username: " user
	echo

	while true; do
		read -s -p "Password (the text will not show up): " passw
		echo
		read -s -p "Type your password again to verify: " passwTest
		echo

		if [ $passw != $passwTest ]; then
			echo "Passwords do not match, try again..."
			echo
		else
			break
		fi
	done
}

main() {
	intro
	echo "======================================"
	echo "This script will attempt to automatically set up the WiFi connection"
	echo "on your new Linux PC. You will need your UNH username and password."
	echo

	# We can assume they are using netowrk manager
	check_if_already_registered
	get_info
	run_nmcli

	echo
	echo "IMPORTANT: Restart your system, then try to connect to eduroam via the wifi menu. Good luck."
}

main

exit 0
