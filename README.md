# Mis Configuraciones y Tweaks para Linux

Este es mi repositorio personal de configuraciones, scripts y soluciones para optimizar mi entorno de desarrollo en Linux.

---

## Fix: Bloquear Control de Volumen de Chrome en PipeWire (Fedora)

Esta configuración evita que Google Chrome y navegadores derivados (Brave, Vivaldi, chromium, electron, etc.) ajusten automáticamente el volumen del micrófono en sistemas que usan PipeWire.

### El Problema
Aplicaciones basadas en Chromium intentan "ayudar" ajustando el volumen del micrófono, lo cual interfiere con la configuración manual y puede ser molesto en videollamadas.

### La Solución
Se crea una regla personalizada para PipeWire que le ordena ignorar las solicitudes de cambio de volumen provenientes de estos procesos.

### Pasos de Instalación

1.  **Crear el directorio de configuración (si no existe):**
    ```bash
    sudo mkdir -p /etc/pipewire/pipewire-pulse.conf.d/
    ```

2.  **Crear el archivo de reglas:**
    ```bash
    sudo vim /etc/pipewire/pipewire-pulse.conf.d/10-block-chrome-volume.conf
    ```

3.  **Pegar el siguiente contenido en el archivo:**
    ```plaintext
    # Bloqueo de control de volumen para Google Chrome y derivados
    pulse.rules = [
        {
            matches = [
                {
                    application.process.binary = "chrome"
                }
            ],
            actions = {
                quirks = [ block-source-volume ]
            }
        },
        {
            matches = [
                {
                    application.name = "~(Chromium|Google Chrome).*"
                }
            ],
            actions = {
                quirks = [ block-source-volume ]
            }
        }
    ]
    ```
    Guarda y cierra el archivo (`:wq`).

4.  **Reiniciar los servicios de PipeWire (como usuario, sin `sudo`):**
    ```bash
    systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service
    ```


---

## Configuración de Wezterm + neovim + lazyvim + Zsh (`.zshrc`) + oh-my-zsh + Powerlevel10k

**Las instalaciones:**

* sudo dnf install zsh git neovim ripgrep fd-find unzip golang -y
* sudo dnf install @c-development -y
* sudo dnf copr enable wezfurlong/wezterm-nightly -y
* sudo dnf install wezterm -y

**Insatalar la fuente sin errores:**

* curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
* mkdir -p ~/.local/share/fonts/JetBrainsMonoNerdFont
* unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNerdFont
* rm JetBrainsMono.zip
* fc-cache -f -v



**Plugins Principales:**

* `git`: Integración y alias para Git.
* `sudo`: Facilita la repetición de comandos con `sudo` (doble `Esc`).
* `zsh-autosuggestions`: Sugiere comandos basados en el historial.
* `zsh-syntax-highlighting`: Colorea los comandos en la terminal.

### Instalación

Para usar esta configuración en un nuevo sistema (asumiendo que Oh My Zsh ya está instalado), el método recomendado es crear un **enlace simbólico (symlink)**.

1.  **(Opcional) Haz una copia de seguridad de tu `.zshrc` existente:**
    ```bash
    mv ~/.zshrc ~/.zshrc.bak
    ```
2.  **Crea el enlace simbólico desde el repositorio a tu home:**
    *Asegúrate de ejecutar este comando desde la raíz del repositorio `linux-tweaks`.*
    ```bash
    ln -s "$(pwd)/zsh/zshrc" "$HOME/.zshrc"
    ```



### Funcionalidad 

* git clone https://github.com/LazyVim/starter ~/.config/nvim
* rm -rf ~/.config/nvim/.git


### Look Cyberpunk para más FPS!

* mkdir -p ~/.config/wezterm
* nvim ~/.config/wezterm/wezterm.lua

Si llega a dar error por algún motivo, intenta con 'unset SSH_ASKPASS' para el tema de lazyvim

* nvim ~/.config/nvim/lua/plugins/theme-cyberpunk-neon.lua

El contenido del archivo está dentro de la carpeta nvim

* nvim ~/.config/nvim/lua/config/lazy.lua

Busca la línea { "LazyVim/LazyVim", import = "lazyvim.plugins" } y reemplázala con esta: 

* { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = "cyberpunk-neon" } },

### Cursor Smear

* nvim ~/.config/nvim/lua/plugins/smear-cursor.lua

El contenido del archivo está dentro de la carpeta nvim


--- 

## IA en la terminal

**Ollama:**



**Gemini:**

* sudo dnf install npm
* npm install -g @google/gemini-cli


--- 

## Termux

**F-Droid**:
1.  `Termux` (La terminal base)
2.  `Termux:API` (Necesaria para que Neovim hable con el portapapeles)
3.  `Termux:Styling` (Para los temas y fuentes.)

* pkg update && pkg upgrade -y

* pkg install git zsh neovim build-essential ripgrep fd-find unzip curl termux-api

Seguir pasos iniciales.
