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

Instala Oh My Zsh y clona los plugins recomendados, además del tema Powerlevel10k.

```bash
# Instalar Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalar Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

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
    mkdir -p ~/.config/nvim/lua/config
    ln -sf "$(pwd)/nvim/theme-cyberpunk-neon.lua" "$HOME/.config/nvim/lua/plugins/theme-cyberpunk-neon.lua"
    ln -sf "$(pwd)/nvim/smear-cursor.lua" "$HOME/.config/nvim/lua/plugins/smear-cursor.lua"

    # Sistema de Notas (Obsidian)
    ln -sf "$(pwd)/nvim/obsidian.lua" "$HOME/.config/nvim/lua/plugins/obsidian.lua"

    # Archivo central de LazyVim (Activa el colorscheme automáticamente)
    ln -sf "$(pwd)/nvim/lazy.lua" "$HOME/.config/nvim/lua/config/lazy.lua"
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

Mi personalización de Firefox depende de varios archivos `css` para lograr la estética deseada, incluyendo la capacidad de auto-ocultar la barra de herramientas y moverla a la parte inferior.

1.  **Habilitar `userChrome.css`:**
    *   Abre Firefox y ve a la página `about:config`.
    *   Busca la preferencia `toolkit.legacyUserProfileCustomizations.stylesheets` y asegúrate de que esté en `true`.

2.  **Encontrar tu Perfil de Firefox:**
    *   Ve a `about:profiles` en Firefox.
    *   Busca el perfil que está en uso y haz clic en el botón "Abrir directorio" de la "Carpeta raíz".

3.  **Aplicar el Estilo:**
    *   Dentro de la carpeta de tu perfil, crea un directorio llamado `chrome` si no existe, y dentro de este otro llamado `chrome`.
    *   Ahora, crea enlaces simbólicos para los archivos de este repositorio dentro de esa carpeta. Esto asegura que `userChrome.css` pueda importar las otras reglas de estilo.
        ```bash
        # Estando en la raíz de este repositorio (linux-tweaks)
        # Reemplaza RUTA_PERFIL con la ruta de tu perfil de Firefox (la que abriste en el paso anterior)

        mkdir -p "RUTA_PERFIL/chrome/chrome"

        # Enlace para el archivo principal (va en la carpeta chrome/)
        ln -sf "$(pwd)/firefox/userChrome.css" "RUTA_PERFIL/chrome/userChrome.css"

        # Enlaces para las personalizaciones importadas (van en la subcarpeta chrome/chrome/)
        ln -sf "$(pwd)/firefox/chrome/autohide_toolbox.css" "RUTA_PERFIL/chrome/chrome/autohide_toolbox.css"
        ln -sf "$(pwd)/firefox/chrome/toolbars_below_content.css" "RUTA_PERFIL/chrome/chrome/toolbars_below_content.css"
        ```
    *   Reinicia Firefox para ver los cambios. El `userChrome.css` de este repo ya contiene las líneas `@import` necesarias para cargar los otros archivos.

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

### Personalización de GNOME

Para lograr una experiencia de escritorio más completa y visualmente atractiva en GNOME, sigo estos pasos:

1.  **Instalar Herramientas de Personalización:**
    *   Abre la tienda de **Software de GNOME** e instala:
        *   `Extension Manager` (para gestionar extensiones fácilmente).
        *   `GDM Settings` (para personalizar la pantalla de login).
    *   Instala **GNOME Tweaks** desde la terminal, que permite ajustes más detallados:
        ```bash
        sudo dnf install gnome-tweaks -y
        ```

2.  **Instalar Extensiones de GNOME:**
    Usa la aplicación `Extension Manager` que instalaste para buscar e instalar las siguientes extensiones:
    *   `Blur my Shell` (del autor `aunetx`): Añade un efecto de desenfoque al escritorio y al overview.
    *   `Control monitor brightness and volume with ddcutil` (del autor `nei`): Permite controlar el brillo y volumen de monitores externos.
    *   `GSConnect`: Integra tu dispositivo Android con el escritorio GNOME.
    *   `Quick Settings Audio Panel` (del autor `Rayzeq`): Mejora el panel de control de audio.
    *   `Rounded Corners` (del autor `lennart-k`): Suaviza las esquinas de las ventanas.
    *   `Burn My Windows`: (simme)
    *   `Desktop cube`: (simme)

3.  **Aplicar Temas de Iconos y Cursores:**
    *   Como `sudo nautilus` ya no es recomendado en muchas distros, instalaremos los temas desde la terminal:
        ```bash
        # Estando en la raíz de este repositorio (linux-tweaks)
        sudo cp gnome/tweaks/Beyond.zip /usr/share/icons/
        sudo cp gnome/tweaks/DeppinDark-cursors.zip /usr/share/icons/
        sudo unzip /usr/share/icons/Beyond.zip -d /usr/share/icons/
        sudo unzip /usr/share/icons/DeppinDark-cursors.zip -d /usr/share/icons/
        # (Opcional) Limpia los archivos zip copiados
        sudo rm /usr/share/icons/Beyond.zip /usr/share/icons/DeppinDark-cursors.zip
        ```
    *   Abre la aplicación **GNOME Tweaks** (Ajustes), ve a la sección `Apariencia` y selecciona:
        *   **Cursor:** `DeppinDark-cursors`
        *   **Iconos:** `Beyond`

4.  **Personalizar Pantalla de Login (GDM):**
    *   Abre la aplicación **GDM Settings**.
    *   Desde aquí, puedes seleccionar una imagen de fondo de pantalla y un logo personalizados para la pantalla de inicio de sesión. Las imágenes que uso suelen estar en mi carpeta de `Imágenes`. Este paso es más manual y a gusto personal.

---

## Termux (Android)

Para replicar una parte de esta configuración en Termux:

1.  **Desde github, instala:**
    *   `Termux`

2.  **Permisos de almacenamiento:**
    Es crucial dar a Termux acceso al almacenamiento. Ejecuta este comando y acepta el permiso:
    ```bash
    termux-setup-storage
    ```

3.  **Instala los paquetes base en Termux:**
    ```bash
    pkg update && pkg upgrade -y
    pkg install git zsh neovim ripgrep fd fzf unzip curl termux-api fastfetch build-essential pkg-config ndk-sysroot python cmake nodejs-lts -y
    ```

4.  Sigue los pasos de instalación y configuración de **Zsh** y **Neovim** de las secciones anteriores, ya que son muy similares.
    ```bash
    ln -sf ~/storage/shared/Sync ~/Sync
    ```

    ```
5.  **Instalación de Gemini CLI (si falla el método normal):**
    Si `npm install -g @google/gemini-cli` da errores, es probable que necesites especificar la ruta del NDK de Android:
    ```bash
    GYP_DEFINES="android_ndk_path=/data/data/com.termux/files/usr/lib/ndk" npm install -g @google/gemini-cli
    ```

6. **Aplicar Estética y Fuentes sin aplicaciones extra:**
  ```bash
    mkdir -p ~/.termux
    curl -fLo ~/.termux/colors.properties [https://raw.githubusercontent.com/termux/termux-styling/master/app/src/main/assets/colors/argonaut.properties](https://raw.githubusercontent.com/termux/termux-styling/master/app/src/main/assets/colors/argonaut.properties)
    termux-reload-settings
    ```
    ```
---

## Licencia

Este proyecto está bajo la [Licencia MIT](LICENSE).
