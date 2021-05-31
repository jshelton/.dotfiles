#!/bin/sh

LOG_FILE=~/Desktop/upddateDotfiles.log
DOTFILES=$HOME/src/github.com/jshelton/dotfiles
HOME_DIR=$HOME

declare -a origList=(
    gitignore_global
    hyper.js
    hyper_plugins
    inputrc
    tmux.conf
    doingrc
    zshrc
    )


declare -a List=(
    git
    hyper
    inputrc
    tmux
    doing
    zsh
    iTerm2
    vim
)

# Confirm with User
echo "This script will clobber the destination files."
read -p "Are you sure you wish to proceed? [y/N]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

# Proceed through every directory

for directory in "${List[@]}"
do
    echo $directory >> "$LOG_FILE"
    echo "$directory: "
    dotfileDir="$DOTFILES/$directory"

    if [[ ! -d  "$dotfileDir" ]] ; then
	echo "The directory $dotfileDir does not exist. Skipping." 
	continue
    fi
    for sourcePath in $(find "$dotfileDir" -iname 'dot-*' -depth 1 |grep -v '~')
    do
	sourceFile="${sourcePath##*/}"
	destFile=".${sourceFile#dot-}"
	echo "	${destFile}"

	if [[ -d "$HOME_DIR/$destFile" ]] ; then
	    rm -rf "$HOME_DIR/$destFile";
	elif [[ -f "$HOME_DIR/$destFile" ]];
	then
	    rm "$HOME_DIR/$destFile";
	fi
	ln -s "$sourcePath" "$HOME_DIR/$destFile" ;
    done
done
