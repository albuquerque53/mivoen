t=

config:
	mv ../mivoen ~/.config/nvim/
	sh -c 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	nvim -c :PlugInstall
	echo "Finished! Type 'nvim' to start to hack :)"

