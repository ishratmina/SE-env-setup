#!/usr/bin/env bash
#!/bin/bash -e

#contributor: Sharif Rahman.
#linkedin profile: https://www.linkedin.com/in/md-sharifur-rahman-855412120
chmod +x UninstallSeleniumSetup.sh
set -e

function UninstallSeleniumPackages {
		#updating brew (platform independent)
		brew update
		echo "\033[36m>>Brew updated..\033[0m"
		sleep 2

		#Installing & Updating Git, Maven, Maven-Shell, NPM, Jenkins and Jmeter.

		which mvn && brew remove maven
		which npm && brew remove npm
		which jenkins && brew remove jenkins
		which jmeter && brew remove jmeter
		which mvnsh && brew remove maven-shell
		brew remove git
		brew cleanup
		rm -rf ~/Library/Caches/Homebrew/*
		echo "\033[36m>>Brew successfully removed Maven, NPM, Jenkins, Jmeter, Maven-Shell and Git. Cache cleaned up!\033[0m"
		sleep 2
	}

function RemoveBrew {
	brew remove --force $(brew list)
	brew cleanup
	echo "\033[36m>>All available packages installed via Brew were removed..\033[0m"
	which brew && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
		echo "\033[36m>>Homebrew uninstalled from your system.\033[0m"

}

echo "\033[33mWARNING: This script will remove installed packages via SeleniumSetup.sh & may delete brew and all other brew packages installed in your system.!\nPlease enter [y/n] carefully throughout the script!\033[0m"
echo "ARE YOU SURE YOU WANT TO CONTINUE? [y/n] Timeout 12 seconds:"
read -t 12 msg
	if [ "$msg" == "yes" ] || [ "$msg" == "y" ]; then
			sudo echo "Removing Selenium Pakages.."
			UninstallSeleniumPackages
			echo "\033[36m>>All brew packages installed for Selenium Environment has been removed. \033[0m"
			echo "\033[35m\nDo you want to completely remove Brew and all other packages as well (Not recommended)? (Removes brew itself and all other packages installed on your system via Brew)..:\033[0m"
		read -t 8 prompt
		if [ "$prompt" == "yes" ] || [ "$prompt" == "y" ]; then
			RemoveBrew
		else
			echo "\033[36mBrew packages for Selenium Environment were removed. Brew has not been uninstalled and all other brew dependencies (except for Selenium Environment still remains on your system).\033[0m"
			exit 0
		fi
	else 
		echo "This script is used to remove brew and other associated packages on Mac OS X"
		
	fi