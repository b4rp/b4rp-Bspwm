# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Created by newuser for 5.9
source /home/b4rp/powerlevel10k/powerlevel10k.zsh-theme

# ZSH AutoSuggestions Plugin
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ZSH Syntax Highlighting Plugin
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ZSH Sudo Plugin
if [ -f /usr/share/zsh-sudo/sudo.plugin.zsh ]; then
    source /usr/share/zsh-sudo/sudo.plugin.zsh
fi

# Custom Aliases
# ------------------------------
# bat
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

# ls
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


# Use modern completion system
autoload -Uz compinit
compinit
 
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export PATH=/opt/kitty/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin

# Custom functions
# ----------------------
# Set Victim Target

settarget(){
    ip_address=$1
    machine_name=$2
    echo "$ip_address $machine_name" > /home/b4rp/.config/bin/target
}

# Clear Victim Target

cleartarget(){
    echo '' > $HOME/.config/bin/target
}

htbvpn(){
        sudo openvpn $HOME/b4rp/Desktop/VPN/HTB/lab_b4rp.ovpn
}

htbendgames(){
        sudo openvpn $HOME/Desktop/VPN/HTB/endgames_b4rp.ovpn
}

seasonhtb(){
        sudo openvpn $HOME/Desktop/VPN/HTB/competitive_b4rp.ovpn
}

fortressvpn(){
        sudo openvpn $HOME/Desktop/VPN/HTB/fortresses_b4rp.ovpn
}

thmvpn(){
        sudo openvpn $HOME/b4rp/Desktop/VPN/THM/b4rp.ovpn
}

startinghtb(){
         sudo openvpn $HOME/Desktop/VPN/HTB/starting_point_b4rp.ovpn
}

fortresshtb(){
         sudo openvpn $HOME/Desktop/VPN/HTB/fortresses_b4rp.ovpn
}


mkt(){
        mkdir {nmap,content,exploits}
}

burpsuitepro(){
         clear
         java --add-opens=java.desktop/javax.swing=ALL-UNNAMED \
         --add-opens=java.base/java.lang=ALL-UNNAMED \
         --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED \
         --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED \
         --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED \
         -javaagent:"$HOME/Desktop/BurpPro/burploader.jar" -noverify -jar "$HOME/Desktop/BurpPro/burpsuite_pro_v2024.5.jar"

#        cd /home/b4rp/Desktop/BurpSuitePro; java -javaagent:burploader.jar -noverify -jar burpsuite_pro_v2023.12.1.2.jar
}


extractPorts(){
        ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
        ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
        echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
        echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
        echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
        echo $ports | tr -d '\n' | xclip -sel clip
        echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
        cat extractPorts.tmp; rm extractPorts.tmp
}

rmk(){
        scrub -p dod $1
        shred -zun 10 -v $1
}

change_wallpaper() {
    local fondos_dir="$HOME/.config/Wallpapers"
    local bspwmrc_path="$HOME/.config/bspwm/bspwmrc"
    local new_wallpaper

    # Asegurar que la carpeta de fondos existe
    if [ ! -d "$fondos_dir" ]; then
        echo "La carpeta $fondos_dir no existe. Creándola..."
        mkdir -p "$fondos_dir"
        echo "Por favor, coloca los fondos de pantalla en $fondos_dir."
        return
    fi

    # Seleccionar un archivo dentro de la carpeta de Fondos (incluye .jpg, .jpeg y .png)
    new_wallpaper=$(find "$fondos_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | fzf)

    # Verificar si se seleccionó un fondo
    if [ -n "$new_wallpaper" ]; then
        # Hacer una copia de seguridad del bspwmrc antes de modificarlo
        cp "$bspwmrc_path" "$bspwmrc_path.bak"

        # Reemplazar la línea de feh en bspwmrc
        sed -i "/feh --bg-fill/c\feh --bg-fill \"$new_wallpaper\" &" "$bspwmrc_path"

        echo "Fondo de pantalla cambiado a: $new_wallpaper"

        # Aplicar el cambio de inmediato sin necesidad de reiniciar bspwm
        feh --bg-fill "$new_wallpaper"

    else
        echo "No se seleccionó ningún fondo de pantalla."
    fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2024-12-07 02:04:34
export PATH="$PATH:/home/b4rp/.local/bin"
source ~/powerlevel10k/powerlevel10k.zsh-theme
