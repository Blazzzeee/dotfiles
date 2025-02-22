
from kitty.boss import Boss


def handle_result(args, answer, target_window_id, boss: Boss):
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    # Toggle between 1.0 and 0.65
    current_opacity = window.background_opacity if window.background_opacity else 1.0
    new_opacity = 1.0 if current_opacity < 1.0 else 0.65

    # Apply the new opacity
    boss.set_colors(background_opacity=new_opacity)


def main(args):
    pass

