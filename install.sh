#/bin/sh bash

files="vimrc gitconfig gitignore_global bash_profile bash_git"
locals="gitconfig"

echo "Files to be linked: $files"

for file in $files
do
    echo "Linking $file"
    ln -s ~/dotfiles/$file ~/.$file
done

echo "Creating local files"
for local in $locals 
do
    echo "Creating $local.local"
    touch ~/.$local.local
done
