# .bashrc
# based on https://github.com/helmuthdu/dotfiles

## OVERALL CONDITIONALS {{{
_islinux=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && _islinux=true

_isxrunning=false
[[ -n "$DISPLAY" ]] && _isxrunning=true

_isroot=false
[[ $UID -eq 0 ]] && _isroot=true
# }}}

## GNOME_KEYRING {{{
if which gnome-keyring-daemon &>/dev/null; then
  if [[ -n "$DESKTOP_SESSION" ]]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
  fi
fi
#}}}

[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash

## PS1 CONFIG {{{
  [[ -f $HOME/.dircolors ]] && eval $(dircolors -b $HOME/.dircolors)
  if $_isxrunning; then
    #[[ -f $HOME/.dircolors_256 ]] && eval $(dircolors -b $HOME/.dircolors_256)

    export TERM='xterm-256color' && tput init

    ### foreground colors
    D='\[\e[0;30m\]'   DB='\[\e[1;30m\]'
    R='\[\e[0;31m\]'   RB='\[\e[1;31m\]'
    G='\[\e[0;32m\]'   GB='\[\e[1;32m\]'
    Y='\[\e[0;33m\]'   YB='\[\e[1;33m\]'
    B='\[\e[0;34m\]'   BB='\[\e[1;34m\]'
    M='\[\e[0;35m\]'   MB='\[\e[1;35m\]'
    C='\[\e[0;36m\]'   CB='\[\e[1;36m\]'
    W='\[\e[0;37m\]'   WB='\[\e[1;37m\]'
    S='\[\e[0;1m\]'    RS='\[\e[0m\]'

    function get_prompt_symbol() {
      [[ $UID == 0 ]] && echo "#" || echo "\$"
    }

    if [[ $PS1 && -f ~/.prompt_functions ]]; then
      source ~/.prompt_functions
      export PS1="$W\342\224\214[$(get_err)$W]\342\224\200[$C$(get_upt)$W]\342\224\200[$(get_pcol)\u$W@$YB\h$W]$(get_git)\n$W\342\224\224[$BB\w$W]\342\224\200\342\226\267 \$(get_prompt_symbol) "
    else
      export PS1="$GY[$Y\u$GY@$P\h$GY:$B\W$GY]$W\$(get_prompt_symbol) "
    fi
  else
    export TERM='xterm-color' && tput init
  fi
#}}}
## BASH OPTIONS {{{
  shopt -s cdspell                 # Correct cd typos
  shopt -s checkwinsize            # Update windows size on command
  shopt -s histappend              # Append History instead of overwriting file
  shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
  shopt -s extglob                 # Extended pattern
  shopt -s no_empty_cmd_completion # No empty completion
  ## COMPLETION #{{{
    complete -cf sudo
    if [[ -f /etc/bash_completion ]]; then
      . /etc/bash_completion
    fi
  #}}}
#}}}
## EXPORTS {{{
  export CHROME_BIN=/usr/bin/google-chrome-stable
  export BROWSER="${CHROME_BIN} %s"
  export PROMPT_DIRTRIM=2
  ## EDITOR #{{{
    if which nano &>/dev/null; then
      export EDITOR="nano"
    elif which vim &>/dev/null; then
      export EDITOR="vim"
    else
      export EDITOR="vi"
    fi
  #}}}
  ## BASH HISTORY #{{{
    # make multiple shells share the same history file
    export HISTSIZE=1000            # bash history will save N commands
    export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
    export HISTCONTROL=ignoreboth   # ingore duplicates and spaces
    export HISTIGNORE='&:ls:ll:la:cd:exit:clear:history'
  #}}}
  ## COLORED MANUAL PAGES #{{{
    # @see http://www.tuxarena.com/?p=508
    # For colourful man pages (CLUG-Wiki style)
    if $_isxrunning; then
      export PAGER=less
      export MOST_EDITOE='nano %s'
      export _mb=$'\E[01;31m' # begin blinking
      export LESS_TERMCAP_md=$'\E[01;34m' # begin bold
      export LESS_TERMCAP_me=$'\E[0m'     # end mode
      export LESS_TERMCAP_so=$'\E[0;33m'  # begin standout-mode - info box
      export LESS_TERMCAP_se=$'\E[0m'     # end standout-mode
      export LESS_TERMCAP_us=$'\E[04;32m' # begin underline
      export LESS_TERMCAP_ue=$'\E[0m'     # end underline
    fi
  #}}}
#}}}
## ALIAS {{{
  # AUTOCOLOR {{{
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias pacman='pacman --color=auto'
  #}}}
  # MODIFIED COMMANDS {{{
    alias ..='cd ..'
    alias df='df -x tmpfs -h'
    alias diff='colordiff'  # needs colordiff installed
    alias du='du -c -h'
    alias grep='grep --color=auto'
    alias grep='grep --color=tty -d skip'
    alias mkdir='mkdir -p -v'
    alias more='less'
    alias nano='nano -w'
    alias nanosh='nano -Y sh'
  #}}}
  # PRIVILEGED ACCESS {{{
    if ! $_isroot; then
      alias sudo='sudo '
      alias reboot='sudo reboot'
    fi
  #}}}
  # YOUTUBE {{{
    alias youtube-dl='youtube-dl --console-title --restrict-filenames --ignore-errors --add-metadata -f "best"'
    alias yt='youtube-dl --no-playlist -o "%(title)s.%(ext)s"'
    alias yp='youtube-dl --yes-playlist -o "%(playlist_index)s_%(title)s.%(ext)s"'
    alias yta='yt -x --audio-format "mp3"'
    alias ypa='yp -x --audio-format "mp3"'
  #}}}
  # LS {{{
    alias ls='ls -hF --color=auto --group-directories-first'
    alias ll='ls -lh'
    alias la='ll -A'
  #}}}
  # GIT {{{
    alias gitlog='git log --graph --oneline --decorate'
  #}}}
  # CUSTOM {{{
    alias nssh='ssh -o UserKnownHostsFile=/dev/null ' #prevent ssh from adding connection to known hosts
    if which xfce4-terminal &>/dev/null; then
      alias colortable='xfce4-terminal --color-table'
    fi
    if which yaourt &>/dev/null; then
      alias sysup='yaourt -Syua'
    else
      alias sysup='sudo pacman -Syu'
    fi
  #}}}
#}}}
## FUNCTIONS {{{
  dynlink() { objdump -p ${@} | grep NEEDED; }
  irc () {
    #screen -md -S irc irssi
    local _name="$(screen -ls | grep ${FUNCNAME[0]} 2>/dev/null | cut -f 2)"
    echo -n -e "\033]0;Irssi\007"
    if [[ -z ${_name} ]]; then
      screen -S ${FUNCNAME[0]} -U irssi
    else
      screen -rx ${_name}
    fi
  }
#}}}
