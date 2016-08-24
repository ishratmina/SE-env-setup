#!/usr/bin/env bash
#!/bin/bash -e


#contributor: Sharif Rahman.
#linkedin profile: https://www.linkedin.com/in/md-sharifur-rahman-855412120
chmod +x SeleniumSetup.sh

clear
echo "Do you have latest JDK installed? [y/n] Timeout 8 seconds:"
read -t 8 conf
if [ "$conf" == "yes" ] || [ "$conf" == "y" ]; then

	echo "\nWARNING: This script permanently deletes your current Workspace, Installs/Upgrades Xcode CL Tools, Homebrew, Git, Maven, Jenkins and Jmeter!!!"
	echo "WARNING: You will lose your current Brew packages and contents! \n"
	echo "ARE YOU SURE YOU WANT TO CONTINUE? [y/n] Timeout 10 seconds:"
	read -t 10 msg
	if [ "$msg" == "yes" ] || [ "$msg" == "y" ]; then
		
		#installing xcode command line tools.
		echo "Installing Xcode Command Line Tools.."
		echo "Enter Admin Password to continue:"
		sudo xcode-select --install
		echo "Successful!"
		sleep 2

		#installing brew
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew update
		sleep 2

		#removing previous installations
		brew remove git
		brew remove maven
		brew remove npm
		brew remove jenkins
		brew remove jmeter
		echo "Brew removed old versions of Git, Maven, NPM, Jenkins and Jmeter if existed. \n"
		sleep 2

		#Installing & Updating Git, Maven, NPM, Jenkins and Jmeter.
		export PATH=/usr/local/bin:$PATH
		echo "Exported PATH for Git"
		brew install git
		brew upgrade git
		brew install maven
		brew upgrade maven
		brew install npm
		brew upgrade npm
		brew install jenkins
		brew upgrade jenkins
		brew install jmeter
		brew upgrade jmeter
		echo "Brew installed/updated latest versions.\n"
		sleep 2

		#Creating Workspace
		rm -rf /Users/$USER/Workspace
		mkdir /Users/$USER/Workspace
		echo "Latest versions of Git, Maven, Jenkins, NPM, Jmeter installed Successfully."
		echo "System updated && Workspace cleaned up. Your System is ready for Selenium Automation!"
		echo "\nDO YOU WANT TO REBOOT NOW(recommended)? [y/n]:"
		read -t 8 prompt
		if [ "$prompt" == "yes" ] || [ "$prompt" == "y" ]; then
			sudo shutdown -r now
		else 
			echo "System reboot recommended. Enjoy Selenium Automation :) "
			exit 0
		fi
	else 
		sleep 1
		echo "\nProcess exiting. Run this script only to install/upgrade Selenium Automation environment and to clean Workspace. Thank you."
	fi
else
	sleep 1
	echo "JDK is a pre-requisite. Get latest JDK from "http://www.oracle.com/technetwork/java/javase/downloads/index.html" and install it before running the script. Make sure to backup your Workspace. Thank you!"
fi