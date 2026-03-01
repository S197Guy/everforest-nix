# Custom Aliases - Productivity
alias invoice='InvoiceTUI'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Git Aliases
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gc='git commit'

# System Maintenance
alias update='paru -Syu'
alias cleanup='paru -Rns (paru -Qdtq)'

# Default Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Function to run fastfetch on startup
function fish_greeting
    if status is-interactive
        # Strictly extract the ID from os-release (e.g., arch or cachyos)
        set -l distro_id (grep -E '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
        if test -z "$distro_id"
            set distro_id "arch"
        end
        command fastfetch --logo $distro_id
    end
end
