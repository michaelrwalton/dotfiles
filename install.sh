#/bin/bash bash

files="vimrc gitconfig gitignore_global bash_profile bash_git"
locals="gitconfig"

__install_file(){
    if [ -f ~/.$1 ]
    then
        echo "$1 exists! Would you like to overwrite? (y/n)"
        read action
        case "$action" in
        y)
          rm -rf ~/.$1
          ln -s ~/dotfiles/$1 ~/.$1
          echo "$1 overwritten"
          ;;
        n)
          echo "Skipping $1"
          ;;
        *)
          ;;
        esac
    else
        echo "Linking $1"
        ln -s ~/dotfiles/$1 ~/.$1
    fi
}

__install_local(){
    if [ -f ~/.$1.local ]
    then
        echo "Skipping $1.local - file exists"
    else
        echo "Creating $local.local"
        touch ~/.$local.local
    fi
}

echo "Files to be linked: $files"

for file in $files
do
    __install_file $file
done

for local in $locals 
do
    __install_local $local
done
