# Include settings file. It should match settings.conf.dist
source "$(pwd)/.dotfiles/settings.conf"

# Variables for use throughout .bash_profile
#-------------------------------------------------------------------------------

# The location of this file (not symlinks)
dotfiles_dir="$home_dir/.dotfiles"

# Define color vars for prompt
off='\[\e[0m\]' black='\[\e[0;30m\]' red='\[\e[0;31m\]' green='\[\e[0;32m\]' yellow='\[\e[0;33m\]' blue='\[\e[0;34m\]' purple='\[\e[0;35m\]' cyan='\[\e[0;36m\]' white='\[\e[0;37m\]'

# Include scripts
#-------------------------------------------------------------------------------

# Enable Git tab completion
source "$dotfiles_dir/scripts/git-completion.bash"

# Aliases
#-------------------------------------------------------------------------------
alias la='ls -a'
alias ll='ls -alh'
alias ..='cd ..'
alias ...='cd ../..'
alias db="cd $db_dir"
alias bashrc="subl $dotfiles_dir/bashrc"

# Function aliases
alias fs='find_string'
alias tarb='tarball'
alias tarx='tar_extract'

# Apache/MySQL helpers
alias apre='sudo apachectl restart'
alias amp='apre; sudo /usr/local/mysql/support-files/mysql.server restart'
alias ampstart='sudo apachectl start; sudo /usr/local/mysql/support-files/mysql.server start'
alias ampstop='sudo apachectl stop; sudo /usr/local/mysql/support-files/mysql.server stop'

# Git helpers
alias gc='git commit -am'
alias gs='git status'
alias gr='git remote -v'
alias gpo='git pull origin'
alias gpho='git push origin'

# Loki-specific
alias xboff='sudo /etc/init.d/ushare stop'
alias xbon='sudo /etc/init.d/ushare start'

# Set environment variables
#-------------------------------------------------------------------------------

# Set the bash prompt
export PROMPT_COMMAND=prompt_func

# Build bin path
export PATH=/usr/local/mysql/bin:/usr/local/bin:/Users/Dale/pear/bin:/Users/dale/pear/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:$PATH

# Enable colors for directories
export CLICOLOR=1
export LSCOLORS=exFxCxDxBxegedabagacad

# Functions
#-------------------------------------------------------------------------------

# Find a string, recursively, in any file
function find_string {
  grep -Rl "$1" *
}

# Make a tarball, and I don't have to remember the flag order!
function tarball () {
  # Get rid of trailing slash from tab completion
  dir=${1%/}
  # Print out the command, so I know what it's doing
  echo tar -czf "$dir".tgz $dir
  tar -czf "$dir".tgz $dir
}

# Extract a tarball, and I don't have to remember the flag order!
function tar_extract {
  tar -xvzf $1
}

# Set the bash prompt
function prompt_func () {
  previous_return_value=$?;
  PS1="\n$white\u@\H [$yellow\w$white] $green$(git_branch)\n$white> $off"
}

# Check if ST2 is installed and use vim as a backup editor
function get_editor () {
  if hash subl 2>/dev/null; then
      echo 'vim'
  else
      echo 'subl'
  fi
}

# Echo the current Git branch for prompt
function git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ! ${git_status} =~ "working directory clean" ]]; then
    state=$red
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${yellow}↑"
    else
      remote="${yellow}↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${yellow}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo "${state}(${branch})${remote}"
  fi
}