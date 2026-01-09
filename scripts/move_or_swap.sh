#!/usr/bin/env bash
set -euo pipefail

dir="${1:-}"
case "$dir" in
  l|r|u|d) ;;
  *) exit 0 ;;
esac

# Helper: tenta JSON com -j antes do comando e, se não der, tenta no formato "cmd -j"
hyprj() {
  local cmd="$1"; shift || true
  hyprctl -j "$cmd" "$@" 2>/dev/null || hyprctl "$cmd" -j "$@" 2>/dev/null
}

# Precisa do jq pra ler o JSON
command -v jq >/dev/null 2>&1 || exit 0

# Pega o endereço da janela ativa (campo .address é usado comumente em scripts)
addr="$(hyprj activewindow | jq -r '.address')"

# Função pra obter a posição "at" (x y) dessa mesma janela no output de clients
get_xy() {
  hyprj clients | jq -r --arg addr "$addr" \
    '.[] | select(.address == $addr) | "\(.at[0]) \(.at[1])"'
}

# posição antes
read -r x0 y0 < <(get_xy)

# tenta mover "normal"
hyprctl dispatch movewindow "$dir" >/dev/null 2>&1 || true

# posição depois
read -r x1 y1 < <(get_xy)

# se não mudou, tenta swap
if [[ "$x0 $y0" == "$x1 $y1" ]]; then
  hyprctl dispatch swapwindow "$dir" >/dev/null 2>&1 || true
fi
