#HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
#COMPLETION

zmodload zsh/complist 
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle :compinstall filename '${HOME}/.zshrc'
zstyle ':completion:*' menu select
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
bindkey "\e[3~" delete-char
bindkey "e[1~" beginning-of-line
bindkey "e[4~" end-of-line
bindkey "e[5~" beginning-of-history
bindkey "e[6~" end-of-history
bindkey "e[2~" quoted-insert
bindkey "e[5C" forward-word
bindkey "eOc" emacs-forward-word
bindkey "e[5D" backward-word
bindkey "eOd" emacs-backward-word
bindkey "ee[C" forward-word
bindkey "ee[D" backward-word
bindkey "^H" backward-delete-word

autoload -U promptinit
promptinit
autoload -U colors 
colors
PROMPT="%{$fg[red]# %}%~%{$reset_color%} "

# LS COLORS
export LSCOLORS="Gxfxcxdxbxegedabagacad"

if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  if [[ "$(uname -s)" == "NetBSD" ]]; then
    # On NetBSD, test if "gls" (GNU ls) is installed (this one supports colors);
    # otherwise, leave ls as is, because NetBSD's ls doesn't support -G
    gls --color -d . &>/dev/null 2>&1 && alias ls='gls --color=tty'
  elif [[ "$(uname -s)" == "OpenBSD" ]]; then
    # On OpenBSD, "gls" (ls from GNU coreutils) and "colorls" (ls from base, 
    # with color and multibyte support) are available from ports.  "colorls"  
    # will be installed on purpose and can't be pulled in by installing 
    # coreutils, so prefer it to "gls".
    gls --color -d . &>/dev/null 2>&1 && alias ls='gls --color=tty'
    colorls -G -d . &>/dev/null 2>&1 && alias ls='colorls -G'
  else
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
  fi
fi



#ALIASES 

alias syu='pacman -Syu'
alias in='pacman -S'
alias rmv='pacman -Rs'
alias sc='systemctl'
alias ..='cd ..'
alias ...='cd ../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g la='ls -al'
alias ef='ps -ef | grep'
