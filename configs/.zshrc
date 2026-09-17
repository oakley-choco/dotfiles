# 1. 優先定義環境變數與補全路徑 (fpath 必須在 source oh-my-zsh.sh 之前設定)
export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

# OPENSPEC & zsh-completions 加入 fpath
fpath=(
  "$ZSH_CUSTOM/completions"
  "$ZSH_CUSTOM/plugins/zsh-completions/src"
  $fpath
)

# 2. 載入自訂環境變數與函式
[[ -f $HOME/.dotfiles/configs/.exports ]] && source $HOME/.dotfiles/configs/.exports
[[ -f $HOME/.dotfiles/configs/.functions ]] && source $HOME/.dotfiles/configs/.functions

# 3. 主題設定
if [[ ${TERM_PROGRAM:-} != "WarpTerminal" ]]; then
  ZSH_THEME="spaceship"
else
  ZSH_THEME="robbyrussell"
fi

# Spaceship 主題設定
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
  time dir git package user host node docker aws kubectl terraform exec_time line_sep jobs exit_code char
)

# 4. 外掛清單與載入 Oh My Zsh
plugins=(git docker docker-compose kubectl kops minikube helm aws zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# 5. 架構編譯標籤
if [[ "$(uname -m)" == "arm64" ]]; then
  export ARCHFLAGS="-arch arm64"
else
  export ARCHFLAGS="-arch x86_64"
fi

# 6. 多版本管理工具 (Mise / Homebrew 安全載入)
if [[ -d "/opt/homebrew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d "/usr/local/Homebrew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# 7. 工作環境設定 (Gitignored)
[[ -f $HOME/.dotfiles/configs/.workrc ]] && source $HOME/.dotfiles/configs/.workrc

# 8. pnpm 設定
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# 9. Mole CLI 自動補全
if command -v mole &>/dev/null; then
  output="$(mole completion zsh 2>/dev/null)" && eval "$output"
fi

# 10. Kaku Shell 整合
[[ ":$PATH:" != *":$HOME/.config/kaku/zsh/bin:"* ]] && export PATH="$HOME/.config/kaku/zsh/bin:$PATH"
[[ -f "$HOME/.config/kaku/zsh/kaku.zsh" ]] && source "$HOME/.config/kaku/zsh/kaku.zsh"
