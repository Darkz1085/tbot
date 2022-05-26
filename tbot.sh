#!/data/data/com.termux/files/usr/bin/bash

#Adding colors
R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

#banner
clear
banner(){
printf ${C}"████████╗██████╗  ██████╗ ████████╗\n"
printf     "╚══██╔══╝██╔══██╗██╔═══██╗╚══██╔══╝\n"
printf     "   ██║   ██████╔╝██║   ██║   ██║   \n"
printf     "   ██║   ██╔══██╗██║   ██║   ██║   \n"
printf     "   ██║   ██████╔╝╚██████╔╝   ██║   \n"
printf     "   ╚═╝   ╚═════╝  ╚═════╝    ╚═╝   \n"${W}
printf ${Y}"                By Technical Bot\n"${W}
}




#Tools List
clear
banner
echo
echo ${C}"[1] Browser Exploitation Framework (BEeF)"
echo
echo "[2] Metasploit"
echo
echo "[3] mitmproxy"
echo
echo "[4] Routersplit"
echo
echo "[5] Nmap"
echo
echo "[6] Netcat"
echo
echo "[7] Ghost Framework"
echo
echo "[8] PyPhisher"
echo
echo "[9] PhoneSploit"
echo
echo "[10] Sherlock"
echo
echo "[11] John The Ripper"
echo
echo "[12] Cupp"${W}
echo 

read -p ${Y}"Select option: "${W} user_input
echo
 

get_arch() {
    printf ${G}"[*] Checking device architecture ..."${W}
    case $(getprop ro.product.cpu.abi) in
        arm64-v8a)
            SYS_ARCH=arm64
            ;;
        armeabi|armeabi-v7a)
            SYS_ARCH=armhf
            ;;
        *)
            unsupported_arch
            ;;
    esac
}


install_beef(){
	pkg update
	pkg install curl git libyaml libxslt bison espeak ruby python nodejs nano -y
	cd $PREFIX/opt
	git clone https://github.com/beefproject/beef
	cd $PREFIX/opt/beef
	echo " gem 'net-smtp', require: false" >> Gemfile
	sed -i '264d' install
	sed -i 's/sudo//' install
	bash install
	echo "cd $PREFIX/opt/beef && ruby beef" >> $PREFIX/bin/beef
	chmod +x $PREFIX/bin/beef
	echo ${G}"[*] Installation completed..."
	echo "[*] Now you can launch beef just by executing 'beef' and make sure to change you login id and password in '$PREFIX/opt/beef/config.yaml' file"${W}
	echo
}


install_nmap(){
	pkg update 
	pkg install nmap -y
	echo ${G}"[*] Installation completed..."${W}
	echo
}

install_metasploit(){
	pkg update 
	pkg install wget -y
	wget https://github.com/gushmazuko/metasploit_in_termux/raw/master/metasploit.sh
	bash metasploit.sh
	rm metasploit.sh	
	echo
}

install_routersploit(){
	get_arch
	echo
	echo
	if [[ $SYS_ARCH == "arm64" ]]; then
	pkg update 
	pkg install git python rust libsodium -y
	cd $PREFIX/opt
	git clone https://github.com/threat9/routersploit
	cd $PREFIX/opt/routersploit
	export CARGO_BUILD_TARGET=aarch64-linux-android
	pip install cryptography --no-binary cryptography 
	SODIUM_INSTALL=system pip install pynacl
	pip3 install -r requirements.txt
	echo "python3 $PREFIX/opt/routersploit/rsf.py" >>  $PREFIX/bin/rsf
	chmod +x $PREFIX/bin/rsf
	echo
	echo ${G}"[*] Installation completed..."
	echo "[*] You can start Routersploit just by executing rsf"${W}
	else
	   echo ${R}"[*] Sorry, Your device architecture is not supported"${W}
	fi
}


install_mitmproxy(){
	get_arch
        echo
        echo
        if [[ $SYS_ARCH == "arm64" ]]; then
	pkg update
	pkg install python rust -y
	export CARGO_BUILD_TARGET=aarch64-linux-android
	pip install cryptography --no-binary cryptography 
	pip3 install mitmproxy
	echo
	echo ${G}"[*] Installation completed..."${W}
	echo
	else
           echo ${R}"[*] Sorry, Your device architecture is not supported"${W}
        fi
}


install_netcat(){
	pkg update
	pkg install netcat -y	
	echo ${G}"[*] Installation completed..."${W}
}


install_ghost(){
	get_arch
        echo
        echo
        if [[ $SYS_ARCH == "arm64" ]]; then
	pkg update
	pkg install git python rust -y
	export CARGO_BUILD_TARGET=aarch64-linux-android
	pip install cryptography --no-binary cryptography
	pip3 install git+https://github.com/EntySec/Ghost
	echo
	echo ${G}"[*] Installation Completed..."${W}
	echo
	else
           echo ${R}"[*] Sorry, Your device architecture is not supported"${W}
        fi
}


install_pyphisher(){
	pkg update
	pkg install -y git python curl wget php proot
	cd $PREFIX/opt
	git clone https://github.com/KasRoudra/PyPhisher
	echo "cd $PREFIX/opt/PyPhisher && python3 pyphisher.py" >> $PREFIX/bin/pyphisher
	chmod +x $PREFIX/bin/pyphisher
	echo ${G}"[*] Installation Completed..."
	echo "[*] You can launch PyPhisher just by executing 'pyphisher'"${W}
	echo
}


install_johntheripper(){
	pkg update 
	pkg install git make perl clang binutils -y
	cd $HOME
	git clone https://github.com/openwall/john
	cd john/src
	./configure
	make -s clean &&  make -sj4
	cd $HOME
	echo
	echo ${G}"[*] Installation Completed"${W}
	echo
}


install_cupp(){
	pkg update
	pkg install git python -y
	cd $HOME
	git clone https://github.com/Mebus/cupp
	echo
	echo ${G}"[*] Installation completed"${W}
	echo
}



install_sherlock(){
	pkg update
	pkg install git python -y
	cd $HOME
	git clone https://github.com/sherlock-project/sherlock
	cd sherlock
	pip3 install -r requirements.txt
	cd $HOME
	echo
	echo ${G}"[*] Installation completed"${W}
	echo
}



install_phonesploit(){
	pkg update
	pkg install git python android-tools -y
	pip3 install colorama
	cd $PREFIX/opt
	git clone https://github.com/aerosol-can/PhoneSploit
	cd $HOME
	echo "python3 $PREFIX/opt/PhoneSploit/phonesploit.py" >> $PREFIX/bin/phonesploit
	chmod +x $PREFIX/bin/phonesploit
	echo
	echo ${G} "[*] Installation completed"
	echo "[*] You can launch PhoneSploit just by typing 'phonesploit'"${W}
	echo
}



if [[ $user_input == "1" ]]; then
	echo ${G}"[*] Installing Beef..."${W}
	echo
	install_beef
elif [[ $user_input == "2" ]]; then
	echo ${G}"[*] Installing Metasploit..."${W}
	echo
	install_metasploit
elif [[ $user_input == "3" ]]; then
	echo ${G}"[*] Installing mitmproxy"${W}
	echo
	install_mitmproxy
elif [[ $user_input == "4" ]]; then
	echo ${G}"[*] Installing Routersploit..."${W}
	echo
	install_routersploit
elif [[ $user_input == "5" ]]; then
	echo ${G}"[*] Installing Nmap..."${W}
	echo
	install_nmap
elif [[ $user_input == "6" ]]; then
	echo ${G}"[*] Installing Netcat..."${W}
	echo
	install_netcat
elif [[ $user_input == "7" ]]; then
        echo ${G}"[*] Installing Ghost Framework"${W}
        echo
        install_ghost
elif [[ $user_input == "8" ]]; then
        echo ${G}"[*] Installing PyPhisher..."${W}
        echo
        install_pyphisher
elif [[ $user_input == "9" ]]; then
        echo ${G}"[*] Installing PhoneSploit..."${W}
        echo
        install_phonesploit
elif [[ $user_input == "10" ]]; then
        echo ${G}"[*] Installing Sherlock..."${W}
        echo
        install_sherlock
elif [[ $user_input == "11" ]]; then
        echo ${G}"[*] Installing John The Ripper..."${W}
        echo
        install_johntheripper
elif [[ $user_input == "12" ]]; then
        echo ${G}"[*] Installing Cupp..."${W}
        echo
        install_cupp
else
	echo ${R}"[*] Error, Select a option from the above list"${W}
	echo
fi



