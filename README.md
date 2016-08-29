About:
	This script installs or upgrades existing Xcode CLI tools, Homebrew, Maven, Maven-Shell, Jenkins, Jmeter, NPM, Git. Optionally, cleans up your current workspace. Even if you have everything installed, you can still run this script to update Brew and Installed Packages and clean up cached files and/or previous versions of any brew packages. Run the script without any worries and follow the terminal outputs and prompts when asked (all the promts has a timeout for your system's safety).


Compatibility: Mac OS X (Unix) and Linux only. Windows OS is NOT supported yet. 

Tests:
		OS X (10.11.6 El Capitan) tested OK. (Should be OK on OS X 10.5 or newer)
		Linux (Ubuntu 12.04 LTS, Kernel 3.2.0 or newer) tested OK.


Prerequisites:

	1. JDK installed on your system.
		to verify, type "java --version" on Terminal if you have JDK installed.
		
	2. Sudo or root privilege.

Recommended: (optional)
	1. IDE installed. (like- IntelliJ IDEA or eclipse)
	2. Xcode from App store. (also can be installed via this script)
	3. Backup of existing Workspace.

Instructions:

	1. To execute: Clone/Download the repository on your computer from 
		https://github.com/sharif314/SE-env-setup.git

		note: if you don't have git or not sure how to clone, copy/paste the url above. Click on Clone/Download. Download ZIP and move to the next step. 

	2. Open Terminal and navigate to the downloaded location.

	3. On Terminal, type the following command to execute the script
		"sh SeleniumSetup.sh"

	2. When prompt for y/n questions, answers are case sensative. Only acceptable yes answers are "y" or "yes". Everything else will be taken as "no" in the script. 

	2. Backup or rename your default Workspace in the home directory (if exists).

	3. Recommended to use in Mac OS X for setting up selenium automation environment.

	4. Script could be used just to upgrade existing installations and cleaning up local Workspace. 


For Advance Users:
	1. Copy the script to your PATH to make the script executable from Terminal. 
	2. To view $PATH on your system, type echo $PATH. (usually "/usr/bin or /usr/local/bin")
	3. From Terminal, type SeleniumSetup.sh and the script should be executable directly. 
