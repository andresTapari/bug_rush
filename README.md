# Bug Rush

![Game Play](https://github.com/andresTapari/bug_rush/blob/main/img/RNAvdG.png)
Video Game for [Game Off 2021](https://itch.io/jam/game-off-2021) jam, in itch.io . 

## About
It's a strategy game, mix with rush type games and management. It was made in Godot and Blender. It is our first Game Jam and it's my first published game, so it't might be a bit bugy but it's fine, we did it for fun.

## Images:
![Title Screen](https://github.com/andresTapari/bug_rush/blob/main/img/XVBRE3.png)

![Lvl_Selection](https://github.com/andresTapari/bug_rush/blob/main/img/owQpcQ.png)
![Game Play 2](https://github.com/andresTapari/bug_rush/blob/main/img/_tSYwX.png)

## Data Structure:
This game works storing all the game data in 6 singletons. A singleton in Godot is a global node at the same level of our current scene, changin this scenes does not affect singletons.

![DataStructer](https://github.com/andresTapari/bug_rush/blob/main/img/data_structure.png)

### UNITS_STATS:
Storage the information of all the units in game, when the game load, each unit take their parameters from here. If you want to change or add more type of units, this units should be defined here.

### LVL_MASTER:
Storage data about the player, like current level unlocked, or amount of coins left. Also keeps a track of played levels, score and coins earned in each one, you can see this data in level selection or while playing the levels.

### SOUND_FX:
Some sounds effects like buttons or the music is played by an instanced AudioStreamPlayer, that load when the game start. It's totally defined trough script.

### SETUP:
Configuration like full screen, mute sounds or music, and hide help comments, are stored here.

### HELP:
All the subtitles and functions are defined here, so they can be called anywhere in the scripts.

### The current lvl:
Then all the process about what happend while playing the game are managed with the current scene (in this case dev_lvl_1), all levels use the same script, like mostly units. We thought it was properly because the behaviour are almoust the same.

![level_structure](https://github.com/andresTapari/bug_rush/blob/main/img/lvl_structure.png?raw=true)

All the levels has the same structure, the lightblue box are the player related nodes, it's means that the player interract with them. The red box are the enemys, if yout want to have more of them you can duplicate them or add to the scene tree (when the level start they are loaded autoatically by the level and the player), and the green one are little decorations we add (this is our less outstanding part of the proyect, but we liked it anyway).

## KNOWN BUGS:
This are some bugs we know the game have but didn't had the time to fix them:
* Progress bar tells you "winner" when you dont: Some times the progress bar (Level Progress) will become green, thats mean you are alowed to pass to next level when actually you don't (and you dont pass).

![meme](https://github.com/andresTapari/bug_rush/blob/main/img/meme.jpeg)

* Score dialog don't show up: Some times when you don't have any more units on the board,(lost/win condition) score dialog doesn't appear. You can ends the play with the button Stop Attack and force it to show, but it shoudn't be this way.

