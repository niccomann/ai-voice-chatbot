import os
import shutil


def elimina_file_cartella(cartella):
    if os.path.exists(cartella):
        # Rimuove tutti i file nella cartella
        for filename in os.listdir(cartella):
            file_path = os.path.join(cartella, filename)
            try:
                if os.path.isfile(file_path) or os.path.islink(file_path):
                    os.unlink(file_path)
                elif os.path.isdir(file_path):
                    shutil.rmtree(file_path)
            except Exception as e:
                print(f'Non è stato possibile eliminare {file_path}. Motivo: {e}')
    else:
        print(f"La cartella {cartella} non esiste.")