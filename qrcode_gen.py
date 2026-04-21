import qrcode
from PIL import Image

# URL que tu veux convertir en QR code
url = "https://indabax.cotia.tg"

# Créer une instance de QR code avec des options de haute résolution
qr = qrcode.QRCode(
    version=5,  # Augmente pour plus de détails (5 est une bonne taille pour URL)
    error_correction=qrcode.constants.ERROR_CORRECT_H,  # Meilleure correction d'erreur (jusqu'à 30% de données récupérables)
    box_size=10,  # Taille de chaque case du QR code, ajusté pour une haute résolution
    border=4,  # Bordure plus large pour éviter que le logo interfère avec les bordures du QR code
)

# Ajouter l'URL au QR code
qr.add_data(url)
qr.make(fit=True)

# Créer l'image du QR code avec des couleurs personnalisées
img = qr.make_image(fill_color="black", back_color="white").convert('RGBA')

# Option pour ajouter un logo au centre du QR code
logo_path = "logo.png"  # Assure-toi d'avoir un fichier 'logo.png' avec le fond transparent ou coloré
try:
    logo = Image.open(logo_path).convert("RGBA")
    
    # Calculer la taille du logo
    qr_size = min(img.size)
    logo_size = qr_size // 5  # Le logo fait environ 1/5 de la taille du QR code
    
    # Redimensionner le logo tout en conservant ses proportions
    logo.thumbnail((logo_size, logo_size), Image.LANCZOS)
    
    # Calculer les coordonnées pour centrer le logo
    pos = (
        (img.size[0] - logo.size[0]) // 2,
        (img.size[1] - logo.size[1]) // 2
    )
    
    # Ajouter le logo au centre de l'image du QR code
    img.paste(logo, pos, logo)  # Le troisième paramètre est le masque pour la transparence

except FileNotFoundError:
    print(f"Le fichier {logo_path} est introuvable. Le QR code sera généré sans logo.")

# Sauvegarder l'image du QR code avec haute résolution
img.save("qrcode_with_logo.png", dpi=(300, 300))  # 300 DPI pour haute résolution

# Afficher un message de confirmation
print("QR code haute résolution généré avec logo intégré et sauvegardé sous le nom 'qrcode_with_logo.png'.")
