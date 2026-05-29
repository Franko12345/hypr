-----------------------
---- CONFIGURAÇÕES ----
-----------------------

-- Variáveis de ambiente e caminhos
local mainMod = "SUPER"
local hyprscripts = os.getenv("HOME") .. "/.config/hypr/scripts"
local scripts = os.getenv("HOME") .. "/.config/ml4w/scripts"

-- Definição de programas (ajuste conforme necessário se não estiverem no env)
local terminal = "kitty"
local fileManager = "dolphin"
local fileManagerGUI = "dolphin"
local browser = "brave"

hl.config({
    dwindle = {
        default_split_ratio = 1.0,
    }
})

----------------------
---- KEYBINDINGS  ----
----------------------

-- Gerenciamento de Janelas e Apps
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("systemctl --user restart --now hyprsunset.service"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(terminal .. " -e tmatrix -s 30 -f 0.5,0.5 --no-fade -l 1,10 -r 20,30 -c default -t FRANKO", { workspace = "3 silent", no_initial_focus = true }))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManagerGUI))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + L", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1 }))

-- Scripts e Utilitários
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(hyprscripts .. "/screenshot.sh --instant-area"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(terminal .. " --class dotfiles-floating -e " .. hyprscripts .. "/wegoF.sh", { size = "1300 925" }))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(terminal .. " --class dotfiles-floating -e fpf", { size = "1300 925" }))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd(terminal .. " --class dotfiles-floating -e fpf -a", { size = "1300 925" }))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("waypaper"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -replace -i"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(scripts .. "/cliphist.sh"))

-- Controle de Zoom (Display)
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd('hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep \'float:\' | awk \'{print $2}\') + 0.5}")'))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.exec_cmd('hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep \'float:\' | awk \'{print $2}\') - 0.5}")'))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 0"))

-- Movimentação de Foco
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Mover Janelas (Move or Swap Scripts)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({direction = "l"}), move_or_swap_opts)
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({direction = "r"}), move_or_swap_opts)
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({direction = "u"}), move_or_swap_opts)
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({direction = "d"}), move_or_swap_opts)


-- Redimensionamento (Repeating)
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -25, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 25, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -25, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 25, relative = true }), { repeating = true })

-- Navegação ALT+Tab
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { repeating = true })
-- hl.bind("ALT + Tab", hl.dsp.window.bringactivetotop(), { repeating = true })

-- Workspaces (Loop para otimização)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse Binds (Dragging/Resizing)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Teclas Multimídia (Locked & Repeating)
local mediaOptions = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), mediaOptions)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), mediaOptions)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), mediaOptions)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), mediaOptions)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), mediaOptions)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), mediaOptions)

-- Player Control (Locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
