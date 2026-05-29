-- Environment Variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("IDF_PATH", os.getenv("HOME") .. "/esp/ESP8266_RTOS_SDK")
hl.env("XDG_SESSION_TYPE", "wayland") -- Recomendado para NVIDIA em vez de x11

-- NVIDIA Specific
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
hl.env("OGL_DEDICATED_HW_STATE_PER_CONTEXT", "ENABLE_ROBUST")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("EGL_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
