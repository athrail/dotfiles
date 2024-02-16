# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

import os
import subprocess
from libqtile import hook, bar, layout, widget
from libqtile.config import Click, Drag, Group, Match, Key, Screen
from libqtile.lazy import lazy
from libqtile.core.manager import Qtile

mod = "mod4"
terminal = "xfce4-terminal"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.up(),
        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "control"], "j", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    # Move around groups
    Key([mod, "control"], "Left", lazy.screen.prev_group()),
    Key([mod, "control"], "Right", lazy.screen.next_group()),

    # # Increase master window size
    # Key([mod, "shift"], "Left", lazy.layout.decrease_ratio()),
    # Key([mod, "shift"], "Right", lazy.layout.increase_ratio()),

    # Switch window focus to other pane(s) of stack
    # Key([mod], "space", lazy.layout.next(),
    #     desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod, "shift"], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "Tab", lazy.next_screen(), desc="Move focus to next screen"),

    Key([mod], "e", lazy.spawn("thunar"), desc=""),
    Key([mod], "f", lazy.window.toggle_floating(), desc=""),
    Key([mod], "l", lazy.spawn("xflock4"), desc="Screen lock"),

    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key(["mod1", "control"], "Return", lazy.window.toggle_fullscreen(), desc="Toggle full screen"),

    # Custom run commands
    Key([mod], "r", lazy.spawn("rofi -show drun -columns 2 -show-icons -font 'Fira Sans 12'"), desc=""),
    Key([mod], "period", lazy.spawn("rofi -show emoji"), desc=""),

    Key([mod], "c", lazy.spawn("sh /home/athrail/.scripts/rofi/edit_config.sh"), desc=""),
    Key([mod], "e", lazy.spawn("thunar"), desc=""),
    Key([mod, "control"], "0", lazy.spawn("sh /home/athrail/.scripts/rofi/shutdown.sh"), desc=""),

    # Sound
    # Key([], "XF86AudioMute", lazy.spawn("pulseaudio-ctl mute")),
    # Key([], "XF86AudioLowerVolume", lazy.spawn("pulseaudio-ctl down")),
    # Key([], "XF86AudioRaiseVolume", lazy.spawn("pulseaudio-ctl up")),

    # Monadtall keybindings
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod], "bracketright", lazy.layout.grow()),
    Key([mod], "bracketleft", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
]

groups = [
    Group(name="WWW", layout="monadtall"),
    Group(name="DEV", layout="monadtall"),
    Group(name="SYS", layout="monadtall"),
    Group(name="DOC", layout="monadtall"),
    Group(name="CHT", layout="monadtall"),
    Group(name="FUN", layout="monadtall"),
    Group(name="GFX", layout="monadtall"),
]

for (i, g) in enumerate(groups, start=1):
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], str(i), lazy.group[g.name].toscreen(),
            desc="Switch to group {}".format(g.name)),

        # # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], str(i), lazy.window.togroup(g.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(g.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

widgets_font_compressed = "Fira Sans Compressed Medium"

colors = dict(
    foreground = "#68615e",
    background = "#f1efee",
    cursorColor = "68615e",

    black = ["#1b1918", "#766e6b"],
    red = ["#f22c40", "#f22c40"],
    green = ["#5ab738", "#5ab738"],
    yellow = ["#d5911a", "#d5911a"],
    blue = ["#407ee7", "#407ee7"],
    magenta = ["#6666ea", "#6666ea"],
    cyan = ["#00ad9c", "#00ad9c"],
    white = ["#a8a19f", "#f1efee"],
)

widget_defaults = dict(
    font="Fira Sans",
    fontsize=14,
    padding=5,
    foreground=colors["foreground"]
)
extension_defaults = widget_defaults.copy()

spacer = dict(
    character="",
    size=20
)

def get_segment_connector(swap = False):
    return widget.TextBox(
               text=spacer["character"],
               padding=0,
               fontsize=spacer["size"],
               foreground=colors["blue"][0] if swap else colors["white"][1],
               background=colors["white"][1] if swap else colors["blue"][0]
           )

left_screen_widgets = [
    widget.GroupBox(
        font = widgets_font_compressed,
        padding=0,
        rounded=False,
        margin_y = 4,
        margin_x = 0,
        padding_y = 8,
        padding_x = 3,
        borderwidth = 3,
        active = colors["foreground"],
        inactive = colors["white"][0],
        this_current_screen_border = colors["blue"][1],
        highlight_method = "block",
        block_highlight_text_color = colors["background"]
    ),
    widget.Sep(
        linewidth=0,
        padding=30
    ),
    widget.WindowName(),
    get_segment_connector(True),
    widget.CurrentLayout(
        padding=5,
        fmt = "LAYOUT: {}",
        font = widgets_font_compressed,
        background=colors["blue"][0],
        foreground=colors["white"][1],
    ),
    get_segment_connector(False),
    widget.Net(
        interface = "enp34s0",
        format = '{down} ↓↑ {up}',
        foreground=colors["foreground"],
        font = widgets_font_compressed,
        padding = 3
        ),
    get_segment_connector(True),
    widget.ThermalSensor(
        fmt="GPU {}",
        tag_sensor="junction",
        background=colors["blue"][0],
        foreground=colors["white"][1],
        font=widgets_font_compressed
    ),
    widget.ThermalSensor(
        fmt="CPU {}",
        tag_sensor="Tdie",
        background=colors["blue"][0],
        foreground=colors["white"][1],
        font=widgets_font_compressed
    ),
    get_segment_connector(False),
    widget.Systray(
        background=colors["background"],
    ),
    get_segment_connector(True),
    widget.Clock(
        font="Fira Sans Bold",
        format='%A, %B %d - %H:%M',
        background=colors["blue"][0],
        foreground=colors["background"],
    )
]

right_screen_widgets = [
    widget.GroupBox(
        font = widgets_font_compressed,
        padding=0,
        rounded=False,
        margin_y = 4,
        margin_x = 0,
        padding_y = 8,
        padding_x = 3,
        borderwidth = 3,
        active = colors["foreground"],
        inactive = colors["white"][0],
        this_current_screen_border = colors["blue"][1],
        highlight_method = "block",
        block_highlight_text_color = colors["background"]
    ),
    widget.Sep(
        linewidth=0,
        padding=30
    ),
    widget.WindowName(),
    widget.CurrentLayout(
        padding=5,
        font = widgets_font_compressed,
        fmt = "LAYOUT: {}",
    ),
    get_segment_connector(True),
    widget.Clock(
        font="Fira Sans Bold",
        format='%A, %B %d - %H:%M',
        background=colors["blue"][0],
        foreground=colors["background"],
    )
]

common_bar_configs = {
    "size": 24,
    "background": colors["background"],
    "margin": [6,6,0,6]
}

screens = [
    Screen(
        top=bar.Bar(
            left_screen_widgets,
            **common_bar_configs
        ),
    ),
    Screen(
        top=bar.Bar(
            right_screen_widgets,
            **common_bar_configs
        )
    )
]

common_layout_defaults = {
    "margin": 6,
    "border_focus": colors["blue"][0],
    "border_normal": colors["background"]
}

layouts = [
    layout.MonadTall(**common_layout_defaults),
    layout.Floating(**common_layout_defaults),
    layout.Max(),
    layout.Stack(num_stacks=2, **common_layout_defaults),
    layout.MonadWide(**common_layout_defaults),
    # layout.Tile(),
    # layout.Bsp(),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    border_focus = colors["foreground"],
    border_normal = colors["background"],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {'wmclass': 'confirm'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
        {'wmclass': 'confirmreset'},  # gitk
        {'wmclass': 'makebranch'},  # gitk
        {'wmclass': 'maketag'},  # gitk
        {'wname': 'branchdialog'},  # gitk
        {'wname': 'pinentry'},  # GPG key password entry
        {'wmclass': 'ssh-askpass'},  # ssh-askpass
        {'wmclass': 'Pamac-manager'},  # pamac,
        {'wmclass': 'Pavucontrol'},  # Pavucontrol,
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])

@hook.subscribe.screen_change
def restart_on_randr(ev):
    lazy.restart()