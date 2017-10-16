#!/bin/sh

userfolder="$1"
user1="$1"

percentage=100
info1=$(du -sm $userfolder)

size=$(echo $info1 | cut -d' ' -f1)
max=$2
trop=$3

stats=$(echo "scale=2;($size/$max*$percentage)" | bc)
DATE=`date +%d/%m/%Y-%H:%M:%S`

Log="/var/logs/custom/quota/usage.log"
if test -f $Log; then
    echo "File exist"
else
    touch $Log;
fi

userlog="/home/$1/usage.log"
if test -f $userlog; then
    echo "File exist"
else
    touch $userlog;
fi

# Send alert if disk usage is between the Warm size and the Max size
if ((size > trop && size < max));
then
    echo $DATE"     Répertoire : "$userfolder" = "$size"     Limite fixée à "$max"     Utilisation = "$stats" %     Pour "$user1 >> $Log
    echo "ATTENTION : La taille du repertoire "$userfolder" est de "$size" Mo alors que la limite est de "$max" Mo. Soit "$stats" % des ressources de "$user1" sont utilisees le "$DATE >> $userlog
    mail -s "AVERTISSEMENT : Espace du repertoire "$1" CRITIQUE." -a "FROM: noreply@domain.tld" you@domain.tld < $userlog
    sleep .5
fi

# Send alert if disk usage is 100% used
if ((size == max));
then
    echo $DATE"     Répertoire : "$userfolder" = "$size"     Limite fixée à "$max"     Utilisation = "$stats" %     Pour "$user1 >> $Log
    echo "ATTENTION : La taille du repertoire "$userfolder" est de "$size" Mo alors que la limite est de "$max" Mo. Soit "$stats" % des ressources de "$user1" sont utilisees le "$DATE >> $userlog
    mail -s "DANGER : Espace du repertoire "$1" PLEIN." -a "FROM: noreply@domain.tld" you@domain.tld < $userlog
    sleep .5
fi

# Send alert if disk usage is more than 100% used
# If you want to disable writte access you can add the next command into the if condition.
# chown -R $admin:$admin  $DossierASurveiller && chmod -R 700 $admin:$admin $DossierASurveiller
if ((size > max));
then
    echo $DATE"     Répertoire : "$userfolder" = "$size"     Limite fixée à "$max"     Utilisation = "$stats" %     Pour "$user1 >> $Log
    echo "ATTENTION : La taille du repertoire "$userfolder" est de "$size" Mo alors que la limite est de "$max" Mo. Soit "$stats" % des ressources de "$user1" sont utilisees le "$DATE >> $userlog
    mail -s "URGENT : Espace du repertoire "$1" DEPASSE." -a "FROM: noreply@domain.tld" you@domain.tld < $userlog
    sleep .5
fi

rm $userlog
