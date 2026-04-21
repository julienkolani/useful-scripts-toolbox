# Useful Scripts Toolbox

A collection of practical utility scripts for system administration and automation. Includes a QR code generator with logo overlay, image background remover, DNS configuration helper, network interface cleanup utility, file reorganization script, and a cron expression testing notebook.

## Features

- QR code generation with custom logo embedding
- Image background removal using AI/segmentation
- DNS server configuration automation
- Unused network interface detection and removal
- File reorganization utility
- Interactive cron expression tester (Jupyter notebook)

## Tech Stack

- Python 3 (qrcode, Pillow, rembg/backgroundremover)
- Bash
- Jupyter Notebook
- croniter (cron expression parsing)

## Setup

Install Python dependencies:

```bash
pip install qrcode[pil] pillow rembg croniter
```

Scripts are standalone and require no additional installation beyond their stated dependencies.

## Project Structure

```
qrcode_gen.py                # QR code generator with logo overlay
rm_background.py             # Image background removal script
dns_config.sh                # DNS server configuration helper
remove_unused_interface.sh   # Network interface cleanup script
reorganize.sh                # File reorganization utility
cron_expression_tester.ipynb # Jupyter notebook for testing cron expressions
```
