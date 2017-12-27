#!/bin/ksh
if [[ -n ${KSH_VERSION} ]] ; then echo "KSH:" $KSH_VERSION ; fi
if [[ -n ${BASH_VERSION} ]] ; then echo "BASH:" $BASH_VERSION ; fi
if [[ ${SHELL: -3} == ksh ]]; then KSH_VERSION="old"; fi

export NOW=`date`

# set PUTTY command prompt
export PROMPT_COMMAND='printf "\033]0;%s   %s\007" "${HOSTNAME%%.*}" "${USER}"'

if [[ $SHLVL == 1 ]] ; then
  if [ -z $BASE_PATH ] ; then
    if [ -d $HOME/bin ] ; then
      export PATH=$HOME/bin:$PATH
    fi
    export BASE_PATH=$PATH
  fi
fi

# find and execute any custom .profile based on the current host
if [ -f ~/.profile.${HOSTNAME} ] ; then
  echo Applying configuration for ${HOSTNAME}
  . ~/.profile.${HOSTNAME}
else
  echo No custom configuration for ${HOSTNAME} found!
fi

. ~/.alias

# find and execute any custom .alias based on the current host
if [ -f ~/.alias.${HOSTNAME} ] ; then
  #echo Applying .alias for ${HOSTNAME}
  source ~/.alias.${HOSTNAME}
fi

if [ -z $KSH_VERSION ] ; then
    PS1='\[\e[1;36m($USER \t \e[1;32m\s $SHLVL\e[1;36m) \e[1;33m${PWD}\[\n\$\[\e[m\]'
else
    PS1='$(print "\033[1;36m($USER $(date +%T)) ";  print "\033[1;32m(ksh $SHLVL) \033[1;33m${PWD} ";print -n "\033[1;33m$\033[m")'
fi

tty > /dev/null 2>&1 && mesg n

