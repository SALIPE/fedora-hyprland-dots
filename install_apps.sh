#!/bin/bash

# Cores para output
VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AZUL='\033[0;34m'
AMARELO='\033[1;33m'
NC='\033[0m'

echo -e "${AZUL}========================================"
echo "Script de Instalação - Fedora"
echo "========================================${NC}"
echo ""

# Função para verificar sucesso
verificar() {
    if [ $? -eq 0 ]; then
        echo -e "${VERDE}✓ Sucesso${NC}\n"
    else
        echo -e "${VERMELHO}✗ Falhou${NC}\n"
        exit 1
    fi
}

# Atualizar sistema
echo -e "${AMARELO}[1/4] Atualizando sistema...${NC}"
sudo dnf update -y
verificar

# Instalar Rofi e Nemo
echo -e "${AMARELO}[2/4] Instalando Rofi e Nemo...${NC}"
sudo dnf install -y rofi nemo
verificar

# Instalar Nerd Fonts
echo -e "${AMARELO}[3/4] Instalando Nerd Fonts...${NC}"
FONTS_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONTS_DIR"

# Lista de fontes populares para baixar
FONTS=(
    "JetBrainsMono"
    "FiraCode"
    "Hack"
    "Meslo"
    "UbuntuMono"
)

echo "Baixando Nerd Fonts..."
for font in "${FONTS[@]}"; do
    echo -e "  ${AZUL}→${NC} Baixando $font..."
    wget -q --show-progress \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.zip" \
        -O "/tmp/${font}.zip"
    
    if [ -f "/tmp/${font}.zip" ]; then
        unzip -q -o "/tmp/${font}.zip" -d "$FONTS_DIR"
        rm "/tmp/${font}.zip"
        echo -e "    ${VERDE}✓${NC} $font instalada"
    else
        echo -e "    ${VERMELHO}✗${NC} Falha ao baixar $font"
    fi
done

# Atualizar cache de fontes
fc-cache -fv > /dev/null 2>&1
echo -e "${VERDE}✓ Nerd Fonts instaladas${NC}\n"

# Instalar VSCode
echo -e "${AMARELO}[4/4] Instalando VSCode...${NC}"

# Adicionar repositório da Microsoft
echo "Adicionando repositório do VSCode..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Instalar VSCode
sudo dnf install -y code
verificar

echo -e "${VERDE}========================================"
echo "✓ INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
echo "========================================${NC}"
echo ""
echo "Programas instalados:"
echo "  • Rofi"
echo "  • Nemo File Manager"
echo "  • VSCode"
echo "  • Nerd Fonts (JetBrainsMono, FiraCode, Hack, Meslo, UbuntuMono)"
echo ""
echo -e "${AMARELO}Nota:${NC} As fontes foram instaladas em: $FONTS_DIR"
echo "Para ver as fontes disponíveis, execute: fc-list | grep -i nerd"