# Mis Configuraciones y Tweaks para Linux (Cyberpunk Edition)

Este repositorio contiene mi colección personal de configuraciones (dotfiles), scripts y soluciones para crear un entorno de desarrollo optimizado y con una estética cyberpunk en Linux, principalmente enfocado en Fedora.

![Terminal Cyberpunk](fastfetch/terminalCyberpunk.png)

---

## Características

*   **Terminal:** [WezTerm](https://wezfurlong.org/wezterm/) con transparencia, tema "Cyberdyne" y la fuente "JetBrains Mono Nerd Font".
*   **Shell:** [Zsh](https://www.zsh.org/) gestionado con [Oh My Zsh](https://ohmyz.sh/) y el tema [Powerlevel10k](https://github.com/romkatv/powerlevel10k).
*   **Editor:** [Neovim](https://neovim.io/) configurado con [LazyVim](https://www.lazyvim.org/) para una experiencia de IDE completa, con un tema personalizado de cyberpunk y efectos visuales.
*   **System Fetch:** [Fastfetch](https://github.com/fastfetch-cli/fastfetch) con una configuración personalizada para mostrar la información del sistema con un estilo único.
*   **Plugins de Shell:**
    *   `zsh-autosuggestions`: Sugiere comandos mientras escribes.
    *   `zsh-syntax-highlighting`: Colorea la sintaxis de los comandos.
    *   `fzf`: Búsqueda "fuzzy" para archivos e historial.
*   **Calidad de Vida:**
    *   Un fix para PipeWire que evita que Chrome/Chromium controle el volumen del micrófono.
    *   Integración con herramientas de IA en la terminal como [Aider](https://aider.chat/) y [Gemini CLI](https://github.com/google/gemini-cli).

---

## Instalación (Fedora)

Estas instrucciones están pensadas para una instalación desde cero en Fedora Linux.

### 1. Dependencias Base

Primero, instala las herramientas esenciales y de desarrollo.

```bash
sudo dnf install zsh git neovim ripgrep fd-find unzip golang -y
sudo dnf install @c-development -y
```

### 2. WezTerm (Terminal)

Instalamos la terminal WezTerm usando su repositorio COPR.

```bash
sudo dnf copr enable wezfurlong/wezterm-nightly -y
sudo dnf install wezterm -y
```

### 3. Fuente Nerd Font

Para que los íconos y el tema se vean correctamente, necesitas una "Nerd Font". Usaremos JetBrains Mono.

```bash
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
mkdir -p ~/.local/share/fonts/JetBrainsMonoNerdFont
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNerdFont
rm JetBrainsMono.zip
fc-cache -f -v
```

### 4. Zsh, Oh My Zsh y Powerlevel10k

Instala Oh My Zsh y clona los plugins recomendados.

```bash
# Instalar Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalar plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 5. FZF (Fuzzy Finder)

```bash
sudo dnf install fzf -y
```

---

## Configuración (Symlinks)

Una vez instalado todo, el siguiente paso es aplicar las configuraciones desde este repositorio usando enlaces simbólicos (symlinks). Esto permite mantener los archivos de configuración en el repositorio y que los cambios se apliquen automáticamente.

**Importante:** Ejecuta estos comandos desde la raíz de este repositorio (`linux-tweaks`).

1.  **Zsh:**
    ```bash
    # Haz una copia de tu .zshrc actual (opcional)
    mv ~/.zshrc ~/.zshrc.bak
    # Crea el enlace simbólico
    ln -s "$(pwd)/zsh/zshrc" "$HOME/.zshrc"
    ```

2.  **WezTerm:**
    ```bash
    mkdir -p ~/.config/wezterm
    ln -s "$(pwd)/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
    ```

3.  **Fastfetch:**
    ```bash
    mkdir -p ~/.config/fastfetch
    ln -s "$(pwd)/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    ```

4.  **Neovim (LazyVim con tema Cyberpunk):**

    a. **Clona la configuración inicial de LazyVim:**
    ```bash
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
    ```

    b. **Crea los enlaces para los plugins personalizados:**
    ```bash
    mkdir -p ~/.config/nvim/lua/plugins
    ln -s "$(pwd)/nvim/theme-cyberpunk-neon.lua" "$HOME/.config/nvim/lua/plugins/theme-cyberpunk-neon.lua"
    ln -s "$(pwd)/nvim/smear-cursor.lua" "$HOME/.config/nvim/lua/plugins/smear-cursor.lua"
    ```

    c. **Activa el tema en la configuración de LazyVim:**
    Abre `~/.config/nvim/lua/config/lazy.lua` y reemplaza la línea:
    `{ "LazyVim/LazyVim", import = "lazyvim.plugins" }`
    con esta:
    `{ "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = "cyberpunk-neon" } },`

    *Nota: Si al iniciar Neovim encuentras un error, prueba ejecutando `unset SSH_ASKPASS` en tu terminal antes de volver a abrir `nvim`.*

---

## Tweaks Adicionales

### Bloquear Control de Volumen de Chrome en PipeWire

Para evitar que Chrome y derivados ajusten el volumen de tu micrófono:

1.  **Crea el directorio de configuración (si no existe):**
    ```bash
    sudo mkdir -p /etc/pipewire/pipewire-pulse.conf.d/
    ```

2.  **Crea y edita el archivo de reglas:**
    ```bash
    sudo vim /etc/pipewire/pipewire-pulse.conf.d/10-block-chrome-volume.conf
    ```

3.  **Pega el siguiente contenido:**
    ```plaintext
    # Bloqueo de control de volumen para Google Chrome y derivados
    pulse.rules = [
        {
            matches = [ { application.process.binary = "chrome" } ],
            actions = { quirks = [ block-source-volume ] }
        },
        {
            matches = [ { application.name = "~(Chromium|Google Chrome).*" } ],
            actions = { quirks = [ block-source-volume ] }
        }
    ]
    ```

4.  **Reinicia los servicios de PipeWire (como usuario, sin `sudo`):**
    ```bash
    systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service
    ```

### IA en la Terminal

*   **Aider (Agente IA local con Ollama):**
    ```bash
    curl -LsSf https://aider.chat/install.sh | sh
    # Ejemplo de uso con un modelo local
    aider --model ollama/codegemma:7b
    ```

*   **Gemini CLI:**
    ```bash
    sudo dnf install npm -y
    npm install -g @google/gemini-cli
    ```

### Firefox (Estilo Cyberpunk y PWAs)

#### Personalización Visual (userChrome.css)

Para aplicar una personalización visual a Firefox que coincida con el tema Cyberpunk:

1.  **Habilitar `userChrome.css`:**
    *   Abre Firefox y ve a la página `about:config`.
    *   Busca la preferencia `toolkit.legacyUserProfileCustomizations.stylesheets` y asegúrate de que esté en `true`.

2.  **Encontrar tu Perfil de Firefox:**
    *   Ve a `about:profiles` en Firefox.
    *   Busca el perfil que está en uso y haz clic en el botón "Abrir directorio" de la "Carpeta raíz".

3.  **Aplicar el Estilo:**
    *   Dentro de la carpeta de tu perfil, crea un directorio llamado `chrome` si no existe.
    *   Crea un enlace simbólico al `userChrome.css` de este repositorio dentro de esa carpeta `chrome`.
        ```bash
        # Estando en la raíz de este repositorio (linux-tweaks)
        # Reemplaza RUTA_A_LA_CARPETA_CHROME con la ruta que abriste en el paso anterior + /chrome
        ln -s "$(pwd)/firefox/userChrome.css" "RUTA_A_LA_CARPETA_CHROME/userChrome.css"
        ```
    *   Reinicia Firefox para ver los cambios.

#### Atajos para PWAs (Progressive Web Apps)

Puedes lanzar PWAs de Firefox como si fueran aplicaciones nativas y asignarles atajos de teclado.

1.  **Instalar la Extensión:**
    *   Añade la extensión [PWAs for Firefox](https://addons.mozilla.org/es/firefox/addon/pwas-for-firefox/) a Firefox.

2.  **Instalar una PWA:**
    *   Navega a un sitio compatible con PWA (ej. `web.whatsapp.com`, `app.slack.com`).
    *   Haz clic en el icono de la extensión en la barra de herramientas y selecciona "Install PWA".

3.  **Encontrar el Comando de Lanzamiento:**
    *   Abre una terminal y navega al directorio de aplicaciones locales:
        ```bash
        cd ~/.local/share/applications/
        ```
    *   Busca el archivo `.desktop` de la PWA que instalaste. Puedes usar `ls -l | grep webapp` para filtrar.
    *   Lee el contenido del archivo. Por ejemplo, si el archivo se llama `webapp-Gemini-1234.desktop`:
        ```bash
        cat webapp-Gemini-1234.desktop
        ```

4.  **Extraer el Comando:**
    *   Busca la línea que empieza con `Exec=`. Tendrá un aspecto similar a este:
        ```
        Exec=firefox --class "WebApp-Gemini-12345abcde" --webapp "a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8" %u
        ```
    *   Copia el comando **omitiendo el `%u` del final**. Este es el comando que necesitas para lanzar la PWA directamente.
        ```
        firefox --class "WebApp-Gemini-12345abcde" --webapp "a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8"
        ```

5.  **Crear el Atajo de Teclado (GNOME):**
    *   Ve a `Configuración` > `Teclado` > `Atajos de teclado`.
    *   Baja hasta `Atajos personalizados` y haz clic en el botón `+`.
    *   En el campo "Comando", pega el comando que copiaste en el paso anterior.
    *   Asigna un nombre y la combinación de teclas que desees.
    *   Guarda el atajo. ¡Listo! Ahora puedes lanzar tu PWA con tu atajo personalizado.

---

## Termux (Android)

Para replicar una parte de esta configuración en Termux:

1.  **Desde F-Droid, instala:**
    *   `Termux`
    *   `Termux:API`
    *   `Termux:Styling`

2.  **Instala los paquetes base en Termux:**
    ```bash
    pkg update && pkg upgrade -y
    pkg install git zsh neovim build-essential ripgrep fd-find unzip curl termux-api -y
    ```

3.  Sigue los pasos de instalación y configuración de **Zsh** y **Neovim** de las secciones anteriores, ya que son muy similares.

---

## Licencia

Este proyecto está bajo la [Licencia MIT](LICENSE).