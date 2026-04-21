#!/bin/bash

# Parcourir toutes les interfaces réseau
for i in /sys/class/net/*; do
  # Vérifier si l'interface est active
  if [ ! -f "$i/operstate" ]; then
    continue
  fi

  # Lire le nom de l'interface
  interface=$(basename "$i")

  # Supprimer l'interface
  sudo ip link delete $interface
done
