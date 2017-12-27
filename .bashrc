# When an interactive shell that is not a login shell is started, bash reads and executes commands from ~/.bashrc, if that  file  exists.  
# So this is for running our .profile in a pushed bash shell. But if we do this at $SHLVL = 0, we mess up sftp and others
if [[ $SHLVL > 1 ]] ; then
	source ~/.profile
fi
