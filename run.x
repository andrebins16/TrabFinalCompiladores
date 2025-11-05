#!/bin/bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Uso: $0 caminho/arquivo.cmm"
  exit 1
fi

SRC="$1"
BASE="$(basename "$SRC" .cmm)"
OUT_DIR="out"

# Cria pasta de saída
mkdir -p "$OUT_DIR"

# Caminhos dos artefatos
ASM="$OUT_DIR/$BASE.s"
OBJ="$OUT_DIR/$BASE.o"
EXE="$OUT_DIR/$BASE"

# Gera assembly
java -cp target Parser "$SRC" > "$ASM"

# Monta e linka (32 bits)
as --32 -o "$OBJ" "$ASM"
ld -m elf_i386 -s -o "$EXE" "$OBJ"

echo "Gerado:"
echo "  Assembly:  $ASM"
echo "  Objeto:    $OBJ"
echo "  Executável:$EXE"
