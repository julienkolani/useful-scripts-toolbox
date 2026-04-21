#!/bin/bash

# Répertoire cible, par défaut le répertoire courant
DIR="${1:-.}"

# Nom du script lui-même
SCRIPT_NAME="reorganize.sh"

# Compteur pour renommer les fichiers
counter=1

# Boucle sur chaque fichier dans le répertoire
for file in "$DIR"/*; do
    # Vérifie que c'est bien un fichier et qu'il ne s'agit pas du script lui-même
    if [[ -f "$file" && $(basename "$file") != "$SCRIPT_NAME" ]]; then
        # Récupère l'extension du fichier
        extension="${file##*.}"

        # Nouveau nom de fichier avec le compteur et la même extension
        new_filename="$counter.$extension"

        # Renomme le fichier
        mv "$file" "$DIR/$new_filename"

        # Incrémente le compteur
        counter=$((counter + 1))
    fi
done

echo "Renommage terminé !"
