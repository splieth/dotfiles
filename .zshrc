export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="titan"

DEFAULT_USER="splieth"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Language settings
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8

plugins=(aws brew docker gcloud git helm kubectl pass pipenv)

# Disable virtualenv left of prompt
export VIRTUAL_ENV_DISABLE_PROMPT=0

# custom stuff
export PATH="$PATH:$HOME/.bin/private"

# skdman
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add homebrew to path
eval $(/opt/homebrew/bin/brew shellenv)

# brew ZSH completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

# Source stuff
source $HOME/.oh-my-zsh/oh-my-zsh.sh

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# history settings
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=950000
export SAVEHIST=950000
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt HIST_BEEP              # Beep when accessing nonexistent history.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.

#options
set -o emacs
setopt CORRECT       #spelling corrector
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS   # allow functions to have local traps
setopt NO_NOMATCH    # stop bailing on the command when it fails to match a glob pattern
setopt PROMPT_SUBST  # parameter expansion, command substitution and arithmetic expansion are performed in prompts
setopt RM_STAR_WAIT  # sanity check for 'rm *'

# set GRADLE_HOME
GRADLE=$(command -v gradle)
if [ ! -z ${GRADLE} ]; then
  gradle_path=$(realpath ${GRADLE})
  export GRADLE_HOME=$(sed 's/\/bin\/gradle//g' <<< ${gradle_path})
fi
# export JAVA_HOME=`/usr/libexec/java_home`

# Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Set py compiler stuf
export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib

# GPG
export GPG_TTY=$(tty)

# GO bin
export PATH="${PATH}:${HOME}/go/bin/"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# files
for file in ~/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
source <(gopass completion bash)

#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source /Users/splieth/.docker/init-zsh.sh || true # Added by Docker Desktop


# Load Angular CLI autocompletion.
source <(ng completion script)
