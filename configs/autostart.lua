-----------------------
----   AUTOSTART   ----
-----------------------

-- Definição de variáveis locais para os comandos
local terminal = "kitty"
local scripts = os.getenv("HOME") .. "/.config/ml4w/scripts"

local dashboard_queue = {
    { class = "btop",       cmd = terminal .. " --class btop -e btop" },
    { class = "peaclock",   cmd = terminal .. " --class peaclock -e peaclock" },
    { class = "tmatrix",    cmd = terminal .. " --class tmatrix -e tmatrix -s 30 -f 0.5,0.5 --no-fade -l 1,10 -r 20,30 -c default -t FRANKO" },
    { class = "cava",       cmd = terminal .. " --class cava -e cava" }
}

local current_index = 1
local initial_opening = true

-- Função auxiliar para lançar o próximo app da fila com segurança
local function launch_app(index)
    local app = dashboard_queue[index]
    if app and app.cmd then
        -- Usando o hl.exec_cmd conforme sua versão
        hl.exec_cmd(app.cmd, { workspace = "3 silent", no_initial_focus = true })
    end
end

hl.on("window.open", function(win_addr)
    if not initial_opening then return end

    local win = hl.get_window(win_addr)

    -- 1. Verifica se a janela que abriu é a que esperávamos na fila
    if win and win.class == dashboard_queue[current_index].class then

        -- 2. Incrementa o índice para o PRÓXIMO app
        current_index = current_index + 1

        -- 3. SÓ executa se ainda houver apps na fila
        if current_index <= #dashboard_queue then
            launch_app(current_index)
        else
            -- Fim da fila, desliga o monitoramento
            initial_opening = false
        end
    end
end)

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
    hl.exec_cmd("discord", { workspace = "2 silent", no_initial_focus = true })

    -- Workspace 3

    -- hl.exec_cmd("[workspace 3 silent; no_initial_focus] " .. terminal .. " -e btop")
    -- hl.exec_cmd("[workspace 3 silent; no_initial_focus] " .. terminal .. " -e tmatrix -s 30 -f 0.5,0.5 --no-fade -l 1,10 -r 20,30 -c default -t FRANKO")
    -- hl.exec_cmd("[workspace 3 silent; no_initial_focus] " .. terminal .. " -e cava")
    -- hl.exec_cmd("[workspace 3 silent; no_initial_focus] " .. terminal .. " -e peaclock")



    hl.exec_cmd(terminal .. " --class btop -e btop", { workspace = "3 silent", no_initial_focus = true})
    -- hl.exec_cmd(terminal .. " -e peaclock", { workspace = "3 silent", no_initial_focus = true })
    -- hl.exec_cmd(terminal .. " -e tmatrix -s 30 -f 0.5,0.5 --no-fade -l 1,10 -r 20,30 -c default -t FRANKO", { workspace = "3 silent", no_initial_focus = true })
    -- hl.exec_cmd(terminal .. " -e cava", { workspace = "3 silent", no_initial_focus = true })


    -- Workspace 4

    -- hl.exec_cmd("[workspace 4 silent; no_initial_focus] flatpak run com.rtosta.zapzap")

    hl.exec_cmd("flatpak run com.rtosta.zapzap", { workspace = "4 silent", no_initial_focus = true })

    -- Restauração do Wallpaper com atraso
    hl.exec_cmd("sleep 3; bash ~/.config/hypr/scripts/wallpaper-restore.sh > ~/log_paper.txt 2>&1")
end)
