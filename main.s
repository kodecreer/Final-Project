; Kode creer
global _start
EXTERN getn, generate_random_num, printn, print, getchar
;TODO Wedsnday
;Fill in other Scenarios until gandalf and Belrog fight
;Test program and make sure it doesn't break by the time of class tommorow
;Finish and test up to cave troll fight
;Impliment validation for numbers 
;new
section .data
    error_y_n:
        db `Please enter either y or n. Invalid character\n`,0

    error_num:
        db `Please enter valid first character that's a digit in the range\n`,0
    marker:
    
section .text
;%include "std.s"
%include "io.h"
error_msg_y_n:
    mov eax, error_y_n
    mov ebx, error_num - error_y_n
    call print
    ret
error_msg_num:
     mov eax, error_num
     mov ebx, marker - error_num
     call print
     ret
_start:
    call Welcome
    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h

welcome_msg: db `Welcome to Khazad Dum, you have been forced to come here after failing to climb Caradhras. You must escape this dungeon in order to quest towards destroy the ring of Saulron. Are you ready to embark on this great adventrue? y/n\n`,0
Welcome:
    mov eax, welcome_msg
    mov ebx, Welcome - welcome_msg
    call print
    call getchar
    cmp al, 'y'
    jz DungeonsWall
    cmp al, 'n'
    jz Exit
    ;print an error message
    call error_msg_y_n
    jmp Welcome
dungeons_wall_msg: db `You have are at the walls of the dungeon and hear something behind you creeping as you try to open the door. As Gandalf, you can either \n1.go and investigate the sound\n2.try to open the door\n3. ask Froto what the word might be.\nWhich one shall you take? 1-3\n`,0
DungeonsWall:
    mov eax, dungeons_wall_msg
    mov ebx, DungeonsWall - dungeons_wall_msg
    call print
DungeonsWallIn:
    call getchar
    cmp eax, '1'
    jz InvesitgateSound
    cmp eax, '2'
    jz OpenDoor
    cmp eax, '3'
    jz AskFroto
    ;print an error message
    call error_msg_num
    jmp DungeonsWallIn
;This is when they press one of the keyboard
investigate_sound_msg: db `You decide to investigate the sound and found a giant Leviathan that eats Froto and the Stupid Hobit. With the Leviathan came the ring, and so did you hope. Game over the Saulron has won. \n`,0
InvesitgateSound:
    mov eax, investigate_sound_msg
    mov ebx, InvesitgateSound - investigate_sound_msg
    call print
    jmp GameOver
;This is when you enter in the number 2 on the keyboard
open_door_msg: db `You tryed another spell or random word to open the door, but to no avail. Try again. \n`,0
OpenDoor:
    mov eax, open_door_msg
    mov ebx, OpenDoor - open_door_msg
    call print
    jmp DungeonsWall
;when you enter 3 on DungeonsWall
ask_froto_msg: 
    db `Frodo says its a riddle and asks Gandalf what is the elvish word for friend. Gandalf translate the word friend to elivish and opens the door. You all then enter the empty great city once occupied by dwarfs. You all enter into a room and the stupid hobbit sees a book. Do you grab it or not? y/n\n`,0
AskFroto:
    mov eax, ask_froto_msg
    mov ebx, AskFroto - ask_froto_msg
    call print
AskFrotoIn:
    call getchar
    cmp al, 'y'
    jz OrcsAttack
    cmp al, 'n'
    jz NoPickUpBook
    ;print error message
    call error_msg_y_n
    jmp AskFrotoIn
orcs_attack_msg: db `The stupid hobit grabs the book and with him being clumsy, dropped it into a deep whole on accident. His brother calls him an idiot. You hear the sound of an impending army of orcs coming after an arrow hits the door. You all brace to fight for you lives.\n`,0
orcs_attack_msg2: db `Borimor then says that there is a cave troll and you all block the door. It is barracaded and immedietly bursted open by the cave troll.\n`,0
orcs_attack_msg3: db `The troll attacks the hobbits and splits them up after taking a couple of arrows. It then takes a liking to Froto and ignores everybody else. Do you Aragon attempt to defend Froto? y/n\n`,0
OrcsAttack:
    mov eax, orcs_attack_msg
    mov ebx, orcs_attack_msg2 - orcs_attack_msg
    call print
    mov eax, orcs_attack_msg2
    mov ebx, orcs_attack_msg3 - orcs_attack_msg2
    call print
    mov eax, orcs_attack_msg3
    mov ebx, OrcsAttack - orcs_attack_msg3
    call print
OrcsAttackIn:
    call getchar
    cmp al, 'y'
    jz DefendFroto
    cmp al, 'n'
    jz NoDefendFroto
    ;print an error message
    call error_msg_y_n
    jmp OrcsAttackIn
defend_froto_msg: db `Aragon heads off to fight off the troll, but the troll slaps him. This time with some orcs aiding him. Attack the Orcs first? y/n\n`,0
DefendFroto:
    mov eax, defend_froto_msg
    mov ebx, DefendFroto - defend_froto_msg
    call print
DefendFrotoIn:
    call getchar
    cmp al, 'y'
    jz NoDefendFroto
    cmp al, 'n'
    jz TrollFirst
    ;print error message
    call error_msg_y_n
    jmp DefendFrotoIn
troll_first_msg: db `You kill the troll, but one of the orcs grabs Froto and steals his ring. Saulron has won\n`,0
TrollFirst:
    mov eax, troll_first_msg
    mov ebx, TrollFirst - troll_first_msg
    call print
    jmp GameOver
no_defend_froto: db `The cave troll closes in of Froto and stabs him. This enrages the crew and you all together must fight the cave troll together now!!!! Battle Begin!!!!\n`,0
NoDefendFroto:
    mov eax, no_defend_froto
    mov ebx, NoDefendFroto - no_defend_froto
    call print
cave_troll_msg: db `The cave troll is resisting, pick a number between 1 to 4 possible moves.\n`,0
CAVE_TROLL_FIGHT:
    mov eax, cave_troll_msg
    mov ebx, CAVE_TROLL_FIGHT - cave_troll_msg
    call print
CAVE_TROLL_FIGHT_In:
    call getchar
    cmp eax, '1';TODO make it a random number to be guessed
    jz CAVE_TROLL_FIGHT2
    jg TrollKillsAragon
    ;print error message
    call error_msg_num
    jmp CAVE_TROLL_FIGHT_In
troll_kills_aragon_msg: db `Aragon gets dragged in by the Troll and the Cave Troll kills him. Later at the final battle, Gondor gets overun without the undead army\n`,0
TrollKillsAragon:
    mov eax, troll_kills_aragon_msg
    mov ebx, TrollKillsAragon - troll_kills_aragon_msg
    call print
    jmp GameOver
cave_troll_msg2: db `You all gang up together and surrounded the cave troll. He is very angry. Legolas climbs on top of him and has to shoot him. Pick between a number between 0 and 9 that will determine the spot he gets hit.\n`,0
CAVE_TROLL_FIGHT2:
    mov eax, cave_troll_msg2
    mov ebx, CAVE_TROLL_FIGHT2 - cave_troll_msg2
    call print
CAVE_TROLL_FIGHT2_IN:
    call getchar
    cmp al, '6'
    jz TrollDefeated
    cmp al, '9'
    jle CAVE_TROLL_FIGHT2
    cmp al, '0'
    jge CAVE_TROLL_FIGHT2
    ;print error message
    call error_msg_num
    jmp CAVE_TROLL_FIGHT2_IN

no_pick_book_msg: db `You were wise and didn't pick up the book. You all leave the doors and head towards the grand hall. You then look up and noticed an large darkness creeping in. You see a horde of Orcs coming down\n`,0
no_pick_book_msg2: db `They have surrounded, but for some reason pause and didn't attack you yet. Do you attack first or no? y/n\n`,0
NoPickUpBook:
    mov eax, no_pick_book_msg
    mov ebx, no_pick_book_msg2 - no_pick_book_msg
    call print
    mov eax, no_pick_book_msg2
    mov ebx, NoPickUpBook - no_pick_book_msg2
    call print
NoPickUpBookIn:
    call getchar
    cmp al, 'y'
    jz ORC_SWARM_FIGHT
    cmp al, 'n'
    jz BalrogArrives
    call error_msg_y_n
    jmp NoPickUpBookIn
troll_defeated_msg: db `You adjusted the bow accurately and hit the cave troll in the head. He then falls down with his final breath. You all leave the doors and head towards the grand hall. You then look up and noticed an large darkness creeping in. You see a horde of Orcs coming down\n`,0
troll_defeated_msg2: db `They have surrounded, but for some reason pause and didn't attack you yet. Do you attack first or no? y/n\n`,0
TrollDefeated:
    mov eax, troll_defeated_msg
    mov ebx, troll_defeated_msg2 - troll_defeated_msg
    call print
    mov eax, troll_defeated_msg2
    mov ebx, TrollDefeated - troll_defeated_msg2
    call print
TrollDefeatedIn:
    call getchar
    cmp al, 'y'
    jz ORC_SWARM_FIGHT
    cmp al, 'n'
    jz BalrogArrives
    call error_msg_y_n
    jmp TrollDefeatedIn
orc_swarm_fight_msg: db `You go in and attack, but their numbers are too large and the whole crew is slain by orcs. Saulron wins!!!\n`,0
ORC_SWARM_FIGHT:
    mov eax, orc_swarm_fight_msg
    mov ebx, ORC_SWARM_FIGHT - orc_swarm_fight_msg
    call print
    jmp GameOver
balrog_arrives_msg: db `You were wise and you hear a loud thud. The orcs hear it and see the hue of flames at the end of the hall\n`,0
balrog_arrives_msg2: db `They were sorely afraid and cower in fear. After Ghimli makes fun of them, you all wonder what cuased them to run.\n`,0
balrog_arrives_msg3: db `You then come to find out that there is a huge black horned humanoid monster with a flame body come in.\n`,0
balrog_arrives_msg4: db `It is the Balrog. An evil monster responsible for many evil. Do you run? y/n\n`,0
BalrogArrives:
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
BalrogArrivesIn:
    call getchar
    cmp al, 'y'
    jz EscapeBalrog
    cmp al, 'n'
    jz FightBalrogHall
    ;print error message
    call error_msg_y_n
    jmp BalrogArrivesIn
escape_balrog_msg: db `You all enter into a gloomy room with a broken stair case surronded by an flaming cloud that seems to fall endlessly. Most of the party makes it across. Froto and Aragon are about to jump.\n`,0
escape_balrog_msg2: db `You then barely dodge an error to the face and you notice orcs targeting Froto. As Legolas, do you shoot them back? y/n\n`,0
EscapeBalrog:
    mov eax, escape_balrog_msg
    mov ebx, escape_balrog_msg2 - escape_balrog_msg
    call print
    mov eax, escape_balrog_msg2
    mov ebx, EscapeBalrog - escape_balrog_msg2
    call print
EscapeBalrogIn:
    call getchar
    cmp al, 'y'
    jz BalrogsLastStand
    cmp al, 'n'
    jz FrotoShootByOrc
    ;print error messag
    call error_msg_y_n
    jmp EscapeBalrogIn
bridge_tilt: db `Balrog peaks through and slashes the leg of the staircase with Aragon and Froto. It is falling backward. You could either jump or do nothing. y/n\n`,0
BridgeTilt:
    mov eax, bridge_tilt
    mov ebx, BridgeTilt - bridge_tilt
    call print
BridgeTiltIn:
    call getchar
    cmp al, 'y'
    jz DeathByStairs
    cmp al, 'n'
    jz JumpedBridge
    ;print error message
    call error_msg_y_n
    jmp BridgeTilt

death_by_stairs_msg: db `You all act short sighted and the isolated bridge with Froto clashes with the wall near the Balrog. Aragon dodges the Balrogs slash, but both him and Froto fall to their everlast misery. Saulron wins\n`,0
DeathByStairs:
    mov eax, death_by_stairs_msg
    mov ebx, DeathByStairs - death_by_stairs_msg
    call print
    jmp GameOver
jumped_bridge_msg: db `Aragon realizes that he can just tilt the bridge. He carry's Froto and goes to the end of the bridge.\n`,0
jumped_bridge_msg2: db `The moment the loud collison of the two stair cases. Aragon jumps and barely makes  it on there.\n`,0
jumped_bridge_msg3: db `You all would love to celebrate, but you notice the Balrog coming through.\n`,0
jumped_bridge_msg4: db `You can either run or fight. Will you run? y/n\n`,0
JumpedBridge:
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
    call getchar
    cmp al, 'y'
    jz BalrogsLastStand
    cmp al, 'n'
    jz FightBalrogHall
    ;print error message
    call error_msg_y_n
    jmp JumpedBridge
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
fight_balrog_bridge_msg: db `You decide to finish him out. You have 3 options\n`,0
fight_balrog_bridge_msg2: db `1.You try to send him away into another dimension\n2.You transport with him to a mountain\n3.You use the ring of power to ward him off\n`,0
FightBalrogBridge:
;success but gandalf fights it out to balrog
    mov eax, fight_balrog_bridge_msg
    mov ebx, fight_balrog_bridge_msg2 - fight_balrog_bridge_msg
    call print
    mov eax, fight_balrog_bridge_msg
    mov ebx, FightBalrogBridge - fight_balrog_bridge_msg2
    call print
FightBalrogBridgeIn:
    call getchar
    cmp al, '1'
    jz SendBalrogToDimension
    cmp al, '2'
    jz BalrogToMountain
    cmp al, '3'
    jz BalrogEatsFroto
    ;print error message
    jmp FightBalrogBridgeIn
;1 He has to choose a dimnesion
;1 They all die
;2 He transport him to the top of the mountain and they fight it out
;3 He eats Froto
send_balrog_to_dimension_msg: db `You send him to a new dimension, but it in turn summons poisonous smog that kills the entire crew\n`,0
SendBalrogToDimension:
    mov eax, send_balrog_to_dimension_msg
    mov ebx, SendBalrogToDimension - send_balrog_to_dimension_msg
    call print
    jmp GameOver
balrog_to_mountain_msg: db `Gandalf transports the Balrog to a mountain and fights it out with the Balrog. After killing him, he peacefully lookings into the snowy sky as he takes his final breaths.\n`,0
balrog_to_mountain_msg2: db `The rest of the crew manages to escape Khazad Dum, you have succeded and have won the game\n`,0
BalrogToMountain:
    mov eax, balrog_to_mountain_msg
    mov ebx, balrog_to_mountain_msg2 - balrog_to_mountain_msg
    call print
    mov eax, balrog_to_mountain_msg
    mov ebx, BalrogToMountain - balrog_to_mountain_msg2
    call print
    jmp Victory
balrog_eats_froto_msg: db `Froto attemps to use the ring of power to help the crew leave the Balrog, but alas the ring betrayed Froto. The Balrog sees Froto and eats him. Salroun has won\n`,0
BalrogEatsFroto:
    mov eax, balrog_eats_froto_msg
    mov ebx, BalrogEatsFroto - balrog_eats_froto_msg
    call print
    jmp GameOver
figth_balrog_hall_msg: db `You attempt to fight him in the hall and the whole party is engulfed in flames. Gandalf narrowly defeats him, but lays dead on the ground with the rest of the crew. Eventually Saulron gets the ring from Gandalf the white and the land is enslaved by Saulron's hand\n`,0
FightBalrogHall:
    mov eax, figth_balrog_hall_msg
    mov ebx, FightBalrogHall - figth_balrog_hall_msg
    call print
    jmp GameOver
game_over_msg: db `Game over and Saulron has won and enslaved Middle Earth\n`,0
GameOver:
    mov eax, game_over_msg
    mov ebx, GameOver - game_over_msg
    call print
    call Exit
victory_msg: db `You have enacted justice and have survived the Balrog. May you all destroy root of all evil in that ring.\n`,0
victory_msg2: db `Do you want to play again?\n`,0
Victory:
    mov eax, victory_msg
    mov ebx, victory_msg2 - victory_msg
    call print
    mov eax, victory_msg2
    mov ebx, Victory - victory_msg2
    call print
VictoryIn:
    call getchar
    cmp al, 'y'
    jz Welcome
    cmp al, 'n'
    jz Exit
    ;print error message
    jmp VictoryIn
Exit:
    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h
    ;repeat until either the player dies or the enemy dies