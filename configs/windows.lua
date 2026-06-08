---------------------------------------
----   WINDOWS AND WORKSPACES      ----
---------------------------------------

local terminal = "kitty" -- Definido em programs.conf

-- Configuração de Workspaces (Monitor Binding)
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })

-- Atribuição de Apps a Workspaces
hl.window_rule({ name = "spotify-ws", match = { class = "Spotify" }, workspace = "2 silent" })
hl.window_rule({ name = "discord-ws", match = { class = "discord(-canary)?/i" }, workspace = "2 silent" })
hl.window_rule({ name = "whatsapp-ws", match = { title = "ZapZap" }, workspace = "4 silent" })
hl.window_rule({ name = "btop-ws", match = { class = "^("..terminal.."|btop)", title = "btop" }, workspace = "3 silent" })
hl.window_rule({ name = "peaclock-ws", match = { class = "^("..terminal.."|peaclock)", title = "peaclock" }, workspace = "3 silent" })
hl.window_rule({ name = "cava-pos", match = { class = "^("..terminal.."|cava)", title = "cava" }, size = "400 18", move = "100% 100%" })
hl.window_rule({ name = "browsers-ws", match = { class = "^(brave-browser|firefox)" }, workspace = "1 silent" })
hl.window_rule({ name = "zed", match = { class = "dev.zed.Zed" }, workspace = "1 silent" })

-- Regras Gerais (Opacidade e Comportamento)
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ name = "hytale-opacity", match = { class = "^(HytaleClient|Hytale)" }, opacity = "1 override" })
hl.window_rule({ name = "browser-fix", match = { class = "^(brave-browser|firefox)" }, opacity = "1 override", float = false })

---------------------------------------
----    APLICAÇÕES EM FLOATING     ----
---------------------------------------

-- Áudio e Wallpaper
hl.window_rule({ name = "pavucontrol", match = { class = ".*org.pulseaudio.pavucontrol.*" }, float = true, size = "700 600", center = true, pin = true })
hl.window_rule({ name = "waypaper", match = { class = ".*waypaper.*" }, float = true, size = "900 700", center = true, pin = true })

-- ChatGPT
hl.window_rule({ name = "chatgpt", match = { title = "ChatGPT.*" }, float = true })
hl.window_rule({ name = "chatgpt-web", match = { title = ".*chat.openai.com.*" }, float = true, size = "500 50%", move = "20 70" })

-- Apps ML4W
hl.window_rule({ name = "ml4w-calendar", match = { class = "com.ml4w.calendar" }, float = true, move = "100%-w-16 66", pin = true, size = "400 400" })
hl.window_rule({ name = "ml4w-sidebar", match = { class = "com.ml4w.sidebar" }, float = true, move = "100%-w-16 66", pin = true, size = "400 740" })
hl.window_rule({ name = "ml4w-welcome", match = { class = "com.ml4w.welcome" }, float = true, size = "700 600", center = true, pin = true })
hl.window_rule({ name = "ml4w-settings", match = { class = "com.ml4w.settings" }, float = true, size = "800 600", move = "10% 20%" })

---------------------------------------
----      UTILITÁRIOS SISTEMA      ----
---------------------------------------

hl.window_rule({ name = "blueman", match = { class = "blueman-manager" }, float = true, size = "800 600", center = true })
hl.window_rule({ name = "nwg-look", match = { class = "nwg-look" }, float = true, size = "700 600", move = "10% 20%", pin = true })
hl.window_rule({ name = "nwg-displays", match = { class = "nwg-displays" }, float = true, size = "900 600", move = "10% 20%", pin = true })
hl.window_rule({ name = "mission-center", match = { class = "io.missioncenter.MissionCenter" }, float = true, pin = true, center = true, size = "900 600" })
hl.window_rule({ name = "mission-center-pref", match = { class = "missioncenter", title = "^(Preferences)$" }, float = true, pin = true, center = true })
hl.window_rule({ name = "calculator", match = { class = "org.gnome.Calculator" }, float = true, size = "700 600", center = true })
hl.window_rule({ name = "emoji-smile", match = { class = "it.mijorus.smile" }, float = true, pin = true, move = "100%-w-40 90" })
hl.window_rule({ name = "share-picker", match = { class = "hyprland-share-picker" }, float = true, pin = true, center = true, size = "600 400" })

---------------------------------------
----       FLOATING GERAL          ----
---------------------------------------

hl.window_rule({ name = "dotfiles-floating", match = { class = "dotfiles-floating" }, float = true, size = "1000 700", center = true })
hl.window_rule({ name = "ml4w-ghostty", match = { class = "ml4w.dotfiles.floating" }, float = true, size = "1000 700", center = true, pin = true })

-- Seletores de Ficheiros (GTK)
hl.window_rule({
    name = "file-pickers",
    match = { class = "xdg-desktop-portal-gtk", title = "^(Open.*Files?|Save.*Files?|All Files|Save)" },
    float = true,
    center = true
})

hl.workspace_rule({
    workspace = "3",
    layout = "master",
})

hl.config({ master = {mfact = 0.65} })



---------------------------------------
----      REGRAS DE CAMADA (LAYERS) ----
---------------------------------------

-- SwayNC (Consolidado)
hl.layer_rule({
    name = "swaync-effects",
    match = { namespace = "swaync-.*" },
    blur = true,
    ignore_alpha = 0.5
})

---------------------------------------
----       XWAYLAND BRIDGE         ----
---------------------------------------

hl.window_rule({
    name = "xwayland-bridge-fixes",
    match = { class = "^(xwaylandvideobridge)$" },
    opacity = "0.0 override",
    no_anim = true,
    no_initial_focus = true,
    max_size = "1 1",
    no_blur = true,
    no_focus = true
})
