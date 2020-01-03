#!/bin/sh
#knn 191227


echo -e `xsel -p -o `> /tmp/xsf-1.txt;
  mh1=$(cat /tmp/xsf-1.txt)

## если нету - вторичный
if [ -z "$mh1" ]
  then

    echo -e `xsel -s -o `> /tmp/xsf-1.txt;

      mh1=$(cat /tmp/xsf-1.txt);    
fi 

## если нету - clipboard
if [ -z "$mh1" ]
  then

    echo -e `xsel -b -o `> /tmp/xsf-1.txt;

      mh1=$(cat /tmp/xsf-1.txt);    
fi

# ----
if [ -z "$mh1" ]
  then

    echo -e `xsel -z -o `> /tmp/xsf-1.txt;

      mh1=$(cat /tmp/xsf-1.txt);    
fi


## выбор между dialog и Xdialog
if [ -z $DISPLAY ]
  then
    DIALOG=dialog    ; prflsDiir=$HOME/.config/mpv/mpv-Dev-knn/cnsl-mpv-prfs/
  else
    DIALOG=Xdialog   ; prflsDiir=$HOME/.config/mpv/mpv-Dev-knn/xsel-mpv/
fi


## выбор профиля
PRFL=`$DIALOG --stdout --title "выбор профиля" --fselect $prflsDiir 30 90`
 
case $? in
    0)
	echo "Выбран \"$prflsDiir\""   ;;
    1)
	echo "Отказ от ввода.";;
    255)
	echo "Нажата клавиша ESC.";;
esac

 
prfl=$(cat "$PRFL")
  pr=--profile$prfl ;echo $pr
  
rm /tmp/xsf-1.txt


## --? xsel -sc
xsel -c
xsel -bc
#--xsel -kc
#--xsel -kc
#--xsel -sc

IFS=$'\n' 

if [ -z "$mh1" ]
  then 
    mpv  --config-dir=$HOME/.config/mpv/mpv-Dev-knn/ "$@" --force-window=immediate   --geometry=300 $pr;

fi
    mpv  --config-dir=$HOME/.config/mpv/mpv-Dev-knn/ $mh1 --force-window=immediate   --geometry=300 $pr 
