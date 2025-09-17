# Mis Configuraciones y Tweaks para Linux

Este repositorio es mi arsenal personal de configuraciones, scripts y soluciones para optimizar mi entorno de desarrollo en Linux.

---

## Fix: Bloquear Control de Volumen de Chrome en PipeWire (Fedora)

Esta configuración evita que Google Chrome y navegadores derivados (Brave, Vivaldi, etc.) ajusten automáticamente el volumen del micrófono en sistemas que usan PipeWire.

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

## Configuración de Zsh (`.zshrc`)

Mi configuración personal de Zsh. Utiliza **Oh My Zsh** como base con el tema **Powerlevel10k**.

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
