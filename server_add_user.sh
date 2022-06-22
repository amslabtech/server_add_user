#!/bin/bash

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ]; then
    echo "Usage: $0 [ADMIN@HOST] [USER_TO_BE_ADDED] [PUBLIC_KEY_FILE] [DEFAULT_PASSWORD]"
    exit 1
fi

if ! ls $3 &> /dev/null; then
    echo "Public key file not found (File path: $3)"
    exit 2
fi

echo "Are you sure to add user \"$2\"? [y/N]"
read ans
case $ans in
    [Yy]* )
        echo "Adding user \"$2\""
        ;;

    * )
        exit 3
        ;;
esac

tmpfile=$(ssh $1 mktemp)

ssh $1 "cat <<EOS > $tmpfile
sudo useradd -s /bin/bash -d /home/$2 -m $2
yes $4 | sudo passwd $2
sudo passwd -e $2
sudo mkdir /home/$2/.ssh
sudo chmod 755 /home/$2/.ssh
echo "$(cat $3)" | sudo tee -a /home/$2/.ssh/authorized_keys
sudo chmod 644 /home/$2/.ssh/authorized_keys
sudo chown -R $2:$2 /home/$2/.ssh
sudo gpasswd -a $2 docker
EOS"

ssh -t $1 bash $tmpfile
ssh $1 rm $tmpfile
