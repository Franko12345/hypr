#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------
# Hypr keybindings -> rofi menu
# -----------------------------------------------------

# Try to find keybindings.conf inside ~/.config/hypr (common places)
config_file="$(find "$HOME/.config/hypr" -type f -name 'keybindings.conf' -print -quit 2>/dev/null || true)"

if [[ -z "$config_file" ]]; then
    echo "Não encontrei keybindings.conf em ~/.config/hypr"
    echo "Procure manualmente ou passe o caminho como argumento."
    echo "Ex: $0 /caminho/para/keybindings.conf"
    exit 1
fi

echo "Reading from: $config_file"

# Parse bind lines robustly with awk:
# - ignore commented lines
# - replace $mainMod with SUPER
# - split on commas: first two elements -> keys, rest -> command
keybinds="$(awk '
function trim(s) { sub(/^[ \t\r\n]+/, "", s); sub(/[ \t\r\n]+$/, "", s); return s }
BEGIN { OFS = "" }
/^[ \t]*#/ { next }                                           # skip comments
/^[ \t]*bind[ \t]*=/ {
    line = $0
    # remove everything up to and including the first =
    sub(/^[^=]*=[ \t]*/, "", line)

    # replace $mainMod with SUPER
    gsub(/\$mainMod/, "SUPER", line)

    # split on commas (preserve remaining commas inside command by joining parts >=3)
    n = split(line, parts, /,/)
    if (n < 2) next

    key1 = trim(parts[1])
    key2 = trim(parts[2])

    # build command from parts[3..n]
    cmd = ""
    for (i = 3; i <= n; ++i) {
        if (i > 3) cmd = cmd "," parts[i]
        else cmd = parts[i]
    }
    cmd = trim(cmd)
    # If command is empty, show the whole remaining text
    if (cmd == "") cmd = trim(substr(line, index(line, parts[3])))
    print key1 "  +  " key2 "\t" cmd
}
' "$config_file")"

# If no bind lines found, notify and exit
if [[ -z "${keybinds//[[:space:]]/}" ]]; then
    echo "Nenhuma keybind encontrada em $config_file"
    exit 1
fi

# Show in rofi (use your preferred rofi config)
# note: use a here-string to pass the parsed lines
rofi -dmenu -i -markup -eh 2 -replace -p "Keybinds" -config "$HOME/.config/rofi/config-compact.rasi" <<< "$keybinds"
