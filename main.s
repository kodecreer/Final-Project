; Kode creer © Jun 23, 2022
; This is the main of the Choose your adventrue style type game
; It is highly reccomended you try other scenarios around the bridge.
; It gets more interesting there
global _start
;declaring needed functions from the std library
EXTERN print, getchar

section .data
;String values for the error messages used in validation
    error_y_n:
        db `Please enter either y or n. Invalid character\n`,0
    error_num:
        db `Please enter valid first character that's a digit in the range\n`,0
;A simple marker to make calculating the length of error num easier  
    marker:
    
section .text
;This contains the needed Enumerations of SysCalls to make the
;code a lot more easier to read. 
%include "io.h"
;Parameters: None
;Return Values: None
;Purpose: To display an error message when the user fails
;to enter either y or n into the console.
error_msg_y_n:
    ;print the error message
    mov eax, error_y_n
    mov ebx, error_num - error_y_n
    call print
    ret
;Parameters: None
;Return Values: None
;Purpose: To display an error message when the user fails
;to enter either a digit not in the range or a normal character
error_msg_num:
     ;print the error message
     mov eax, error_num
     mov ebx, marker - error_num
     call print
     ret
_start:
    ;Call the welcome that initiates the game
    call Welcome
    mov eax, EXIT ;exit the program
    mov ebx, 0;everything worked
    int 80h
;This is the welcome prompt that outputs a welcome message. If the user enters y
;Then the adventure starts, if they type n then the game ends and the program exits. 
;How can you start an adventure you haven't started?
welcome_msg: db `Welcome to Khazad Dum, you have been forced to come here after failing to climb Caradhras. You must escape this dungeon in order to quest towards destroy the ring of Saulron. Are you ready to embark on this great adventrue? y/n\n`,0
Welcome:
    ;print the welcome propmt
    mov eax, welcome_msg
    mov ebx, Welcome - welcome_msg
    call print
;Get the input, if it's y then go to the DungeonsWall, else if its n then exit the program.
;Otherwise have them try entering the value again
WelcomeIn:
    call getchar
    cmp al, 'y'
    jz DungeonsWall
    cmp al, 'n'
    jz Exit
    ;print an error message
    call error_msg_y_n
    jmp WelcomeIn
;This isthe dungeons wall. They have 3 choices. If they pick 1, they die. 2, they enter it again.
;If they pick 3 then they continue past the door. Otherwise it's invalid first character input and they
;have to try again
dungeons_wall_msg: db `You have are at the walls of the dungeon and hear something behind you creeping as you try to open the door. As Gandalf, you can either \n1.go and investigate the sound\n2.try to open the door\n3. ask Froto what the word might be.\nWhich one shall you take? 1-3\n`,0
DungeonsWall:
    ;print the message
    mov eax, dungeons_wall_msg
    mov ebx, DungeonsWall - dungeons_wall_msg
    call print
;get the input. Check the comments above the original Dungeon's Wall to see the results of eat
DungeonsWallIn:
    call getchar
    ;send them to Investigate the sound if the first character they enter in the line is 1
    cmp al, '1'
    jz InvesitgateSound
    ;Gandalf attempts to open the door but it just sends us here again
    cmp al, '2'
    jz OpenDoor
    ;Ask Froto for the passcode that advances us
    cmp al, '3'
    jz AskFroto
    ;print an error message and have them enter the input again
    call error_msg_num
    jmp DungeonsWallIn
;This is when they press one of the keyboard
investigate_sound_msg: db `You decide to investigate the sound and found a giant Leviathan that eats Froto and the Stupid Hobit. With the Leviathan came the ring, and so did you hope. Game over the Saulron has won. \n`,0
InvesitgateSound:
    ;Print the output then end the game
    mov eax, investigate_sound_msg
    mov ebx, InvesitgateSound - investigate_sound_msg
    call print
    jmp GameOver
;This is when you enter in the number 2 on the keyboard
open_door_msg: db `You tryed another spell or random word to open the door, but to no avail. Try again. \n`,0
OpenDoor:
    ;print the result and have them try again
    mov eax, open_door_msg
    mov ebx, OpenDoor - open_door_msg
    call print
    jmp DungeonsWallIn
;when you enter 3 on DungeonsWall
ask_froto_msg: 
    db `Frodo says its a riddle and asks Gandalf what is the elvish word for friend. Gandalf translate the word friend to elivish and opens the door. You all then enter the empty great city once occupied by dwarfs. You all enter into a room and the stupid hobbit sees a book. Do you grab it or not? y/n\n`,0
AskFroto:
    ;print the result
    mov eax, ask_froto_msg
    mov ebx, AskFroto - ask_froto_msg
    call print
;Have the user choose between either having a small fight like the movie, or skip the scene entirely
;if they press n
AskFrotoIn:
    call getchar
    cmp al, 'y'
    jz OrcsAttack
    cmp al, 'n'
    jz NoPickUpBook
    ;print error message
    call error_msg_y_n
    jmp AskFrotoIn
;This is the when the person pressed y
;The orcs have attacked
orcs_attack_msg: db `The stupid hobit grabs the book and with him being clumsy, dropped it into a deep whole on accident. His brother calls him an idiot. You hear the sound of an impending army of orcs coming after an arrow hits the door. You all brace to fight for you lives.\n`,0
orcs_attack_msg2: db `Borimor then says that there is a cave troll and you all block the door. It is barracaded and immedietly bursted open by the cave troll.\n`,0
orcs_attack_msg3: db `The troll attacks the hobbits and splits them up after taking a couple of arrows. It then takes a liking to Froto and ignores everybody else. Do you Aragon attempt to defend Froto? y/n\n`,0
OrcsAttack:
    ;print the output
    mov eax, orcs_attack_msg
    mov ebx, orcs_attack_msg2 - orcs_attack_msg
    call print
    mov eax, orcs_attack_msg2
    mov ebx, orcs_attack_msg3 - orcs_attack_msg2
    call print
    mov eax, orcs_attack_msg3
    mov ebx, OrcsAttack - orcs_attack_msg3
    call print
;get the input that either gets them into more trouble or replicate the movie
OrcsAttackIn:
    call getchar
    cmp al, 'y'
    jz DefendFroto
    cmp al, 'n'
    jz NoDefendFroto
    ;print an error message and have the user try again
    call error_msg_y_n
    jmp OrcsAttackIn
;When they attempt ot defend Froto
defend_froto_msg: db `Aragon heads off to fight off the troll, but the troll slaps him. This time with some orcs aiding him. Attack the Orcs first? y/n\n`,0
DefendFroto:
    ;print the output
    mov eax, defend_froto_msg
    mov ebx, DefendFroto - defend_froto_msg
    call print
DefendFrotoIn:
    call getchar
    cmp al, 'y'
    jz NoDefendFroto
    cmp al, 'n'
    jz TrollFirst
    ;print error message and have them try again
    call error_msg_y_n
    jmp DefendFrotoIn
;When they presss n and this is an ending to the game
troll_first_msg: db `You kill the troll, but one of the orcs grabs Froto and steals his ring. Saulron has won\n`,0
TrollFirst:
    ;print the output and end the game
    mov eax, troll_first_msg
    mov ebx, TrollFirst - troll_first_msg
    call print
    jmp GameOver
;When you select n and don't defend Froto like the movie
no_defend_froto: db `The cave troll closes in of Froto and stabs him. He doesn't die. This enrages the crew and you all together must fight the cave troll together now!!!! Battle Begin!!!!\n`,0
NoDefendFroto:
    ;print the output
    mov eax, no_defend_froto
    mov ebx, NoDefendFroto - no_defend_froto
    call print
    ;This is needed since it skips the output for some reason
    jmp CAVE_TROLL_FIGHT
;There is multiple scenarios that get you here. They have to pick a number
;between 1 and 4, otherwise the user will have to just try again.
;If they miss with the number 1 in the range, it ends the game
cave_troll_msg: db `The cave troll is resisting, pick a number between 1 to 4 possible moves.\n`,0
CAVE_TROLL_FIGHT:
    ;print the output
    mov eax, cave_troll_msg
    mov ebx, CAVE_TROLL_FIGHT - cave_troll_msg
    call print
;Pick the first digit in the line. If it's 1 or 4 they go to part 2, otherwise the game ends
CAVE_TROLL_FIGHT_In:
    call getchar
    ;sendign them to the appropiate options according to their choice
    cmp al, '1'
    jz CAVE_TROLL_FIGHT2
    cmp al, '2'
    jz TrollKillsAragon
    cmp al, '3'
    jz TrollKillsAragon
    cmp al, '4'
    jz CAVE_TROLL_FIGHT2
    ;print error message and have the player try again
    call error_msg_num
    jmp CAVE_TROLL_FIGHT_In
;When they picked the wrong number and the game ends
troll_kills_aragon_msg: db `Aragon gets dragged in by the Troll and the Cave Troll kills him. Later at the final battle, Gondor gets overun without the undead army\n`,0
TrollKillsAragon:
    ;print the output and end the game
    mov eax, troll_kills_aragon_msg
    mov ebx, TrollKillsAragon - troll_kills_aragon_msg
    call print
    jmp GameOver
;If they picked a succesful number, they now need to pick another number which is 0 or 3. Otherwise it will be unsuccesful and you have to try to hit another spot.
cave_troll_msg2: db `You all gang up together and surrounded the cave troll. He is very angry. Legolas climbs on top of him and has to shoot him. Pick between a number between 0 and 3 that will determine the spot he gets hit.\n`,0
CAVE_TROLL_FIGHT2:
    mov eax, cave_troll_msg2
    mov ebx, CAVE_TROLL_FIGHT2 - cave_troll_msg2
    call print
CAVE_TROLL_FIGHT2_IN:
    call getchar
    ;send them to the apporpiate result according to the character they chose
    cmp al, '0'
    jz TrollDefeated
    cmp al, '1'
    jz CAVE_TROLL_FIGHT2
    cmp al, '2'
    jz CAVE_TROLL_FIGHT2
    cmp al, '3'
    jz TrollDefeated
    ;print error message and have the user try agin
    call error_msg_num
    jmp CAVE_TROLL_FIGHT2_IN
;This is what happens when they choose not to pick up the book
no_pick_book_msg: db `You were wise and didn't pick up the book. You all leave the doors and head towards the grand hall. You then look up and noticed an large darkness creeping in. You see a horde of Orcs coming down\n`,0
no_pick_book_msg2: db `They have surrounded, but for some reason pause and didn't attack you yet. Do you attack first or no? y/n\n`,0
NoPickUpBook:
    ;print the output of all teh messages
    mov eax, no_pick_book_msg
    mov ebx, no_pick_book_msg2 - no_pick_book_msg
    call print
    mov eax, no_pick_book_msg2
    mov ebx, NoPickUpBook - no_pick_book_msg2
    call print
;get the input
NoPickUpBookIn:
    call getchar
    ;If they pick yes then the game ends 
    cmp al, 'y'
    jz ORC_SWARM_FIGHT
    ;Otherwise the Balrog arrives and scares them away
    cmp al, 'n'
    jz BalrogArrives
    ;Print and error message and have the user try again
    call error_msg_y_n
    jmp NoPickUpBookIn
;This is when the troll is defeated. They have practically the same situation as the when they
;don't pick up the book except they just have a different propmt
troll_defeated_msg: db `You adjusted the bow accurately and hit the cave troll in the head. He then falls down with his final breath. You all leave the doors and head towards the grand hall. You then look up and noticed an large darkness creeping in. You see a horde of Orcs coming down\n`,0
troll_defeated_msg2: db `They have surrounded, but for some reason pause and didn't attack you yet. Do you attack first or no? y/n\n`,0
TrollDefeated:
    mov eax, troll_defeated_msg
    mov ebx, troll_defeated_msg2 - troll_defeated_msg
    call print
    mov eax, troll_defeated_msg2
    mov ebx, TrollDefeated - troll_defeated_msg2
    call print
    ;Because the results they enter the same as not picking up the book, 
    ;we just send them to the same input handler as not picking up the book
    jmp NoPickUpBookIn

;When they choose to fight the swarm in the hall. They die and the game ends
orc_swarm_fight_msg: db `You go in and attack, but their numbers are too large and the whole crew is slain by orcs. Saulron wins!!!\n`,0
ORC_SWARM_FIGHT:
    ;print the output and finish the game
    mov eax, orc_swarm_fight_msg
    mov ebx, ORC_SWARM_FIGHT - orc_swarm_fight_msg
    call print
    jmp GameOver

;Just like the movie the Balrog arrives and the orcs flee. You can either run or don't. 
balrog_arrives_msg: db `You were wise and you hear a loud thud. The orcs hear it and see the hue of flames at the end of the hall\n`,0
balrog_arrives_msg2: db `They were sorely afraid and cower in fear. After Ghimli makes fun of them, you all wonder what cuased them to run.\n`,0
balrog_arrives_msg3: db `You then come to find out that there is a huge black horned humanoid monster with a flame body come in.\n`,0
balrog_arrives_msg4: db `It is the Balrog. An evil monster responsible for many evil. Do you run? y/n\n`,0
BalrogArrives:
    ;print the output
    mov eax, balrog_arrives_msg
    mov ebx, balrog_arrives_msg2 - balrog_arrives_msg
    call print
    mov eax, balrog_arrives_msg2
    mov ebx, balrog_arrives_msg3 - balrog_arrives_msg2
    call print
    mov eax, balrog_arrives_msg3
    mov ebx, balrog_arrives_msg4 - balrog_arrives_msg3
    call print
    mov eax, balrog_arrives_msg4
    mov ebx, BalrogArrives - balrog_arrives_msg4
    call print
;get the input
BalrogArrivesIn:
    ;send them to the appropiate scence according to the choice
    ;y doesn't lead to death
    call getchar
    cmp al, 'y'
    jz EscapeBalrog
    ;This leads to death
    cmp al, 'n'
    jz FightBalrogHall
    ;print error message and have the user try again
    call error_msg_y_n
    jmp BalrogArrivesIn

;This is when they enter the huge stair case and an orc starts shooting at him
escape_balrog_msg: db `You all enter into a gloomy room with a broken stair case surronded by an flaming cloud that seems to fall endlessly. Most of the party makes it across. Froto and Aragon are about to jump.\n`,0
escape_balrog_msg2: db `You then barely dodge an error to the face and you notice orcs targeting Froto. As Legolas, do you shoot them back? y/n\n`,0
EscapeBalrog:
    ;print the output 
    mov eax, escape_balrog_msg
    mov ebx, escape_balrog_msg2 - escape_balrog_msg
    call print
    mov eax, escape_balrog_msg2
    mov ebx, EscapeBalrog - escape_balrog_msg2
    call print
;get the input
EscapeBalrogIn:
    call getchar
    ;This leads to life
    cmp al, 'y'
    jz BridgeTilt
    ;This leads to teh game ending
    cmp al, 'n'
    jz FrotoShootByOrc
    ;print error message and have the user try again
    call error_msg_y_n
    jmp EscapeBalrogIn
;This is when the bridge tilts, just like the scene in the movie
bridge_tilt: db `Balrog peaks through and slashes the leg of the staircase with Aragon and Froto. It is falling backward. Will you jump? y/n\n`,0
BridgeTilt:
    ;print the propmt
    mov eax, bridge_tilt
    mov ebx, BridgeTilt - bridge_tilt
    call print
;get the intput
BridgeTiltIn:
    call getchar
    ;This leads to death
    cmp al, 'y'
    jz DeathByStairs
    ;This leads to survival
    cmp al, 'n'
    jz JumpedBridge
    ;print error message and have the user try agian
    call error_msg_y_n
    jmp BridgeTiltIn
;When they make a wrong choice and the game ends
death_by_stairs_msg: db `You all act short sighted and the isolated bridge with Froto clashes with the wall near the Balrog. Aragon dodges the Balrogs slash, but both him and Froto fall to their everlast misery. Saulron wins\n`,0
DeathByStairs:
    ;print the output and end the game
    mov eax, death_by_stairs_msg
    mov ebx, DeathByStairs - death_by_stairs_msg
    call print
    jmp GameOver
;This is when the succesfully jump the bridge. This is where multiple wins are possible according to what you choose
jumped_bridge_msg: db `Aragon realizes that he can just tilt the bridge after doing nothing. He carry's Froto and goes to the end of the bridge.\n`,0
jumped_bridge_msg2: db `The moment the loud collison of the two stair cases. Aragon jumps and barely makes  it on there.\n`,0
jumped_bridge_msg3: db `You all would love to celebrate, but you notice the Balrog coming through.\n`,0
jumped_bridge_msg4: db `You can either run or fight. Will you run? y/n\n`,0
JumpedBridge:
    ;print the output
    mov eax, jumped_bridge_msg
    mov ebx, jumped_bridge_msg2 - jumped_bridge_msg
    call print
    mov eax, jumped_bridge_msg2
    mov ebx, jumped_bridge_msg3 - jumped_bridge_msg2
    call print
    mov eax, jumped_bridge_msg3
    mov ebx, jumped_bridge_msg4 - jumped_bridge_msg3
    call print
    mov eax, jumped_bridge_msg4
    mov ebx, JumpedBridge - jumped_bridge_msg4
    call print
JumpedBridgeIn:
    call getchar
    ;Send them to the last stand scene just like the movie
    cmp al, 'y'
    jz BalrogsLastStand
    ;This is more complicated and leads to multiple options
    cmp al, 'n'
    jz FightBalrogBridge
    ;print error message and have the user try again
    call error_msg_y_n
    jmp JumpedBridgeIn

balrog_last_stand_msg: db `You all escape, but Gandalf realizes that the Balrog must pay for the evil he has done. He tells the crew to leave. Will you listen? y/n\n`,0
BalrogsLastStand:
    mov eax, balrog_last_stand_msg
    mov ebx, BalrogsLastStand - balrog_last_stand_msg
    call print
BalrogsLastStandIn:
    call getchar
    cmp al, 'y'
    jz MovieEnding
    cmp al, 'n'
    jz BalrogWin
    call error_msg_y_n
    jmp BalrogsLastStandIn
movie_ending_msg: db `Gandalf yells you shall not pass and breaks the final bridge. This sends the Balrog down into a bottomless pit. Press Enter or Enter with any character to continue\n`,0
movie_ending_msg2: db `As Gandalf walks away triumphantly, the Balrog uses his whipped to drag Gandalf down with him onto the ledge. Froto runs to his aid.\n`,0
movie_ending_msg3: db `However Gandalf silently utters, Run you fools. He then loses his grip on the ledge and follows the Balrog down to the ledge. You all escape, and have survived Khazad Dum.\n`,0
MovieEnding:
    mov eax, movie_ending_msg
    mov ebx, movie_ending_msg2 - movie_ending_msg
    call print
    call getchar
    mov eax, movie_ending_msg2
    mov ebx, movie_ending_msg3 - movie_ending_msg2
    call print
    mov eax, movie_ending_msg3
    mov ebx, MovieEnding - movie_ending_msg3
    call print
    jmp Victory
balrog_win_msg: db `Gandalf slips on the shaking tremor and the Balrog kills the crew with his whip. Saulron wins.\n`,0
BalrogWin:
    mov eax, balrog_win_msg
    mov ebx, BalrogWin - balrog_win_msg
    call print
    jmp GameOver
;You have to choice to make the same you shall not pass
;If it doesn't go then they are forced to fight him outside
;Froto is seperate from the crew
froto_shoot_by_orc_msg: db `You ignored these pests and one gets lucky and struck Froto right into the chest. His knees hit the ground and falls into endless ominous bottom. Saulron wins\n`,0
FrotoShootByOrc:
    mov eax, froto_shoot_by_orc_msg
    mov ebx, FrotoShootByOrc - froto_shoot_by_orc_msg
    call print
    jmp GameOver
;Froto dies, game over
;FIX OUTPUT ERROR
fight_balrog_bridge_msg: db `You decide to finish him out. You have 3 options\n`,0
fight_balrog_bridge_msg2: db `1.You try to send him away into another dimension\n`,0
fight_balrog_bridge_msg3: db `2.You transport with him to a mountain\n`,0
fight_balrog_bridge_msg4: db `3.You use the ring of power to ward him off\n`,0
FightBalrogBridge:
;success but gandalf fights it out to balrog
    ;pritn the outpu
    mov eax, fight_balrog_bridge_msg
    mov ebx, fight_balrog_bridge_msg2 - fight_balrog_bridge_msg
    call print
    mov eax, fight_balrog_bridge_msg2
    mov ebx, fight_balrog_bridge_msg3 - fight_balrog_bridge_msg2
    call print
    mov eax, fight_balrog_bridge_msg3
    mov ebx, fight_balrog_bridge_msg4 - fight_balrog_bridge_msg3
    call print
    mov eax, fight_balrog_bridge_msg4
    mov ebx, FightBalrogBridge - fight_balrog_bridge_msg4
    call print
;get the input
FightBalrogBridgeIn:
    call getchar
    ;1 He has to choose a dimnesion and they all die
    cmp al, '1'
    jz SendBalrogToDimension
    ;2 He transport him to the top of the mountain and they fight it out and win the game
    cmp al, '2'
    jz BalrogToMountain
    ;3 He eats Froto and the game ends
    cmp al, '3'
    jz BalrogEatsFroto
    ;print error message and have the user try again
    jmp FightBalrogBridgeIn

;scene when you send balrog to another dimension
send_balrog_to_dimension_msg: db `You send him to a new dimension, but it in turn summons poisonous smog that kills the entire crew\n`,0
SendBalrogToDimension:
    ;print the output and end the game
    mov eax, send_balrog_to_dimension_msg
    mov ebx, SendBalrogToDimension - send_balrog_to_dimension_msg
    call print
    jmp GameOver
;This is when you pick 1 and send The Balrog to the mountain
balrog_to_mountain_msg: db `Gandalf transports the Balrog to a mountain and fights it out with the Balrog. After killing him, he peacefully lookings into the snowy sky as he takes his final breaths.\n`,0
balrog_to_mountain_msg2: db `The rest of the crew manages to escape Khazad Dum, you have succeded and have won the game\n`,0
BalrogToMountain:
    ;print the output and end the game with a win
    mov eax, balrog_to_mountain_msg
    mov ebx, balrog_to_mountain_msg2 - balrog_to_mountain_msg
    call print
    mov eax, balrog_to_mountain_msg
    mov ebx, BalrogToMountain - balrog_to_mountain_msg2
    call print
    jmp Victory
;This is when the Balrog eats Froto
balrog_eats_froto_msg: db `Froto attemps to use the ring of power to help the crew leave the Balrog, but alas the ring betrayed Froto. The Balrog sees Froto and eats him. Salroun has won\n`,0
BalrogEatsFroto:
    ;print the output and end the game
    mov eax, balrog_eats_froto_msg
    mov ebx, BalrogEatsFroto - balrog_eats_froto_msg
    call print
    jmp GameOver
;This is when you fight the balrog in the hall. This instantly ends the game
figth_balrog_hall_msg: db `You attempt to fight him in the hall and the whole party is engulfed in flames. Gandalf narrowly defeats him, but lays dead on the ground with the rest of the crew. Eventually Saulron gets the ring from Gandalf the white and the land is enslaved by Saulron's hand\n`,0
FightBalrogHall:
    ;print the output and end the game
    mov eax, figth_balrog_hall_msg
    mov ebx, FightBalrogHall - figth_balrog_hall_msg
    call print
    jmp GameOver
;This is the game over prompt
;This ends the game 
game_over_msg: db `Game over and Saulron has won and enslaved Middle Earth\n`,0
GameOver:
    ;print the output and end the game
    mov eax, game_over_msg
    mov ebx, GameOver - game_over_msg
    call print
    ;exit the program
    call Exit
;This is when you win the game
victory_msg: db `You have enacted justice and have survived the Balrog. May you all destroy root of all evil in that ring.\n`,0
victory_msg2: db `Do you want to play again? y/n\n`,0
Victory:
    ;print the ouptut
    mov eax, victory_msg
    mov ebx, victory_msg2 - victory_msg
    call print
    mov eax, victory_msg2
    mov ebx, Victory - victory_msg2
    call print
;Give the user a chance to play the game again if they want because they are winners.
VictoryIn:
    call getchar
    cmp al, 'y'
    jz Welcome
    cmp al, 'n'
    jz Exit
    ;print error message and hvae the user try again
    jmp VictoryIn
;This is simple, it exits the program.
Exit:
    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h
    ;repeat until either the player dies or the enemy dies