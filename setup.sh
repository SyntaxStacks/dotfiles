find ./dotfiles -not -name ".x" -type f | while read FILENAME; do
	FILE=$(basename ${FILENAME});
	DIR=$( cd "$( dirname "${FILE}" )" && pwd )
	eval "echo $FILE";
	eval "rm ~/$FILE";
	eval "ln -s $DIR/dotfiles/$FILE ~/$FILE";
done

eval "ln -s $(pwd)/snippets ~/.vim/snippets"
eval "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
eval "vim +PluginInstall +qall"

eval "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"

