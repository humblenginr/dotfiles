if [ "$TERM_PROGRAM" != tmux ]; then 
  SESSIONS=$(tmux ls)
  if [ -z "${SESSIONS}" ]; then 
    tmux new -s default
  else
    tmux attach -t "$(tmux ls | fzf | sed 's/:.*//')"
  fi 
fi

alias crepo='$HOME/dotfiles/repo.sh' 

export EDITOR="nvim"

