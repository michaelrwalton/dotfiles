#/bin/bash bash

files="vimrc gitconfig gitignore_global bash_profile bash_git"
locals="gitconfig bash_profile vimrc"

__install_file(){
    if [ -f ~/.$1 ]
    then
        echo "$1 exists! Would you like to overwrite/append? (o/a/n)"
        read action
        case "$action" in
        o)
          cp -v ~/.$1 ~/.$1.old
          ln -s ~/dotfiles/$1 ~/.$1
          echo "$1 overwritten"
          ;;
        a)
          echo "Appending $1 to current version"
          cat ~/.$1 >> ~/dotfiles/$1
          cp -v ~/.$1 ~/.$1.old
          ln -s ~/dotfiles/$1 ~/.$1
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
