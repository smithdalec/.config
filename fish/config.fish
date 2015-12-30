set fish_color_autosuggestion 555
set fish_color_command blue
set fish_color_comment red
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_error red
set fish_color_escape cyan
set fish_color_history_current cyan
set fish_color_host normal
set fish_color_match cyan
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param blue
set fish_color_quote brown
set fish_color_redirection normal
set fish_color_search_match
set fish_color_status red
set fish_color_user normal
set fish_color_valid_path underline
set fish_pager_color_completion normal
set fish_pager_color_description 555
set fish_pager_color_prefix cyan
set fish_pager_color_progress cyan


alias la='ls -a'
alias ll='ls -alh'
alias ..='cd ..'
alias ...='cd ../..'
alias hidden_files_show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidden_files_hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

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

  __fish_git_prompt
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
