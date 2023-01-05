# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# Load personal prompt config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Load powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

#########################################
####### ZSH configuration file    #######
#########################################

### Set/unset Shell options
#########################
# setopt autolist # Automatically list choices on an ambiguous completion.
# setopt HASH_CMDS
# setopt MENUCOMPLETE

### History options
# setopt append_history # Append zsh session command history to the history file when they exit.
setopt share_history # share history between different instances of the shell
setopt inc_append_history # save history entries as soon as they are entered
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt hist_ignore_dups # Do not enter command lines into the history list if they are duplicates of the previous event. 
setopt extended_history # Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file
setopt auto_remove_slash # When the last character resulting from a completion is a slash and the next character typed is a word delimiter, a slash, or a character that ends a command (such as a semicolon or an ampersand), remove the slash. 

### Input/Output options
setopt correct # Try to correct the spelling of commands.
setopt correct_all # Try to correct the spelling of all arguments in a line.
setopt mail_warning # Print a warning message if a mail file has been accessed since the shell last checked. 
setopt interactive_comments # allow comments in interactive shells
setopt rc_quotes # Allow the character sequence ‘’’’ to signify a single quote within singly quoted strings. Note this does not apply in quoted strings using the format $’...’, where a backslashed single quote can be used.

### Job Control options
setopt auto_resume # Treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt nohup # Don't send SIGHUP to running jobs when the shell exits
setopt notify # Report the status of background jobs immediately, rather than waiting until just before printing a prompt. 
setopt long_list_jobs # Print job notifications in the long format by default.
unsetopt bgnice # Run all background jobs at a lower priority. This option is set by default.
# setopt no_flow_control # If this option is unset, output flow control via start/stop characters (usually assigned to ^S/^Q) is disabled in the shell’s editor.

### Expansion and Globbing options
setopt glob_dots # Do not require a leading ‘.’ in a filename to be matched explicitly.
setopt extendedglob # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc. (An initial unquoted ‘~’ always produces named directory expansion.)
# setopt +o nomatch # If a pattern for filename generation has no matches, print an error, instead of leaving it unchanged in the argument list. This also applies to file expansion of an initial ‘~’ or ‘=’. Bash does this. If we want to emulate bash, turn this options off (setopt +o turns off options).

### Changing Directories options
setopt auto_cd # If a command is issued that can’t be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory.
setopt autopushd # Make cd push the old directory onto the directory stack.
setopt cdablevars # If the argument to a cd command (or an implied cd with the AUTO_CD option set) is not a directory, and does not begin with a slash, try to expand the expression as if it were preceded by a ‘~’
setopt pushdminus # Exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack.
setopt pushd_to_home # Have pushd with no arguments act like ‘pushd $HOME’.
setopt pushd_silent # Do not print the directory stack after pushd or popd.

### Completion options
setopt rec_exact # If the string on the command line exactly matches one of the possible completions, it is accepted, even if there is another completion (i.e. that string with something else added) that also matches.
setopt all_export # All parameters subsequently defined are automatically exported.
unsetopt autoparamslash # If a parameter is completed whose content is the name of a directory, then add a trailing slash instead of a space.

### Autoload zsh modules when they are referenced
#################################################
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

### Autoload word style selector
autoload -U select-word-style
select-word-style bash

### Autoload completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zmodload zsh/complist

### Autoload completion suggestions
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

### Set variables
#################
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000
HOSTNAME="`hostname`"
EDITOR=nvim
MANPAGER="sh -c 'col -b | bat -l man -p'"

### Set alias
#############
alias grep='grep --color=auto'

# Enable zoxid directory command
eval "$(zoxide init zsh)"
alias cd='z'

#dont correct the commands after sudo (dont treat them as arguments)
alias sudo='nocorrect sudo'

alias vim='nocorrect ~/.local/bin/lvim'
alias cat='bat --theme=TokyoNight'
alias ssh='kitty +kitten ssh'
alias ls='exa --git -h --icons'
alias ll='exa --git -lhgb --icons'
alias la='exa --git -alhgb --icons'

### Bind keys
#############
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# bind positional keys to their original functions
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# bind Ctrl+arrows to word jumping
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey ' ' magic-space    # also do history expansion on space

# run command line as user root via sudo:
function sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    local cmd="sudo "
    if [[ ${BUFFER} == ${cmd}* ]]; then
        CURSOR=$(( CURSOR-${#cmd} ))
        BUFFER="${BUFFER#$cmd}"
    else
        BUFFER="${cmd}${BUFFER}"
        CURSOR=$(( CURSOR+${#cmd} ))
    fi
    zle reset-prompt
}
zle -N sudo-command-line

## prepend the current command with "sudo"
#Ctrl+o s
bindkey "^Os" sudo-command-line
#Ctrl+a s
bindkey "^As" sudo-command-line
#Esc Esc
bindkey "\e\e" sudo-command-line

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  function zle-line-init () {
  echoti smkx
}
function zle-line-finish () {
echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish
fi

### set fzf-tab options
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

### fzf bindings and completion
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS\
--color=fg:#c0caf5,bg:#24283b,hl:#7dcfff \
--color=fg+:#c0caf5,bg+:#24283b,hl+:#73daca \
--color=info:#a9b1d6,prompt:#f7768e,pointer:#bb9af7 \
--color=marker:#9ece6a,spinner:#f7768e,header:#73daca"

### Source plugins with sheldon plugin manager
eval "$(sheldon source)"

### Source plugins
##################
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

unsetopt ALL_EXPORT

### autostart tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# To customize prompt, run `p10k configure` or edit ~/git/dotfiles/.p10k.zsh.
[[ ! -f ~/git/dotfiles/.p10k.zsh ]] || source ~/git/dotfiles/.p10k.zsh
