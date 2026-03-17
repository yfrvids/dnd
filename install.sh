#!/bin/bash

# Crear directorio de configuración
CONFIG_DIR="$HOME/.config/dnd"
mkdir -p "$CONFIG_DIR"

# Copiar archivos necesarios
cp init.lua "$CONFIG_DIR"
cp -r lua "$CONFIG_DIR"
cp -r bin "$CONFIG_DIR"

# Hacer ejecutable el script
chmod +x "$CONFIG_DIR/bin/dnd"

# Agregar al PATH
if [[ ":$PATH:" != *":$CONFIG_DIR/bin:"* ]]; then
  echo 'export PATH="$PATH:'"$CONFIG_DIR/bin"'"' >> ~/.bashrc
  echo 'export PATH="$PATH:'"$CONFIG_DIR/bin"'"' >> ~/.zshrc
  echo "dnd (DeltanvimDocs) has been added to your PATH. Please restart your terminal."
fi
