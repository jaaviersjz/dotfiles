## ssh
eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_ed25519 2> /dev/null

### Before doing anything else, restore the last pwd.
if [[ -f ~/.last_pwd ]]; then 
	cd $(cat ~/.last_pwd)
fi

### Cursor
export XCURSOR_THEME=Bibata-Modern-Classic
export XCURSOR_SIZE=24

##### POWERLEVEL10K

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


##### OH-MY-ZSH

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


##### POWERLEVEL10K

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


####### MY CONFIGURATION #######

### Editor
export EDITOR='nvim'

### PATH
export PATH="./:$HOME/.local/share/gem/ruby/3.4.0/bin/:$PATH"

### aliases 
# Machine control
alias reboot="shutdown -r now"
alias shut="shutdown -h now"
# Improved ls
alias ls="colorls" 		
# Improved fzf (open new file with nvim)
alias nf='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'
# Whatsapp
alias whatsapp="google-chrome-stable --ozone-platform=wayland --enable-features=UseOzonePlatform --new-tab https://web.whatsapp.com &"
# Clear screen
alias c='clear'
# Valgrind (debug)
alias valgrind='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s'
# Remove package
alias yeet='sudo pacman -Rns'
# OS installation time
alias age='os-time.sh'
# Lazygit
alias lgit='lazygit'
# Lazydocker
alias ldocker='lazydocker'
# Reflector
alias reflector='reflector --country Spain --latest 5 --protocol https --protocol http --sort rate'
# Fortune
alias quotes='watch -n 20 fortune'
# Imporved df
alias space='df /home/javier/Desktop /home/javier/Desktop/RASPBERRY -h 2> /dev/null'

### compinstall (completions)
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit && compinit

### Raspberry Pi 5 home server ssh access
source ~/.zshrc_raspberry

### valgrind
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

### zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep extendedglob notify
bindkey -v

### yazi (permite cambiar el directorio)
function y() {
	local tmp cwd
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

### Rember last working directory
function chpwd() {
	pwd > ~/.last_pwd;
}

TRAPEXIT() {
	pwd > ~/.last_pwd;
}

### fzf
# Disable zsh globbing (*, ?, etc.)
setopt no_nomatch
setopt no_glob
unsetopt extended_glob
# Load fzf options
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTLR_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_COMPLETION_TRIGGER='*'
export FZF_COMPLETION_OPTS='--preview "if [[ -d {} ]]; then colorls -a --color=always {}; else bat --color=always {}; fi" --preview-window=right:55%:nowrap'
# Override completion command function for files
_fzf_compgen_path() {
  fd --hidden --follow --exclude .git 
}
# Override completion command function for directories
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git
}
# Change Alt+C to Ctrl+F
bindkey -r '^[c'
bindkey '^f' fzf-cd-widget
