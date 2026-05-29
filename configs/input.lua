hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",
        kb_options = "lv3:switch",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
    cursor = {
        no_hardware_cursors = true,
    }
})

-- Per-device config
hl.device({
    name = "at-translated-set-2-keyboard",
    kb_layout = "br",
    kb_variant = "",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})
