#!/usr/bin/env bash
#!/bin/bash -e

#contributor: Sharif Rahman.
#linkedin profile: https://www.linkedin.com/in/md-sharifur-rahman-855412120
chmod +x SeleniumSetup.sh

clear
echo "Do you have latest JDK installed? [y/n] Timeout 8 seconds:"
read -t 8 conf
if [ "$conf" == "yes" ] || [ "$conf" == "y" ]; then

	echo "\nWARNING: This script may permanently delete contents of your current Workspace. Enter [y/n] carefully please." 
	echo "Info: This script Installs/Upgrades Xcode CL Tools, Homebrew, Git, Maven, Jenkins and Jmeter! \n"
	echo "ARE YOU SURE YOU WANT TO CONTINUE? [y/n] Timeout 12 seconds:"
	read -t 12 msg
	if [ "$msg" == "yes" ] || [ "$msg" == "y" ]; then
		
		#installing xcode command line tools.
		echo "Enter administrator password to continue:"
		sudo echo "Installing Xcode Command Line Tools.."
		xcode-select -p || sudo xcode-select --install
		echo "Successful!"
		sleep 2

		#installing brew
		which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew update
		sleep 2

		#Installing & Updating Git, Maven, NPM, Jenkins and Jmeter.
		export PATH=/usr/local/bin:$PATH
		echo "Exported PATH"
		brew install git
		which mvn || brew install maven
		which npm && which node || brew install npm
		which jenkins || brew install jenkins
		which jmeter || brew install jmeter
		brew upgrade
		brew cleanup
		rm -rf ~/Library/Caches/Homebrew/*
		echo "Brew installed/updated all packages to latest versions. Cache cleaned up.\n"
		sleep 2

		#Creating Workspace
		cd ~/
		if [ ! -d "Workspace" ]; then
			mkdir Workspace
			echo "Workspace Directory created at Home."
		else 
			echo "Workspace Directory already exists!\nDo you want to erase all content permanently?(not recommended)? Timeout 8 seconds: [y/n]"
			read -t 5 clean
			if [ "$clean" == "yes" ] || [ "$clean" == "y" ]; then
			rm -rf ~/Workspace
			mkdir ~/Workspace
			
			else 
			echo "System reboot recommended for functionalities of each installed components.\nEnjoy Selenium Automation :) "
			fi
		fi

		echo "Latest versions of Git, Maven, Jenkins, NPM, Jmeter installed Successfully."
		echo "System updated && Workspace created. Your System is ready for Selenium Automation!"
		echo "\nDO YOU WANT TO REBOOT NOW(recommended)? Timeout 8 seconds[y/n]:"
		read -t 8 prompt
		if [ "$prompt" == "yes" ] || [ "$prompt" == "y" ]; then
			sudo shutdown -r now
		else 
			echo "System reboot recommended for functionalities of each installed components.\nEnjoy Selenium Automation :) \n "
			exit 0
		fi
	else 
		sleep 1
		echo "\nProcess exiting. Run this script only to install/upgrade Selenium Automation environment and to clean Workspace. Thank you."
		exit 0
	fi
else
	sleep 1
	java -version 
	echo "\nIF YOU ARE SEEING JAVA VERSION ABOVE, RE-RUN THE SCRIPT USING [y/yes] WHEN PROMPTED!"
	echo "\nJDK is a pre-requisite. Get latest JDK from "http://www.oracle.com/technetwork/java/javase/downloads/index.html" and install it before running the script. Make sure to backup your Workspace. Thank you!"
	exit 0
fi