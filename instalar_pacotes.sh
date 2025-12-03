#!/bin/bash

# Cores para output
VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AMARELO='\033[1;33m'
NC='\033[0m' # Sem cor

ARQUIVO_PACOTES="pacotes.txt"
ARQUIVO_FALHAS="falhas.txt"
ARQUIVO_SUCESSO="instalados.txt"

# Limpa arquivos de log anteriores
> "$ARQUIVO_FALHAS"
> "$ARQUIVO_SUCESSO"

# Contador
total=$(wc -l < "$ARQUIVO_PACOTES")
atual=0
sucesso=0
falhas=0

echo "========================================"
echo "Instalando $total pacotes..."
echo "========================================"

while IFS= read -r pacote; do
    # Pula linhas vazias
    [[ -z "$pacote" ]] && continue
    
    ((atual++))
    echo -e "\n[${atual}/${total}] Instalando: ${AMARELO}${pacote}${NC}"
    
    if sudo dnf install -y "$pacote" &> /dev/null; then
        echo -e "${VERDE}✓ Sucesso${NC}"
        echo "$pacote" >> "$ARQUIVO_SUCESSO"
        ((sucesso++))
    else
        echo -e "${VERMELHO}✗ Falhou${NC}"
        echo "$pacote" >> "$ARQUIVO_FALHAS"
        ((falhas++))
    fi
done < "$ARQUIVO_PACOTES"

echo ""
echo "========================================"
echo "RESUMO DA INSTALAÇÃO"
echo "========================================"
echo -e "${VERDE}Sucesso: $sucesso pacotes${NC}"
echo -e "${VERMELHO}Falhas: $falhas pacotes${NC}"
echo ""
echo "Veja os pacotes que falharam em: $ARQUIVO_FALHAS"
echo "Veja os pacotes instalados em: $ARQUIVO_SUCESSO"
