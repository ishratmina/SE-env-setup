#!/usr/bin/env bash
#!/bin/bash -e

#contributor: Sharif Rahman.
#linkedin profile: https://www.linkedin.com/in/md-sharifur-rahman-855412120
chmod +x SeleniumSetup.sh
set -e

function InstallPackages {
		#updating brew (platform independent)
		brew update
		echo "\033[36m>>Brew install/update successful..\033[0m"
		sleep 2

		#Installing & Updating Git, Maven, NPM, Jenkins and Jmeter.
		export PATH=/usr/local/bin:$PATH
		echo "\033[36m>>Git PATH set..\033[0m"
		brew install git
		which mvn || brew install maven
		which npm && which node || brew install npm
		which jenkins || brew install jenkins
		which jmeter || brew install jmeter
		brew upgrade
		brew cleanup
		rm -rf ~/Library/Caches/Homebrew/*
		echo "\033[36m>>Brew installed/updated all packages to latest versions. Cache cleaned up!\033[0m"
		sleep 2
	}

clear
echo "Do you have latest JDK installed? [y/n] Timeout 8 seconds:"
read -t 8 conf
if [ "$conf" == "yes" ] || [ "$conf" == "y" ]; then
	echo "Info: This script Installs/Upgrades Xcode CL Tools, Homebrew, Git, Maven, Jenkins and Jmeter! \n"
	echo "\033[33mWARNING: This script may permanently delete contents of your current Workspace!\nPlease enter [y/n] carefully throughout the script!\033[0m"
	echo "ARE YOU SURE YOU WANT TO CONTINUE? [y/n] Timeout 12 seconds:"
	read -t 12 msg
	if [ "$msg" == "yes" ] || [ "$msg" == "y" ]; then
		echo "Enter the administrator password to continue:"
		sudo echo "Installing Xcode Command Line Tools.."
		
		#installing xcode command line tools.
		if [ "$(uname)" == "Darwin" ]; then
			echo "OS Detected: Darwin (Unix/OS X)"
			xcode-select -p || sudo xcode-select --install
			echo "\033[36m>>Xcode successful..\033[0m"
			sleep 2
		#installing brew (for OS X)
			which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
			sleep 1

		#install packages
			InstallPackages
		
		elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
			echo "OS Detected: Linux"

			#installing Linuxbrew (for Linux)
			echo "Installing LinuxBrew"
			ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
			export PATH="$HOME/.linuxbrew/bin:$PATH"
			export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
			export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
			echo "\033[36m>>LinuxBrew installation and PATH setup successful..\033[0m"

			#install packages
			InstallPackages
		else 
			echo "Your Operating System Does Not Support this Script. Must be a Unix or Linux OS!"
		fi


		#Creating Workspace
		cd ~/
		if [ ! -d "Workspace" ]; then
			mkdir Workspace
			echo "\033[36m>>Workspace Directory created at ~/Workspace..\033[0m"
		else 
			echo "\033[32mWorkspace Directory already exists!\033[0m"
			echo "\033[1;31mDo you want to ERASE ALL CONTENTS in your current Workspace?(not recommended). Timeout 8 seconds: [y/n]\033[0m"

			read -t 8 clean
			if [ "$clean" == "yes" ] || [ "$clean" == "y" ]; then
				rm -rf ~/Workspace
				mkdir ~/Workspace
			
			else 
				echo "\033[36mWorkspace contents were not touched. Perform a manual clean up! :)\033[0m"
			fi
		fi

		echo "\033[32m>>Latest versions of Xcode CL Tools, Git, Maven, Jenkins, NPM, Jmeter installed Successfully..\033[0m"
		echo "\033[1;32m>>System updated && Workspace created. Your System is ready for Selenium Automation!\033[0m"
		echo "\033[35m\nDO YOU WANT TO REBOOT NOW(recommended)? Timeout 8 seconds[y/n]:\033[0m"
		read -t 8 prompt
		if [ "$prompt" == "yes" ] || [ "$prompt" == "y" ]; then
			sudo shutdown -r now
		else
			echo "\033[36mSystem reboot recommended for functionalities of newly installed components.\nEnjoy Selenium Automation :)\033[0m"
			exit 0
		fi

	else 
		sleep 1
		echo "\033[32m\nExiting Process.. \nRun this script only to install/upgrade Selenium Dev environment or cleanup.\033[0m"
		exit 0
	fi
else
	sleep 1
	echo "________________________________________________________________"
	java -version 
	echo "________________________________________________________________"
	echo "\033[33mIF YOU CAN SEE JAVA VERSION ABOVE, YOU ALREADY HAVE JAVA INSTALLED. \nRE-RUN THE SCRIPT USING [y/yes] WHEN PROMPTED..\033[0m"
	echo "\nJDK is a pre-requisite. You can get the latest JDK from: \nhttp://www.oracle.com/technetwork/java/javase/downloads/index.html"
	exit 0
fi