#!/system/bin/sh
# setup.sh - setup and install sysimfo script
# By: DeadRabbit
# Telegram: https://t.me/deadrabbit404
# Github: https://github.com/deadrabbit404

TUIDIR="/sdcard/t-ui"
SCRIPTDIR="$TUIDIR/script"
LOGOS="logos"
SCRIPT="sysinfo"
ALIASTXT="$TUIDIR/alias.txt"
TGZFILE="logos.tar.gz"

echo ":: Unpacking files..."
sleep 1
tar -zxvf $TGZFILE -C $TUIDIR
echo ":: Installing sysinfo, please wait..."
sleep 1
mkdir -p $SCRIPTDIR && cp -v "$SCRIPT" "$SCRIPTDIR"

# Test if the alias for sysinfo already exist
grep "^sysinfo" $ALIASTXT >/dev/null 2>&1
if [ $? -ne 0 ]
then
    # Test if the file has no EOL, then print a blank line.
    [ -n "`tail -c 1 $ALIASTXT`" ] && echo >> $ALIASTXT 
    echo "sysinfo=sh $SCRIPTDIR/$SCRIPT %" >> $ALIASTXT
else
    # This means the alias already exists.
    # Replace whatever value assigned to the alias
    # with a new one that points to the sysinfo script.
    sed -i "s#\(^sysinfo=\).*\$#\1sh $SCRIPTDIR/$SCRIPT %#" $ALIASTXT
fi

sleep 1
echo ":: Installation finished. Please restart or refresh t-ui."
