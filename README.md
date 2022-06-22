# server_add_user

## Environment
- bash

## Setup
Just clone this repository for example:
```sh
git clone git@github.com:amslabtech/server_add_user.git
```

## Usage
Execute the shell script with four arguments.  
Format is:
```sh
./server_add_user.sh [ADMIN@HOST] [USER_TO_BE_ADDED] [PUBLIC_KEY_FILE] [DEFAULT_PASSWD]
```
Example command is:
```sh
./server_add_user.sh amsl@specialpc newuser ./id_rsa_specialpc.pub passwd1234
```
This command adds `newuser` to `amsl@specialpc`.  
The public key to log in to `newuser@specialpc` via ssh is `. /id_rsa_spacialpc.pub` and the default user password is `passwd1234`.
