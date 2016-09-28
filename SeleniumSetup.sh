#!/usr/bin/env bash
#!/bin/bash -e

#contributor: Sharif Rahman.
#linkedin profile: https://www.linkedin.com/in/md-sharifur-rahman-855412120
chmod +x SeleniumSetup.sh
set +e

function pause(){
   read -p "$*"
}
function InstallBrewPackages {
		#updating brew (platform independent)
		brew update
		echo "\033[36m>>Brew install/update successful..\033[0m"
		sleep 2

		#Installing & Updating Git, Maven, Maven-Shell, NPM, Jenkins and Jmeter.
		export PATH=/usr/local/bin:$PATH
		echo "\033[36m>>Exported new Git PATH\033[0m"
		brew install git
		which mvn || brew install maven
		which mvnsh || brew install maven-shell
		which npm && which node || brew install npm
		which jenkins || brew install jenkins
		which jmeter || brew install jmeter
	}

function BrewCleanup {
		brew upgrade
		brew cleanup --force
		rm -rf $(brew --cache)
		echo "The following packages installed/updated on your System using brew"
		brew list
		echo "\033[36m>>Brew installed/updated all packages to latest versions. Cache cleaned up!\033[0m"
		sleep 1
}

function InstallCaskApps {
		brew tap phinze/homebrew-cask
		which java || (echo "Java NOT found in system. Installing now.." && brew cask install java)
		echo "\033[1;31mDo you want to install recommended applications (Firefox, Google Chrome and Sublime Text) Timeout 8 seconds: [y/n]\033[0m"
			read -t 8 confirmation
			if [ "$confirmation" == "yes" ] || [ "$confirmation" == "y" ]; then
				echo "Brew Cask is about to install Applications now.."
				brew cask install firefox
				brew cask install google-chrome
				# brew cask install intellij-idea		//Installs Ultimate Edition
				brew cask install sublime-text

				echo "\033[1;31mDo you want to install additional applications (Pycharm, Skype and Teamviewer) Timeout 8 seconds: [y/n]\033[0m"
					read -t 8 clean
					if [ "$clean" == "yes" ] || [ "$clean" == "y" ]; then
						# brew cask install Pycharm		//Installs Ultimate Edition
						brew cask install skype
						brew cask install teamviewer
					fi
				echo "OS X Applications Installation complete via Brew Cask!"

			else
				echo "Brew Cask did not install any recommended or additional applications."
			fi
}

function DeleteWorkspace {
			echo "\033[1;31mDo you want to ERASE ALL CONTENTS in your current Workspace?(not recommended). Timeout 8 seconds: [y/n]\033[0m"
			read -t 8 clean
			if [ "$clean" == "yes" ] || [ "$clean" == "y" ]; then
				rm -rf ~/Workspace
				mkdir ~/Workspace
			else 
				echo "\033[36mWorkspace contents were not touched. Perform a manual clean up! :)\033[0m"
			fi
}

	clear
	echo "Info: This script Installs/Upgrades Xcode CL Tools, Homebrew, Git, Maven, Maven-Shell, Jenkins and Jmeter! \n"
	echo "\033[33mWARNING: This script may permanently delete contents of your current Workspace!\nPlease enter [y/n] carefully throughout the script!\033[0m"
	echo "ARE YOU SURE YOU WANT TO CONTINUE? [y/n] Timeout 12 seconds:"
	read -t 12 msg
	if [ "$msg" == "yes" ] || [ "$msg" == "y" ]; then
		echo "Enter the administrator password to continue:"
		sudo echo "Detectig Operating System.."
		
		#installing xcode command line tools.
		if [ "$(uname)" == "Darwin" ]; then
			echo "OS Detected: Darwin (Unix/OS X)"
			echo "Installing Xcode CommandLineTools.."
			xcode-select -p || (sudo xcode-select --install && pause 'Press [Enter] continue...')
			echo "\033[36m>>Xcode successful..\033[0m"
			sleep 2
			
		#installing brew (for OS X)
			which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
			sleep 1

		#install packages
			InstallBrewPackages
			InstallCaskApps
			BrewCleanup
		
		elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
			echo "Detecting Operating System.."
			echo "OS Detected: Linux"

			echo "Do you have latest JDK installed? JDK is a pre-requisite for this script. [y/n] Timeout 8 seconds:"
			read -t 8 conf
				if [ "$conf" == "yes" ] || [ "$conf" == "y" ]; then
				#installing Linuxbrew (for Linux)
					echo "Installing LinuxBrew"
					ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
					export PATH="$HOME/.linuxbrew/bin:$PATH"
					export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
					export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
					echo "\033[36m>>LinuxBrew installation and PATH setup successful..\033[0m"
					#install packages
					InstallBrewPackages
					BrewCleanup
				else
					sleep 1
					echo "________________________________________________________________"
					java -version 
					echo "________________________________________________________________"
					echo "\033[33mIF YOU CAN SEE JAVA VERSION ABOVE, YOU ALREADY HAVE JAVA INSTALLED. \nRE-RUN THE SCRIPT USING [y/yes] WHEN PROMPTED..\033[0m"
					echo "\nJDK is a pre-requisite. You can get the latest JDK from: \nhttp://www.oracle.com/technetwork/java/javase/downloads/index.html"
					exit 1
				fi
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
		fi

		echo "\033[32m>>Latest versions of Xcode CL Tools, Git, Maven, Jenkins, NPM, Jmeter, Firefox, Chrome, Sublime Text installed Successfully..\033[0m"
		echo "\033[1;32m>>Your System is ready for Selenium Automation!\033[0m"
		pause 'Press [Enter] key to reboot system (Required)...'
			sudo shutdown -r now

	else 
		sleep 1
		echo "\033[32m\nExiting Process.. \nRun this script only to install/upgrade Selenium Dev environment and/or cleanup.\033[0m"
		exit 1
	fi
