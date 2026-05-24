#!/bin/bash

# 1. Crear directorios necesarios
mkdir -p ~/.config/mpd/playlists
mkdir -p ~/.config/ncmpcpp

# 2. Detectar el sistema operativo y generar la configuración local de audio y rutas
LOCAL_CONF="$HOME/.config/mpd/mpd_local.conf"

if [ "$(uname -o)" == "Android" ]; then
  echo "🤖 Configurando entorno para Termux (Android)..."
  cat <<'EOF' >"$LOCAL_CONF"
music_directory "~/Sync/My Music"

audio_output {
    type "pulse"
    name "Termux Audio"
}

audio_output {
    type "fifo"
    name "my_fifo"
    path "/tmp/mpd.fifo"
    format "44100:16:2"
}
EOF
else
  echo "🎩 Configurando entorno para Fedora Linux..."
  cat <<'EOF' >"$LOCAL_CONF"
music_directory "~/Sync/My Music"

audio_output {
    type "pipewire"
    name "Fedora Audio"
}

audio_output {
    type "fifo"
    name "my_fifo"
    path "/tmp/mpd.fifo"
    format "48000:16:2"
}
EOF
fi

# 3. Crear enlaces simbólicos (Symlinks) desde el repo a ~/.config
echo "🔗 Creando enlaces simbólicos..."
ln -sf "$(pwd)/mpd/mpd.conf" "$HOME/.config/mpd/mpd.conf"
ln -sf "$(pwd)/ncmpcpp/config" "$HOME/.config/ncmpcpp/config"
