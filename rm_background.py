from PIL import Image

def remove_background(input_image_path, output_image_path, background_color=(255, 255, 255)):
    """
    Supprime l'arrière-plan d'une image basée sur une couleur donnée.

    :param input_image_path: Chemin vers l'image d'entrée (logo.png)
    :param output_image_path: Chemin vers l'image de sortie avec fond transparent
    :param background_color: Couleur de l'arrière-plan à supprimer (par défaut blanc)
    """
    # Ouvrir l'image
    img = Image.open(input_image_path).convert("RGBA")
    datas = img.getdata()

    # Créer une nouvelle image (avec transparence) sans arrière-plan
    new_data = []
    for item in datas:
        # Comparer chaque pixel avec la couleur de l'arrière-plan
        if item[:3] == background_color:  # Si c'est la couleur de l'arrière-plan
            new_data.append((255, 255, 255, 0))  # Pixel transparent
        else:
            new_data.append(item)  # Garder les autres pixels

    # Appliquer les nouvelles données à l'image
    img.putdata(new_data)

    # Sauvegarder l'image avec le fond effacé
    img.save(output_image_path, "PNG")
    print(f"Arrière-plan supprimé, image sauvegardée sous {output_image_path}")

# Appel de la fonction
remove_background("logo.png", "logo_no_background.png", background_color=(255, 255, 255))
