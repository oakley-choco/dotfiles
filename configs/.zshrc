# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/completions" $fpath)
# OPENSPEC:END

# Source the environment variables
# @see https://stackoverflow.com/a/26020688
# @see http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html
source $HOME/.dotfiles/configs/.exports
source $HOME/.dotfiles/configs/.functions


# Theme: spaceship for most terminals, robbyrussell for Warp
if [[ ${TERM_PROGRAM:-} != "WarpTerminal" ]];then
   ZSH_THEME="spaceship"
else
   ZSH_THEME="robbyrussell"
fi


# The Spaceship theme and prompt's settings
SPACESHIP_TIME_SHOW=true
SPACESHIP_NODE_SHOW=true
SPACESHIP_GOLANG_SHOW=true
SPACESHIP_PYTHON_SHOW=true
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_AWS_SHOW=true
SPACESHIP_TERRAFORM_SHOW=true
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_KUBECTL_SHOW=true
SPACESHIP_KUBECTL_VERSION_SHOW=true
SPACESHIP_KUBECTL_CONTEXT_SHOW=true
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  package       # Package version
  user          # Username section
  host          # Hostname section
  node          # Node.js section
  docker        # Docker section
  aws           # Amazon Web Services section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)


# Plugins
plugins=(git docker docker-compose kubectl kops minikube helm aws zsh-completions zsh-autosuggestions zsh-syntax-highlighting)


# zsh-completions
# @see https://github.com/zsh-users/zsh-completions#oh-my-zsh
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
[[ -e $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh


# Compilation flags: x86_64 for intel, arm64 for apple silicon
if [[ "$(uname -m)" == "arm64" ]];then
   export ARCHFLAGS="-arch arm64"
else
   export ARCHFLAGS="-arch x86_64"
fi


# The multiple runtime version management
[[ -x "$HOMEBREW_PREFIX/bin/mise" ]] && eval "$("$HOMEBREW_PREFIX/bin/mise" activate zsh)"


# Additional settings (work-related, gitignored)
[[ -e $HOME/.dotfiles/configs/.workrc ]] && source $HOME/.dotfiles/configs/.workrc

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Mole shell completion
if output="$(mole completion zsh 2>/dev/null)"; then eval "$output"; fi


# Kaku Shell Integration
[[ ":$PATH:" != *":$HOME/.config/kaku/zsh/bin:"* ]] && export PATH="$HOME/.config/kaku/zsh/bin:$PATH"
[[ -f "$HOME/.config/kaku/zsh/kaku.zsh" ]] && source "$HOME/.config/kaku/zsh/kaku.zsh"
