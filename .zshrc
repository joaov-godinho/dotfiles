# =============================================================================
# HISTÓRICO
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory      # Adiciona ao histórico em vez de sobrescrever
setopt sharehistory       # Compartilha o histórico entre abas do Kitty
setopt histignorealldups  # Não salva comandos duplicados

# =============================================================================
# PLUGINS (Instalados via Pacman no Arch)
# =============================================================================
# O Syntax Highlighting DEVE ser o último a ser carregado!
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# =============================================================================
# ATALHOS / ALIASES
# =============================================================================
# Navegação e listagem com cores automáticas
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lha'
alias dir='dir --color=auto'
alias grep='grep --color=auto'

# Segurança (pede confirmação antes de sobrescrever/apagar)
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

# Atalhos do Arch Linux
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'

# =============================================================================
# STARTUP (A Mágica)
# =============================================================================
# Inicia o prompt Starship
eval "$(starship init zsh)"

# Roda o Fastfetch toda vez que abrir um terminal novo
fastfetch
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
