global _start
EXTERN getn, generate_random_num, printn, print, getchar
;TODO Wedsnday
;Fill in other Scenarios until gandalf and Belrog fight
;Test program and make sure it doesn't break by the time of class tommorow
;Finish and test up to cave troll fight
;Impliment validation for numbers
section .data
    nl:
        db `\n`,0
    lnl equ $ - nl
    x: 
      dd 0
    health:
      dd 12
    cave_troll_health:
        dd 25
    orc_horde_health:
        dd 20
    orc_monster_house_health:
        dd 50
    balrog_health:
        dd 100
    ehealth:
        dd 0
    eattack:
        dd 0
    
section .text
;%include "std.s"
%include "io.h"
outnl:
    mov eax, nl
    mov ebx, lnl
    call print
    ret
_start:
    ;reference
    ; call getn
    ; mov ebx, 2
    ; call printn
    ; mov dword [x], ecx
    ; call outnl
    ; mov ecx, 10
    ; call generate_random_num
    ; mov ebx,2
    ; call printn
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
    ;jz 
    cmp al, 'n'
    jz NoDefendFroto
    ;print an error message
    jmp OrcsAttackIn
no_defend_froto: db `The cave troll closes in of Froto and stabs him. This enrages the crew and you all together must fight the cave troll together now!!!! Battle Begin!!!!\n`,0
NoDefendFroto:
    mov eax, no_defend_froto
    mov ebx, NoDefendFroto - no_defend_froto
    call print
CAVE_TROLL_FIGHT:
    mov eax, dword[cave_troll_health]
    mov dword[ehealth], eax
    mov dword[eattack], 4
    call BattleRNG
    ;if the player health is greater than zero
    ;Then enter into the scenario
no_pick_book_msg: db `You were wise and didn't pick up the book. You all leave the doors and head towards the grand hall. You then look up and noticed an large darkness creeping in. You see a horde of Orcs coming down\n`,0
no_pick_book_msg2: db `They have surrounded, but for some reason pause and didn't attack you yet. Do you attack first or no? y/n\n`,0
NoPickUpBook:
    mov eax, no_pick_book_msg
    mov ebx, no_pick_book_msg2 - no_pick_book_msg
    call print
    mov eax, no_pick_book_msg2
    mov ebx, NoPickUpBook - no_pick_book_msg2
    call print
ORC_SWARM_FIGHT:
    ;To implement later
    ret
;TODO implent the combat system of the game
;Parameters
rng_prompt: db `Enter in a guess between 0 and 9\n`,0
BattleRNG:
    mov eax, rng_prompt
    mov ebx, BattleRNG - rng_prompt
    call print
    call getn
    ;don't accept negative numbers
    ;get the difference between the guess and the rng number
    mov edx, [x]
    mov ecx, 10 ;player max guess range is 10
    call generate_random_num
    mov dword [x], ecx
    sub eax, ecx
    ;if it's within 2, inflict 1 damage
    push ebx
    cmp eax, 2
    mov ebx, 1
    jz pdamage
    cmp eax, -2
    mov ebx, 1
    jz pdamage
    ;if it's within 1, inflict 3 damag
    cmp eax, 1
    mov ebx, 3
    jz pdamage
    cmp eax, -1
    jz pdamage
    ;if it's within 0, inflict 10 damage
    cmp eax, 0
    mov ebx, 10
    jz pdamage10
    pop ebx

    ;else don't do any damage at all
    ;run an rng for the enemy
    mov edx, dword[x]
     ;inflict the damage roled between the 1 and the damage max cap set for the enemy
    mov ecx, dword[eattack]
    ;TODO implent ranged damage for enemies
    call generate_random_num
    mov dword[x], ecx
    mov ebx, dword[x]
    ;if the enemy is dead then don't call it to inflict damag
    cmp dword[ehealth],0
    jle edamage
    ; if the player is dead then game over
    cmp dword[health],0
    jle GameOver
    ;if the enemy is not dead go start this again
    cmp dword[ehealth],0
    jg BattleRNG
    ret

GameOver:
    call Exit
Exit:
    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h
    ;repeat until either the player dies or the enemy dies
pdamage:
    push ecx
    mov ecx, dword[ehealth]
    sub ecx, ebx
    mov dword[ehealth], ebx
    pop ecx
    ret

edamage:
    push ecx
    mov ecx, dword[health]
    sub ecx, ebx
    mov dword[health], ebx
    pop ecx
    ret