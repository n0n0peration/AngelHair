#!/bin/bash
# Please use this script against systems you have prior permission to run against. I am not responsible for the mis-use of this script.
# I built this script as part of my OSCP cert. To help automate some of the more important commands I may run or need to run against different machines in the lab. 

# Ask the user for ip address of interest
echo "Welcome to the AngelHair script." 
echo "This program was developed for auotmated enumeration with popular tools used in Kali-Linux. Do take a moment to read the documentation and install the necessary programs if you are running this on a seperate system. The AngelHair program assumes the user has some prior knowledge in Pentesting."
echo +---------------------------------------+
echo + Please give us an ip address to scan: +
echo +---------------------------------------+
# Read IP ad
read ip

echo +--------------------------------------------+
echo + Would you like to run a DNS Enum: [yes/no] +
echo +--------------------------------------------+
read dnsenum
if [ $dnsenum == "yes" ]
then
#dns scans
dig $ip
dnsenum $ip
dnsrecon -d $ip
fi



echo +---------------------------------------------+
echo + Would you like to run a Nmap Enum: [yes/no] +
echo +---------------------------------------------+
read nmapenum
if [ $nmapenum == "yes" ]
then
#nmap scans
nmap -Pn $ip
nmap -O -A -p- $ip
nmap -sS -sC -sV $ip
nmap --scripts=vuln* $ip
fi

echo +----------------------------------------------+
echo + Would you like to run a Nikto Enum: [yes/no] +
echo +----------------------------------------------+
read niktoenum
if [ $niktoenum == "yes" ]
then
#vuln scan
nikto -host $ip
fi

echo +--------------------------------------------------+
echo + Would you like to run a Directory Enum: [yes/no] +
echo +--------------------------------------------------+
read direnum
if [ $direnum == "yes" ]
then
#directory scanning
dirb http://$ip/
gobuster -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt -u http://$ip/
curl http://$ip/robots.txt
fi

echo "Enjoy your exploits :P <3 n0ps"
