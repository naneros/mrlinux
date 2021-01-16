local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%(!.%{$fg[red]%}.%{$fg[green]%})%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
