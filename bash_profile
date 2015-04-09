#
# ~/.bash_profile
#

export PATH=/usr/local/bin:$PATH
if [[ -d "$(xdg-user-dir DOCUMENTS)/scripts" ]] ; then
	PATH="$(xdg-user-dir DOCUMENTS)/scripts:$PATH"
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
