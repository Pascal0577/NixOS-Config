{ inputs, pkgs, username, ... }:

{
    nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
    ];

    environment.systemPackages = with pkgs; [
        wl-clipboard
        hyprpaper
        hyprshot
    ];

    imports = with inputs; [
        hyprland.nixosModules.default
        ../../applications/vicinae.nix
        ../../applications/noctalia.nix
    ];

#    programs.hyprland = {
#        enable = true;
#        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
#    };
    services.displayManager.ly.enable = true;

    home-manager.users.${username} = {
        wayland.windowManager.hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            settings = {
                monitor = [
                    "eDP-1, 1920x1200@165, 0x0, 1, bitdepth, 10"
                ];
                "$mod" = "SUPER";
                bind = [
                    "$mod, return, exec, ghostty"
                    "$mod, SPACE, exec, vicinae vicinae://toggle"
                    "$mod, Q, killactive," 
                    "$mod, M, exit,"
                    "$mod, TAB, exec, nautilus"
                    "$mod, V, togglefloating,"
                    "$mod, P, pseudo"
                    "$mod, B, togglesplit,"
                   
                    "$mod, left, movefocus, l"
                    "$mod, right, movefocus, r"
                    "$mod, up, movefocus, u"
                    "$mod, down, movefocus, d"

                    "$mod, 1, workspace, 1"
                    "$mod, 2, workspace, 2"
                    "$mod, 3, workspace, 3"
                    "$mod, 4, workspace, 4"
                    "$mod, 5, workspace, 5"
                    "$mod, 6, workspace, 6"
                    "$mod, 7, workspace, 7"
                    "$mod, 8, workspace, 8"
                    "$mod, 9, workspace, 9"
                    "$mod, 0, workspace, 10"

                    "$mod SHIFT, 1, movetoworkspace, 1"
                    "$mod SHIFT, 2, movetoworkspace, 2"
                    "$mod SHIFT, 3, movetoworkspace, 3"
                    "$mod SHIFT, 4, movetoworkspace, 4"
                    "$mod SHIFT, 5, movetoworkspace, 5"
                    "$mod SHIFT, 6, movetoworkspace, 6"
                    "$mod SHIFT, 7, movetoworkspace, 7"
                    "$mod SHIFT, 8, movetoworkspace, 8"
                    "$mod SHIFT, 9, movetoworkspace, 9"
                    "$mod SHIFT, 0, movetoworkspace, 10"

                    "$mod, S, togglespecialworkspace, magic"
                    "$mod SHIFT, S, movetoworkspace, special:magic"

                    "$mod, mouse_down, workspace, e+1"
                    "$mod, mouse_up, workspace, e-1"
                ];

                bindm = [
                    "$mod, mouse:272, movewindow"
                    "$mod, mouse:273, resizewindow"
                ];

                bindel = [
                     ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                     ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                     ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                     ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                     ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
                     ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
                ];

                bindl = [   
                     ", XF86AudioNext, exec, playerctl next"
                     ", XF86AudioPause, exec, playerctl play-pause"
                     ", XF86AudioPlay, exec, playerctl play-pause"
                     ", XF86AudioPrev, exec, playerctl previous"
                ];

                general = {
                    border_size = 2;
                    gaps_in = 4;
                    gaps_out = 8;
                    float_gaps = 8;
                    gaps_workspaces = 8;
                    #"col.inactive_border" = "rgba(ff444444)";
                    #"col.active_border" = "rgba(ffffffff)";
                    #"col.nogroup_border" = "rgba(ffffaaff)";
                    #"col.nogroup_border_active" = "rgba(ffff00ff)";
                    layout = "scrolling";
                    no_focus_fallback = false;
                    resize_on_border = false;
                    extend_border_grab_area = 15;
                    hover_icon_on_border = false;
                    allow_tearing = false;
                    resize_corner = 0;
                    modal_parent_blocking = true;
                    snap = {
                        enabled = true;
                        window_gap = 10;
                        monitor_gap = 10;
                        border_overlap = false;
                        respect_gaps = false;
                    };
                };

                decoration = {
                    rounding = 10;
                    rounding_power = 3.0;
                    active_opacity = 1.0;
                    inactive_opacity = 1.0;
                    fullscreen_opacity = 1.0;
                    dim_modal = true;
                    dim_inactive = true;
                    dim_strength = 0.2;
                    dim_special = 0.2;
                    dim_around = 0.4;
                    # screen_shader = "path/to/shader.frag";
                    border_part_of_window = true;

                    blur = {
                        enabled = true;
                        size = 8;
                        passes = 2;
                        ignore_opacity = true;
                        new_optimizations = true;
                        xray = false;
                        noise = 0.0117;
                        contrast = 0.8916;
                        brightness = 0.8172;
                        vibrancy = 0.1696;
                        vibrancy_darkness = 0.0;
                        special = true;
                        popups = false;
                        popups_ignorealpha = 0.2;
                        input_methods = false;
                        input_methods_ignorealpha = 0.2;
                    };

                    shadow = {
                        enabled = true;
                        range = 6;
                        render_power = 2;
                        sharp = false;
                        ignore_window = true;
                        # color = "0xee1a1a1a";
                        scale = 1.0;
                    };
                };

                animations = {
                    enabled = true;
                    workspace_wraparound = false;
                    bezier = [
                        "easeOut, 0.6, 1, 0.6, 1"
                    ];
                    animation = [
                        "windows, 1, 2, easeOut, popin"
                        "fade, 1, 2, easeOut"
                        "workspaces, 1, 2, easeOut, slidevert"
                        "specialWorkspace, 1, 1, easeOut, fade"
                    ];
                };

                input = {
                    kb_model = "";
                    kb_layout = "us";
                    kb_variant = "";
                    kb_options = "";
                    kb_rules = "";
                    kb_file = "";
                    numlock_by_default = true;
                    resolve_binds_by_sym = false;
                    repeat_rate = 30;
                    repeat_delay = 500;
                    sensitivity = 0.0;
                    accel_profile = "adaptive";
                    force_no_accel = false;
                    rotation = 0;
                    left_handed = false;
                    scroll_points = "";
                    scroll_method = "2fg";
                    scroll_button = 0;
                    scroll_button_lock = false;
                    scroll_factor = 1.0;
                    natural_scroll = false;
                    follow_mouse = 1;
                    follow_mouse_threshold = 8;
                    focus_on_close = 0;
                    mouse_refocus = true;
                    float_switch_override_focus = 1;
                    special_fallthrough = false;
                    off_window_axis_events = 1;
                    emulate_discrete_scroll = 1;

                    touchpad = {
                        disable_while_typing = true;
                        natural_scroll = true;
                        scroll_factor = 0.8;
                        middle_button_emulation = true;
                        tap_button_map = "lmr";
                        clickfinger_behavior = false;
                        tap-to-click = true;
                        drag_lock = 0;
                        tap-and-drag = true;
                        flip_x = false;
                        flip_y = false;
                        drag_3fg = 0;
                    };
                };

                gestures = {
                    workspace_swipe_distance = 300;
                    workspace_swipe_touch = false;
                    workspace_swipe_invert = true;
                    workspace_swipe_touch_invert = false;
                    workspace_swipe_min_speed_to_force = 30;
                    workspace_swipe_cancel_ratio = 0.4;
                    workspace_swipe_create_new = true;
                    workspace_swipe_direction_lock = true;
                    workspace_swipe_direction_lock_threshold = 10;
                    workspace_swipe_forever = false;
                    workspace_swipe_use_r = false; # What does this even do?
                    close_max_timeout = 1000;
                };

                group = {
                    auto_group = true;
                    insert_after_current = true;
                    focus_removed_window = true;
                    drag_into_group = 1;
                    merge_groups_on_drag = true;
                    merge_groups_on_groupbar = true;
                    merge_floated_into_tiled_on_groupbar = false;
                    group_on_movetoworkspace = false;
                    #"col.border_active" = "0x66ffff00";
                    #"col.border_inactive" = "0x66777700";
                    #"col.border_locked_active" = "0x66ff5500";
                    #"col.border_locked_inactive" = "0x66775500";
                    groupbar = {
                        enabled = true;
                        font_family = "";
                        font_size = 8;
                        font_weight_active = "normal";
                        font_weight_inactive = "normal";
                        gradients = true;
                        height = 14;
                        indicator_gap = 0;
                        indicator_height = 3;
                        stacked = false;
                        priority = 3;
                        render_titles = true;
                        text_offset = 0;
                        scrolling = true;
                        rounding = 2;
                        rounding_power = 2.0;
                        gradient_rounding = 2;
                        gradient_rounding_power = 2.0;
                        round_only_edges = true;
                        gradient_round_only_edges = true;
                        #text_color = "0xffffffff";
                        #"col.active" = "0x66ffff00";
                        #"col.inactive" = "0x66777700";
                        #"col.locked_active" = "0x66ff5500";
                        #"col.locked_inactive" = "0x66775500";
                        gaps_in = 2;
                        gaps_out = 2;
                        keep_upper_gap = true;
                        blur = true;
                    };
                };

                misc = {
                    disable_hyprland_logo = true;
                    disable_splash_rendering = false;
                    disable_scale_notification = false;
                    #"col.splash" = "0xffffffff";
                    font_family = "Ubuntu Sans";
                    splash_font_family = "";
                    force_default_wallpaper = 0;
                    vfr = true;
                    vrr = 3;
                    mouse_move_enables_dpms = false;
                    key_press_enables_dpms = false;
                    name_vk_after_proc = true;
                    always_follow_on_dnd = true;
                    layers_hog_keyboard_focus = true;
                    animate_manual_resizes = true;
                    animate_mouse_windowdragging = true;
                    disable_autoreload = false;
                    enable_swallow = false; # what?
                    swallow_regex = "";
                    swallow_exception_regex = "";
                    focus_on_activate = true;
                    mouse_move_focuses_monitor = true;
                    allow_session_lock_restore = false;
                    session_lock_xray = true;
                    # background_color = "0x111111";
                    close_special_on_empty = true;
                    on_focus_under_fullscreen = 2;
                    exit_window_retains_fullscreen = false;
                    initial_workspace_tracking = 1;
                    middle_click_paste = 3;
                    render_unfocused_fps = 15;
                    disable_xdg_env_checks = false;
                    lockdead_screen_delay = 1000;
                    enable_anr_dialog = true;
                    anr_missed_pings = 5;
                    size_limits_tiled = false;
                };

                binds = {
                    pass_mouse_when_bound = false;
                    scroll_event_delay = 300;
                    workspace_back_and_forth = false;
                    hide_special_on_workspace_change = true;
                    allow_workspace_cycles = false;
                    workspace_center_on = 0;
                    focus_preferred_method = 0;
                    ignore_group_lock = false;
                    movefocus_cycles_fullscreen = false;
                    movefocus_cycles_groupfirst = false;
                    disable_keybind_grabbing = false;
                    allow_pin_fullscreen = false;
                    drag_threshold = 0;
                };

                xwayland = {
                    enabled = true;
                    use_nearest_neighbor = true;
                    force_zero_scaling = false;
                    create_abstract_socket = true;
                };

                render = {
                    direct_scanout = 0;
                    expand_undersized_textures = true;
                    xp_mode = false;
                    ctm_animation = 2;
                    cm_fs_passthrough = 2;
                    cm_enabled = true;
                    send_content_type = true;
                    cm_auto_hdr = 1;
                    new_render_scheduling = false;
                    non_shader_cm = 3;
                    cm_sdr_eotf = 0;
                };

                cursor = {
                    invisible = false;
                    sync_gsettings_theme = true;
                    no_hardware_cursors = 1;
                    no_break_fs_vrr = 2;
                    min_refresh_rate = 24;
                    hotspot_padding = 1;
                    inactive_timeout = 0;
                    no_warps = false;
                    persistent_warps = false;
                    warp_on_change_workspace = 0;
                    warp_on_toggle_special = 0;
                    default_monitor = "";
                    zoom_factor = 1.0;
                    zoom_rigid = false;
                    enable_hyprcursor = false;
                    hide_on_key_press = false;
                    hide_on_touch = true;
                    use_cpu_buffer = 2;
                    warp_back_after_non_mouse_input = false;
                    zoom_disable_aa = false;
                };
            };
        };
    };
}
