export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="splieth"

DEFAULT_USER="splieth"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Language settings
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8

plugins=(git bundler osx vagrant brew docker)

# Source stuff
source $HOME/.oh-my-zsh/oh-my-zsh.sh

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

# load jenv
if command -v jenv > /dev/null; then eval "$(jenv init -)"; fi

# set GRADLE_HOME
GRADLE=$(command -v gradle)
if [ ${GRADLE} != "" ]; then
  gradle_path=$(realpath ${GRADLE})
  export GRADLE_HOME=$(sed 's/\/bin\/gradle//g' <<< ${gradle_path})
fi

export JAVA_HOME=`/usr/libexec/java_home`

# source aws cli as default virtualenv
. $HOME/virtualenvs/awscli/bin/activate
. $HOME/virtualenvs/awscli/bin/aws_zsh_completer.sh

# Da fuck
eval $(thefuck --alias)

# autojump
if [ -f /usr/local/etc/autojump.sh ]; then
  source /usr/local/etc/autojump.sh
fi

# Set py compiler stuf
export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib

# Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# Anaconda
. $HOME/miniconda3/etc/profile.d/conda.sh
export PATH="$HOME/miniconda3/bin:$PATH"


