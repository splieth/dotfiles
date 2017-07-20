ZSH_THEME="agnoster"

DEFAULT_USER="splieth"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Source stuff
for file in ~/.{path,exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
source $ZSH/oh-my-zsh.sh

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# history settings
export HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

#options
set -o emacs
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST
setopt NO_NOMATCH # stop bailing on the command when it fails to match a glob pattern

autoload -U compinit
compinit

plugins=(git bundler osx vagrant brew)

# work stuff
if [ -e $HOME/.ottorc ]; then
  source $HOME/.ottorc
fi

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# load direnv
eval "$(direnv hook zsh)"

# load jenv
if command -v jenv > /dev/null; then eval "$(jenv init -)"; fi

# set GRADLE_HOME
GRADLE=$(command -v gradle)
if [ ${GRADLE} != "" ]; then
  gradle_path=$(realpath ${GRADLE})
  export GRADLE_HOME=$(sed 's/\/bin\/gradle//g' <<< ${gradle_path})
fi

# aws cli
. /usr/local/bin/aws_zsh_completer.sh
