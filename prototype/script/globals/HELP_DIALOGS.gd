extends Node

enum helps_dialogs {
					entering_level,
					spawner_page_1,
					spawner_focus_amount,
					spawner_focus_delay,
					spawner_focus_start_attack,
					hud_focus_coins,
					hud_focus_score,
					hud_focus_mouse_help,
					hud_focus_progress_bar,
					hud_focus_attack_btn,
					hud_focus_current_lvl,
					hud_focus_pause_menu,
					lvl_won,
					lvl_lost,
					game_over
					}
		
var dialog_1  = "[center]First click on [color=red]atack[/color] button.[/center]"
var dialog_2  = "[center]Here you can [color=green]buy[/color] different kinds of units for your army. " +\
				"[color=green]AMOUNT [/color]will set the [color=yellow]NUMBERS[/color] of units you send to attack." +\
				"[color=green] DELAY[/color] will separate the atack waves in [color=yellow]seconds[/color]."
var dialog_3  = "[center][color=green]AMOUNT [/color]will set the [color=yellow]NUMBERS[/color] of units you send to attack."
var dialog_4  = "[center][color=green]DELAY[/color] will separate the atack waves in [color=yellow]seconds[/color].[/center]"
var dialog_5  = "[center]All [color=green]UNITS[/color] and [color=yellow]COINS[/color] expended in this LVL will be lost for next one, [color=red]MANAGE YOUR RESOURCE PROPERLY[/color][/center]"
var dialog_6  = "[center]If your [color=yellow]COINS[/color] go to [color=RED] ZERO[/color] and there aren't any more [color=green]units[/color] on the board, it will be [color=red]GAME OVER[/color] and all your progress will be [color=red]LOST FOR EVER[/color]."
var dialog_7  = "[center]Your score is shown here, at the end of the LVL it will be converted to [color=yellow]COINS[/color]. ([color=green]DIFFICULTY[/color] will change the amount of [color=YELLOW]COINS[/color] earned in each LVL.)[/center]"
var dialog_8  = "[center]When this barr become full and [color=green]GREEN[/color], it means you may be able to pass to [color=red]NEXT LVL[/color].[/center]"
var dialog_9  = "[center]Use [color=green]LEFT CLICK[/color] to [color=yellow]move[/color] the camera, and the [color=green]SCROLL WHEEL[/color] to [color=yellow]ZOOM[/color] in/out or [color=green]SCROLL BUTTON[/color] to [color=yellow]rotate[/color] the view."
var dialog_10 = "[center]Prepare your [color=green]ARMY[/color]."
var dialog_11 = "[center]Your [color=green]CURRENT LVL[/color], beat the level to [color=yellow]UNLOCK[/color] the next one"
var dialog_12 = "[center]Press [color=green]'P'[/color] on your keyboard for [color=yellow]PAUSE[/color] and [color=yellow]OPTIONS[/color].[/center]"
var dialog_13 = "[center][color=green]YOU WON[/color], your current [color=red]LVL SCORE[/color] is been converted and added to your [color=yellow]COINS[/color]"
var dialog_14 = "[center][color=red]YOU LOST[/color], spent [color=yellow]COINS[/color] are [color=red]LOST[/color]."
var dialog_15 = "[center]You don't have enough [color=yellow]COINS[/color] to keep playing. Press [color=red]NEW GAME[/color] to [color=green]START OVER[/color]"

func get_dialog(_value) -> String:
	match _value:
		helps_dialogs.entering_level:
			return dialog_1
		helps_dialogs.spawner_page_1:
			return dialog_2
		helps_dialogs.spawner_focus_amount:
			return dialog_3 + dialog_4
		helps_dialogs.spawner_focus_delay:
			return dialog_4
		helps_dialogs.spawner_focus_start_attack:
			return dialog_5
		helps_dialogs.hud_focus_coins:
			return dialog_6
		helps_dialogs.hud_focus_score:
			return dialog_7
		helps_dialogs.hud_focus_progress_bar:
			return dialog_8
		helps_dialogs.hud_focus_mouse_help:
			return dialog_9
		helps_dialogs.hud_focus_attack_btn:
			return dialog_10
		helps_dialogs.hud_focus_current_lvl:
			return dialog_11 + dialog_12
		helps_dialogs.lvl_won:
			return dialog_13
		helps_dialogs.lvl_lost:
			return dialog_14
		helps_dialogs.game_over:
			return dialog_15
	return ""
