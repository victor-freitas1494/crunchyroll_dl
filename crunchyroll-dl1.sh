#!/bin/bash
clear
YOUTUBE=$(ls $HOME/Downloads/ | grep youtube-dl)
menu(){
	echo "DOWNLOAD DE VIDEO DO CRUNCHYROLL"
	echo
	echo "[ 1 ] Fazer download do video"
	echo "[ 2 ] Fazer fila de download de video"
	echo "[ 3 ] Baixar so a legenda"
	echo "[ 4 ] Converter anime"
	echo "[ 5 ] Sair"
	echo
	echo "Escolhar uma das opicao: "; read OPIC
	clear
	case $OPIC in
		1) download ;;
		2) fila ;;
		3) legenda ;;
		4) conversor ;;	
		5) sair ;;
		
		*) echo "opicao invalida"; sleep 3; clear; menu;;
	esac
	}
download()
	{
	echo "FAZER DOWNLOAD DO VIDEO"
	echo
	echo "Informe a url do video da crunchyroll"
	read LINK
	sleep 1
	clear
	mkdir /tmp/youtube-dl/
	youtube-dl -u victorunreal -p skysound --all-subs -o "/tmp/youtube-dl/%(title)s.%(ext)s" $LINK
	if [ "$YOUTUBE" != "youtube-dl" ]
		then
			mkdir $HOME/Downloads/youtube-dl/
	fi
	cp /tmp/youtube-dl/*.mp4 $HOME/Downloads/youtube-dl 
	cp /tmp/youtube-dl/*ptBR.ass $HOME/Downloads/youtube-dl 
	sleep 2
	rm -r /tmp/youtube-dl
	clear
	echo "Download finalizado"
	echo
	menu
	}
fila(){
	LINK="0"
	mkdir /tmp/youtube-dl
	touch /tmp/youtube-dl/fila.txt
	clear
	until [ "$LINK" = "fim" ]; do
		echo "FAZER DOWNLOAD DO VIDEO VIA FILA"
		echo
		echo "Informe a url do video da crunchyroll\nfim - Parar comecar a fazer os downloads"
		read LINK
		clear
			if [ "$LINK" != "fim" ]
				then
					echo "$LINK" >> /tmp/youtube-dl/fila.txt
			fi
	done
	sleep 2
	youtube-dl -u victorunreal -p skysound --all-subs -a /tmp/youtube-dl/fila.txt -o "/tmp/youtube-dl/%(title)s.%(ext)s"
		if [ "$YOUTUBE" != "youtube-dl" ]
			then
				mkdir $HOME/Downloads/youtube-dl/
		fi
	cp /tmp/youtube-dl/*.mp4 $HOME/Downloads/youtube-dl
	cp /tmp/youtube-dl/*ptBR.ass $HOME/Downloads/youtube-dl
	sleep 2
	rm -r /tmp/youtube-dl
	clear
	echo "Download finalizado"
	echo
	menu
	}
legenda(){
	echo "FAZER DOWNLOAD DA LEGENDO"
	echo 
	echo -e "Informe a url do video da crunchyroll" || read LINK
	mkdir /tmp/youtube-dl/
	youtube-dl -u victorunreal -p skysound --all-subs --skip-download -o "/tmp/youtube-dl/%(title)s.%(ext)s" $LINK
	if [ "$YOUTUBE" != "youtube-dl" ]
		then
			mkdir $HOME/Downloads/youtube-dl/
	fi
	cp /tmp/youtube-dl/*ptBR.ass $HOME/Downloads/youtube-dl
	sleep 2 
	rm -r /tmp/youtube-dl	
	clear
	echo "Download finalizado"
	echo
	menu
	}
conversor(){
	VIDEO=$(zenity --file-selection --title=" Selecione um Arquivo de video ")
	SUBS=$(zenity --file-selection --title=" Selecione um Legenda")
	ffmpeg -i "$VIDEO" -vf "ass=$SUBS" -s 1280x720 -sws_flags lanczos -c:v libx265 -preset slow -x265-params crf=22 -c:a aac -b:a 128k "$VIDEO.mkv"
	clear
	menu
}
sair(){
	clear
	exit 1
	}
menu