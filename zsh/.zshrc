if [ "$TERM_PROGRAM" != tmux ]; then 
  SESSIONS=$(tmux ls)
  if [ -z "${SESSIONS}" ]; then 
    tmux new -s default
  else
    tmux attach -t "$(tmux ls | fzf | sed 's/:.*//')"
  fi 
fi

gcp () {
  git add . &&
  git commit -m "$1" &&
  git push origin main
}

# lvim
alias lv='lvim'
export EDITOR="lvim"

