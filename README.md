# rubygem-rpg-prompt
Ruby Gem for a RPG Combat Assistant that will handle all the time consuming game rules

With this Ruby Gem, you can handle complex RPG systems automatically, by means of 
a set of options that can be passed in a prompt. I have included a simple set of
rules of my own creation, but you may use this gem to program in Ruby your own
rules or a set of commercial rules for your personal use. I have not included any
set of commercial rules for copyright issues, even when I have programmed some for
my pesonal use.

Install the Gem, create your directory and type "rpg-prompt" to start. To start
your personal set of rules, type "clone rules {new_rules_system}" indicating the
name of your set of rules. after quitting "rpg-prompt" you will see the edittable
files that code the new set of rules. Code them in Ruby, and start using them in
your games.

In a game, first we should create a character for each player. For example:
```
>>>cc billy
```
to create a Character for player billy. Answer the questionnaire. Each character
has a {short_name} to handle it, billy in this case. Then it has a full name, an
optional nickname, a race, health points, a weapon, an armor, and a movement
capacity. In these simple rules, the race, the weapon and the movement capacity
have no effect in the game. Let us say that we create Billy the warrior, a human
who uses a broad sword and plate armor.
```
Full name => Billy
Nickname => the warrior
Race => Human
Health Points => 10
Weapon => broad sword
Armor => plate
Movement Capacity => 10
```
Then we create an enemy, Azog the white goblin, an orc who uses a mace and hardened
leather armor. He has 8 health points and a movement capacity 10.
```
>>>cf azog
```
In the pool we have 2 warriors so far.
```
>>>pool
billy: Billy the Warrior
azog: Azog the white goblin
```
You may just type "p" instead of "pool". Similarly you could have typed "createchar"
and "createfoe" instead of "cc" and "cf". Let the warriors join the combat. type
"save w billy" ("sw billy") and "save w azog" ("sw azog") to save them in files.
```
>>>join billy
>>>join azog
>>>combatstatus
billy: Billy the Warrior: 10 hp
azog: Azog the white goblin: 8 hp
```
Or just "s" to get the status of the combat, with the health points prompted. Then
combat starts with an attack from Billy the Warrior to Azog the white goblin.
```
>>>billy hits azog
¡Billy the Warrior attacks Azog the white goblin!
Press 'r' to enter a roll or any other key for a random roll.
```
You may enter the roll if you prefer to roll real dice instead of getting random
numbers from an unknown algorithm. Let us trust the random number generator to be
a fair judge of the warriors destiny.
```
>>>billy hits azog
¡Billy the Warrior attacks Azog the white goblin!
Press 'r' to enter a roll or any other key for a random roll.
Dice rolling... ¡5!
The attack succeeds!
Press 'r' to enter a roll or any other key for a random roll.
```
The attack succeeding, a new roll is needed to get the damage.
```
>>>billy hits azog
¡Billy the Warrior attacks Azog the white goblin!
Press 'r' to enter a roll or any other key for a random roll.
Dice rolling... ¡5!
The attack succeeds!
Press 'r' to enter a roll or any other key for a random roll.
Dice rolling... ¡2!
¡Azog the white goblin loses 2 hp!
```
A call to "combatstatus" prompts
```
>>>s
billy: Billy the Warrior: 10 hp
azog: Azog the white goblin: 6 hp
```
Let the cries of pain from azog attract his hench-orcs. We have to create them
before. As a generic type of enemy, it has to be created as a Spawn template.
The difference is that it may have many possible names and nicknames.
```
>>>createspawn orc
Enter names for this kind of enemy, recomended 10 or more,
  "q" to finish. Enter only the race if it is an enemy without name.
Ulag
Urglu
Shagrath
Gorbagh
Karg
Zulburg
Groggash
Skumzag
Agash
Zudak
q
Enter nicknames for this kind of enemy, recomended 10 or more,
  "q" to finish.
the Smelly
the Dumb
the Cruel
the Elfslayer
the Destroyer
the Crazy Lamb
the Poisson Razer
the Gross
the Fearless
the Hunchback
q
```
"cs orc" could have been used. They are Orcs, have 5 health points, use
scimitars and hardened leather, and they may move up to 10 meters per assault.
They join the combat by typing
```
>>>spawn orc x3
Spawning enemies: 3 of type orc

>>>s
billy: Billy the Warrior: 10 hp
azog: Azog the white goblin: 6 hp
orc1: Karg the Hunchback: 5 hp
orc2: Skumzag the Cruel: 5 hp
orc3: Zulburg the Poisson Razer: 5 hp
```
They may bring wolfs as well, the only difference is that they would not have
names, and we woould type "Wolf" for the full name. They may have nicknames,
like "alfa", "old", "defiant" or "black". Billy is in trouble, which was
expected when he was entering an orc cave alone, he should have brought allies,
like Edana the shadow queen. The warriors leave the combat when they die, or when
"leave billy" is typed.

For the next game we could prepare scenes. Let us prepare an orc_hall and a
wolf_cave. Type "lw" to list the available warriors in saved files, and
"free all" to start a pool and a combat from scratch.
```
>>>free all
>>>lw
wolf
billy
orc
edana
azog
```
Let us create the "orc_hall" scene.
```
>>>lw azog
>>>lw orc

>>>join azog
>>>spawn orc x3

>>>s
azog: Azog the white goblin: 10 hp
orc1: Agash the Gross: 5 hp
orc2: Ulag the Cruel: 5 hp
orc3: Gorbagh the Smelly: 5 hp

>>>save s orc_hall
Saving...
Scene saved.
```
Similarly, the "wolf_cave" scene.
```
>>>spawn wolf x5
Spawning enemies: 5 of type wolf

>>>s
wolf1: Wolf old: 6 hp
wolf2: Wolf beta: 6 hp
wolf3: Wolf grey: 6 hp
wolf4: Wolf alfa: 6 hp
wolf5: Wolf scarred: 6 hp

>>>ss wolf_cave
Saving...
Scene saved.
```
We have use "ss" as a short version of "save s". Let us list the save scenes
```
>>>ls
orc_hall
wolf_cave
```
The command "load s orc_hall" or "ls orc_hall" loads azog and the orc
template into the pool, and Azog the white goblin, Agash the Gross, Ulag
the Cruel and Gorbagh the Smelly into the combat.

You make quit and save the temporal pool and combat using "quit -s" or
dismiss them with "quit -q".
