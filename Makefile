t=

config:
	mkdir ~/.config/nvim/
	mv * ~/.config/nvim/
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.config}"/nvim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	nvim -c :PlugInstall
	echo "Finished! Type 'nvim' to start to hack :)"

