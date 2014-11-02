
alias la='ls -a'
alias ll='ls -alh'
alias ..='cd ..'
alias ...='cd ../..'

# Git helpers
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status'
alias gr='git remote -v'
alias gpo='git pull origin'
alias gpho='git push origin'
alias gl="git --no-pager log --graph --date-order --decorate --format=format:'%w(90,0,10)%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset)%C(yellow)%d%C(reset)%n%C(white)%s%C(reset) %C(bold black)- %an%C(reset)' -15"

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  # User
  set_color $fish_color_user
  echo ''
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  echo -n (hostname -s)
  set_color normal

  echo -n ':'

  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  __terlar_git_prompt
  echo

  if not test $last_status -eq 0
  set_color $fish_color_error
  end

  echo -n '🍺  '
  set_color normal
end

function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    if test "$PWD" != "$HOME"
        printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        echo '~'
    end

end
