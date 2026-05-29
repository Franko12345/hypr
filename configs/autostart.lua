-----------------------
----   AUTOSTART   ----
-----------------------

-- Definição de variáveis locais para os comandos
local terminal = "kitty"
local scripts = os.getenv("HOME") .. "/.config/ml4w/scripts"

hl.on("hyprland.start", function()
    -- Inicialização do Ambiente e Scripts de Suporte
    hl.exec_cmd(scripts .. "/xdg.sh")
    hl.exec_cmd("/usr/lib/pam_kwallet_init && kwalletd6")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Serviços de Interface e Sistema
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swaync -c $HOME/.config/swaync/config.json -s $HOME/.config/swaync/style.css")
    hl.exec_cmd("~/.config/hypr/scripts/gtk.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("~/.config/hypr/scripts/cleanup.sh")
    hl.exec_cmd("~/.config/nwg-dock-hyprland/launch.sh")
    hl.exec_cmd("hyprsunset")

    -- Comando de Rede (Automação de Mesa)
    hl.exec_cmd("curl --connect-timeout 1 --http0.9 http://ledmesa.local/power?state=on")

    -- Aplicativos em Workspaces Específicos (silent e no_initial_focus)
    -- Workspace 1

    -- hl.exec_cmd("[workspace 1 silent; no_initial_focus] zeditor")
    -- hl.exec_cmd("[workspace 1 silent; no_initial_focus] brave")

    hl.exec_cmd("zeditor", { workspace = "1 silent", no_initial_focus = true })
    hl.exec_cmd("brave", { workspace = "1 silent", no_initial_focus = true })

    -- Workspace 2

    -- hl.exec_cmd("[workspace 2 silent; no_initial_focus] flatpak run com.spotify.Client")
    -- hl.exec_cmd("[workspace 2 silent; no_initial_focus] discord-canary")

    hl.exec_cmd("flatpak run com.spotify.Client", { workspace = "2 silent", no_initial_focus = true })
    hl.exec_cmd("discord-canary", { workspace = "2 silent", no_initial_focus = true })

    -- Workspace 3

    -- hl.exec_cmd("[workspace 3 silent; no_initial_focus] " .. terminal .. " -e btop")
    -- hl.exec_cmd("[workspace 3 silent; no_initial_focus] " .. terminal .. " -e tmatrix -s 30 -f 0.5,0.5 --no-fade -l 1,10 -r 20,30 -c default -t FRANKO")
    -- hl.exec_cmd("[workspace 3 silent; no_initial_focus] " .. terminal .. " -e cava")
    -- hl.exec_cmd("[workspace 3 silent; no_initial_focus] " .. terminal .. " -e peaclock")

    hl.exec_cmd(terminal .. " -e btop", { workspace = "3 silent", no_initial_focus = true })
    hl.exec_cmd(terminal .. " -e tmatrix -s 30 -f 0.5,0.5 --no-fade -l 1,10 -r 20,30 -c default -t FRANKO", { workspace = "3 silent", no_initial_focus = true })
    hl.exec_cmd(terminal .. " -e cava", { workspace = "3 silent", no_initial_focus = true })
    hl.exec_cmd(terminal .. " -e peaclock", { workspace = "3 silent", no_initial_focus = true })

    -- Workspace 4

    -- hl.exec_cmd("[workspace 4 silent; no_initial_focus] flatpak run com.rtosta.zapzap")

    hl.exec_cmd("flatpak run com.rtosta.zapzap", { workspace = "4 silent", no_initial_focus = true })

    -- Restauração do Wallpaper com atraso
    hl.exec_cmd("sleep 3; bash ~/.config/hypr/scripts/wallpaper-restore.sh > ~/log_paper.txt 2>&1")
end)
