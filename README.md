# .dotfiles
Personal dot files


# Some hints on how to connect 

echo "This will remove existing files and clobber them with .dotfiles"
read
for file in .doingrc .gitignore_global .hyper.js .hyper_plugins .inputrc .tmux.conf .zshrc; echo $file >> ~/Desktop/upddateDotfiles.log; echo $file; rm "$HOME/$file"; ln -s "$HOME/src/github.com/jshelton/.dotfiles/$file" ~/ ; end

