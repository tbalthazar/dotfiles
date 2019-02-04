#!/bin/bash

source ~/.bash_aliases
source ~/.bash_exports
source ~/.bash_options
source ~/.bash_paths
source ~/.bash_prompt

source ~/.bin/git-completion.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
bind '"\C-y": " \C-e\C-u`__fzf_cd__`\e\C-e\er\C-m"'

if [ -e ~/.bash_profile.private ]; then
  source ~/.bash_profile.private
fi
