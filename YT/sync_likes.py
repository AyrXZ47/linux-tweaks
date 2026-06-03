from ytmusicapi import YTMusic
import time

print("Iniciando conexión con browser.json...")
yt = YTMusic("browser.json")

print("Obteniendo la lista maestra de 'Me Gusta'...")
likes = yt.get_liked_songs(limit=10000)
canciones = likes.get('tracks', [])

# 1. Extraer IDs crudos
video_ids_raw = [track['videoId'] for track in canciones if track.get('videoId')]

# 2. LIMPIEZA LOCAL: Eliminamos cualquier ID duplicado desde Python manteniendo el orden original
video_ids = list(dict.fromkeys(video_ids_raw))
print(f"Total de IDs únicos reales a transferir: {len(video_ids)}")

MAX_PLAYLIST_SIZE = 4900
partes = [video_ids[i:i + MAX_PLAYLIST_SIZE] for i in range(0, len(video_ids), MAX_PLAYLIST_SIZE)]

print(f"\nSe crearán {len(partes)} playlists.")

for indice, bloque in enumerate(partes):
    num_parte = indice + 1
    nombre_pl = f"Mis Likes - Parte {num_parte} (Final)"
    print(f"\n========================================")
    print(f"Creando la playlist: '{nombre_pl}'...")
    
    playlist_id = yt.create_playlist(
        nombre_pl, 
        f"Respaldo oficial (Parte {num_parte})", 
        privacy_status="PUBLIC"
    )
    
    lote_size = 50
    for i in range(0, len(bloque), lote_size):
        lote = bloque[i:i + lote_size]
        reintentos = 3
        exito = False
        
        while reintentos > 0 and not exito:
            try:
                # LA MAGIA: duplicates=True obliga al servidor a no rechazar lotes silenciosamente
                yt.add_playlist_items(playlist_id, lote, duplicates=True)
                progreso = min(i + lote_size, len(bloque))
                print(f"[{nombre_pl}] Progreso: {progreso} / {len(bloque)} transferidas...")
                exito = True
                time.sleep(2)
            except Exception as e:
                reintentos -= 1
                print(f"Falla de red en lote {i}. Reintentando... ({reintentos} restantes)")
                time.sleep(5)
                
        if not exito:
            print(f"ERROR: No se pudo inyectar el bloque del {i} al {i+lote_size}.")

print("\n========================================")
print("Sincronización terminada. Revisa los números en tu app.")

