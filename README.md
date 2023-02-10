kaminsky.pl is a Perl script created by Hazel Yamada at the University of Oregon in order to demonstrate the concept of DNS poisoning via a Kaminsky attack in a closed environment. This tool is designed to run on most Debian based distros.

This tool was created for attack in a specifically configured lab and will not work in the wild. If you wish to utilize this tool for your own academic purposes you must disable source port randomization on the DNS server you are attacking. 

Two files are included with this tool:

* install.sh - Installs "nemesis" a open-source packet injector, which is required for the Kaminsky utility and must be run as root and requires an internet connection. Except for two yes or no prompts at the beginning of execution (apt-get requests) the script is unattended.
* kaminsky.pl - The actual Kaminsky utility itself. Must be run as root. This script accepts no arguments and is hard-coded to attack testdomain.test which reserved as a testing TLD in RFC 2606.
