# jahnavi arora

#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################

.text

# Part 1
init_list:
li $t0, 0
sw $t0, 0($a0)
sw $t0, 4($a0)

jr $ra


# Part 2
append:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)

move $s0, $a0 #list
move $s1, $a1 #num

lw $s2, 0($s0) #size
lw $s3, 4($s0) #address of list's head
beqz $s3, create_space_pt2
append_loop_pt2:
 lw $t0, 4($s3)
 beqz $t0, create_space_pt2
 move $s3, $t0
 j append_loop_pt2

create_space_pt2:
 li $a0, 8
 li $v0, 9
 syscall #v0 is the new address
 bnez $s3, adding_num_toback
 move $s3, $s0
 adding_num_toback:
 sw $v0, 4($s3)
 sw $s1, 0($v0)
 li $t0, 0
 sw $t0, 4($v0)
 #changing size
 addi $s2, $s2, 1
 sw $s2, 0($s0)
 move $v0, $s2
 
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

# Part 3
insert:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0 #list
move $s1, $a1 #num
move $s2, $a2 #index
lw $s3, 0($s0) #size
bltz $s2, invalid_input_pt3
bgt $s2, $s3, invalid_input_pt3

beqz $s3, calling_append #loading into empty list
beq $s2, $s3, calling_append #loading at end

#loading into middle
li $t0, 0
lw $s4, 4($s0) #address oh head
loading_in_middle: 
  lw $t1, 4($s4)
  addi $t0, $t0, 1
  beq $t0, $s2, index_in_t1 #address of where the index is
  move $s4, $t1
  j loading_in_middle

index_in_t1:
 li $a0, 8
 li $v0, 9
 syscall #v0 is the new address
 lw $t0, 4($s4)
 sw $t0, 4($v0)
 sw $v0, 4($s4)
 sw $s1, 0($v0)
 #changing size
 addi $s3, $s3, 1
 sw $s3, 0($s0)
 move $v0, $s3
 j pt3end
 
calling_append:
jal append
j pt3end

invalid_input_pt3:
 li $v0, -1

pt3end:
lw $ra, 0($sp)
addi $sp, $sp, 4
lw $s4, 0($sp)
addi $sp, $sp, 4
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

 jr $ra

# Part 4
get_value:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)

move $s0, $a0 #list
move $s1, $a1 #index
lw $s2, 0($s0) #size 
beqz $s2, invalid_input_pt4
bltz $s1, invalid_input_pt4
bge $s1, $s2, invalid_input_pt4

lw $s3, 4($s0) #address of head node
li $t0, 0 
loop_getting_val: 
 beq $t0, $s1, address_found_pt4
 lw $t1, 4($s3)
 move $s3, $t1
 addi $t0, $t0, 1
 j loop_getting_val
 
address_found_pt4:
 li $v0, 0
 lw $v1, 0($s3)
 j pt4end

invalid_input_pt4:
 li $v0, -1
 li $v1, -1

pt4end: 
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4
jr $ra

# Part 5
set_value:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4

move $s0, $a0 #list
move $s1, $a1 #index
move $s2, $a2 #num

lw $s3, 0($s0) #size
beqz $s3, invalid_input_pt5
bltz $s1, invalid_input_pt5
bge $s1, $s3, invalid_input_pt5

li $t0, 0
lw $s4, 4($s0) #address of head
loop_to_index:
 beq $t0, $s1, index_found_pt5
 lw $t1, 4($s4)
 move $s4, $t1   
 addi $t0, $t0, 1
 j loop_to_index
index_found_pt5:
 li $v0, 0
 lw $v1, 0($s4)
 sw $s2, 0($s4)
 j pt5end
 
invalid_input_pt5:
 li $v0, -1
 li $v1, -1
 
pt5end:
lw $s4, 0($sp)
addi $sp, $sp, 4
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4
 jr $ra

# Part 6
index_of:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)

move $s0, $a0 #list
move $s1, $a1 #num
lw $s2, 0($s0) #size
beqz $s2, invalid_input_pt6

li $s3, 0 #counter (index)
lw $s4, 4($s0) #address of head
retrieving_number_index:
 lw $t0, 0($s4)
 beq $t0, $s1, index_found_pt6
 lw $t0, 4($s4)
 move $s4, $t0
 addi $s3, $s3, 1
 bge $s3, $s2, invalid_input_pt6
 j retrieving_number_index

index_found_pt6:
 move $v0, $s3
 j pt6end
 
invalid_input_pt6:
 li $v0, -1

pt6end:
lw $s4, 0($sp)
addi $sp, $sp, 4
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

# Part 7
remove:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $s5, 0($sp)

move $s0, $a0 #list
move $s1, $a1 #num
lw $s2, 0($s0) #size
beqz $s2, invalid_input_pt7

li $s3, 0 #counter (index)
move $s5, $s0
lw $s4, 4($s0) #address of head
getting_to_number:
 lw $t0, 0($s4)
 beq $t0, $s1, index_found_pt7
 lw $t0, 4($s4)
 move $s5, $s4
 move $s4, $t0
 addi $s3, $s3, 1
 bge $s3, $s2, invalid_input_pt7
 j getting_to_number
index_found_pt7:
 lw $t0, 4($s4) #address
 sw $t0, 4($s5)
 li $v0, 0 
 move $v1, $s3
 addi $s2, $s2, -1
 sw $s2, 0($s0)
 j pt7end

invalid_input_pt7:
 li $v0, -1
 li $v1, -1

pt7end:
lw $s5, 0($sp)
addi $sp, $sp, 4
lw $s4, 0($sp)
addi $sp, $sp, 4
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

# Part 8
create_deck:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

li $a0, 8
li $v0, 9
syscall #v0 is the new address
move $s2, $v0 #address of IntArray List 

move $a0, $s2
jal init_list

li $s1, 68 #ascii val of D
li $t9, 50 #ascii val of 2
li $t8, 2 #counter
deckofcards_loop:
 li $t0, 10
 blt $t8, $t0, inserting_cards
 beq $t8, $t0, ten
 li $t0, 11
 beq $t8, $t0, jack
 li $t0, 12
 beq $t8, $t0, queen
 li $t0, 13
 beq $t8, $t0, king
 li $t0, 14
 beq $t8, $t0, ace
 ace:
  li $t9, 65
  j inserting_cards
 king:
  li $t9, 75
  j inserting_cards
 queen: 
  li $t9, 81
  j inserting_cards
 jack:
  li $t9, 74
  j inserting_cards
 ten:
  li $t9, 84
 inserting_cards: 
 #club
  addi $sp, $sp, -4
  sb $s1, 0($sp) #down
  sb $t9, 1($sp) #val 
  li $t0, 67
  sb $t0, 2($sp) #suit, club
  li $t0, 0
  sb $t0, 3($sp) #0 at the end
  lw $s0, 0($sp)
  addi $sp, $sp, 4
   move $a0, $s2
   move $a1, $s0
   jal append
 #diamond
  addi $sp, $sp, -4
  sb $s1, 0($sp) #down
  sb $t9, 1($sp) #val 
  li $t0, 68
  sb $t0, 2($sp) #suit,diamond
  li $t0, 0
  sb $t0, 3($sp) #0 at the end
  lw $s0, 0($sp)
  addi $sp, $sp, 4
   move $a0, $s2
   move $a1, $s0
   jal append
 #heart
  addi $sp, $sp, -4
  sb $s1, 0($sp) #down
  sb $t9, 1($sp) #val 
  li $t0, 72
  sb $t0, 2($sp) #suit, heart
  li $t0, 0
  sb $t0, 3($sp) #0 at the end
  lw $s0, 0($sp)
  addi $sp, $sp, 4
   move $a0, $s2
   move $a1, $s0
   jal append  
 #spade
  addi $sp, $sp, -4
  sb $s1, 0($sp) #down
  sb $t9, 1($sp) #val 
  li $t0, 83
  sb $t0, 2($sp) #suit, spade
  li $t0, 0
  sb $t0, 3($sp) #0 at the end
  lw $s0, 0($sp)
  addi $sp, $sp, 4
   move $a0, $s2
   move $a1, $s0
   jal append   
 addi $t8, $t8, 1
 addi $t9, $t9, 1
 li $t0, 15
 blt $t8, $t0, deckofcards_loop
    
pt8end:
move $v0, $s2
lw $ra, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

# Part 9
draw_card:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0
lw $t0, 0($s0) #size
beqz $t0, invalid_input_pt9
lw $t0, 4($s0) #address of head
lw $s1, 0($t0) #top card
move $a0, $s0 
move $a1, $s1
jal remove
move $v1, $s1
li $v0, 0 
j pt9end

invalid_input_pt9:
 li $v0, -1
 li $v1, -1
pt9end:
lw $ra, 0($sp)
addi $sp, $sp, 4 
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

# Part 10
deal_cards:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $s5, 0($sp)
addi $sp, $sp, -4
sw $s6, 0($sp)
addi $sp, $sp, -4
sw $s7, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0 #deck
move $s1, $a1 #players
move $s2, $a2 #num of player
move $s3, $a3 #num of cards per player
lw $s4, 0($s0) #size of deck

beqz $s4, invalid_input_pt10
blez $s2, invalid_input_pt10
li $t0, 1
blt $s3, $t0, invalid_input_pt10

li $s5, 0 #player counter
li $s6, 0 #return val
move $s7, $s1
pt10_loop:
 move $a0, $s0
 jal draw_card
 bltz $v0, done_pt10
 lw $t0, 0($s7)
 #change to U 
 li $t2, 0xFFFF00
 li $t3, 'U' 
 and $v1, $v1, $t2
 or $v1, $v1, $t3
 
 move $a0, $t0 #adress list
 move $a1, $v1 #num 
 jal append
 addi $s6, $s6, 1
 addi $s5, $s5, 1
 beq $s5, $s2, went_through_once
 addi $s7, $s7, 4
 j pt10_loop
 
 went_through_once:
  li $s5, 0
  move $s7, $s1
  addi $s3, $s3, -1
  bgtz $s3, pt10_loop
  j done_pt10
  
done_pt10:
 move $v0, $s6
 j pt10end
  
invalid_input_pt10:
 li $v0, -1
 
pt10end:
lw $ra, 0($sp)
addi $sp, $sp, 4 
lw $s7, 0($sp)
addi $sp, $sp, 4
lw $s6, 0($sp)
addi $sp, $sp, 4
lw $s5, 0($sp)
addi $sp, $sp, 4
lw $s4, 0($sp)
addi $sp, $sp, 4
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4
jr $ra

# Part 11
card_points:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)

move $s0, $a0 #card
li $t0, 0xFF
and $s1, $s0, $t0 #first char
li $t0, 0xFF00 
and $s2, $s0, $t0 #second char
srl $s2, $s2, 8
li $t0, 0xFF0000 
and $s3, $s0, $t0 #third char
srl $s3, $s3, 16
li $t0, 0xFF000000
and $s4, $s0, $t0 #fourth char
srl $s4, $s4, 24

#checking fourth char
bnez $s4, invalid_input_pt11
#checking third char 
li $t0, 'H' 
beq $s3, $t0, checksecond
li $t0, 'S' 
beq $s3, $t0, checksecond
li $t0, 'D'
beq $s3, $t0, checksecond
li $t0, 'C'
beq $s3, $t0, checksecond
j invalid_input_pt11
checksecond:
 li $t0, 50
 blt $s2, $t0, invalid_input_pt11
 li $t0, 57
 ble $s2, $t0, checkfirst
 li $t0, 'T'
 beq $s2, $t0, checkfirst
 li $t0, 'J'
 beq $s2, $t0, checkfirst
 li $t0, 'Q'
 beq $s2, $t0, checkfirst
 li $t0, 'K'
 beq $s2, $t0, checkfirst
 li $t0, 'A'
 beq $s2, $t0, checkfirst
 j invalid_input_pt11
 
 checkfirst: 
  li $t0, 'D'
  beq $s1, $t0, validinput
  li $t0, 'U' 
  beq $s1, $t0, validinput
  j invalid_input_pt11

validinput:
 li $t0, 'H'
 beq $s3, $t0, hearts_11
 li $t0, 'Q'
 beq $s2, $t0, checkspades_11
 li $v0, 0
 j pt11end
 
 hearts_11:
  li $v0, 1
  j pt11end
 
 checkspades_11:
  li $t0, 'S'
  beq $s3, $t0, thirteen_points
  li $v0, 0
  j pt11end
  thirteen_points:
   li $v0, 13
   j pt11end

invalid_input_pt11:
 li $v0, -1
 
pt11end: 
lw $s4, 0($sp)
addi $sp, $sp, 4
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4
jr $ra

# Part 12
simulate_game:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $s5, 0($sp)
addi $sp, $sp, -4
sw $s6, 0($sp)
addi $sp, $sp, -4
sw $s7, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0 #deck
move $s1, $a1 #players
move $s2, $a2 #num_rounds

#step 1: initalizing the four players
lw $s3, 0($s1) #player 0 
move $a0, $s3
jal init_list
lw $s3, 4($s1) #player1
move $a0, $s3
jal init_list
lw $s3, 8($s1) #player 2
move $a0, $s3
jal init_list 
lw $s3, 12($s1) #player 3
move $a0, $s3
jal init_list

#deal entire deck 
move $a0, $s0
move $a1, $s1
li $a2, 4
li $a3, 13
jal deal_cards

#find which player has 2c
 addi $sp, $sp, -4
 li $t0, 'U' 
 sb $t0, 0($sp)
 li $t0, 50
 sb $t0, 1($sp)
 li $t0, 'C' 
 sb $t0, 2($sp)
 li $t0, 0
 sb $t0, 3($sp)
 lw $s7, 0($sp) #has U2C
 addi $sp, $sp, 4


 li $t9, 0 #round counter
 li $s0, 0 #return val (points at right place)
 li $s5, 0 #player with highest
 move $s4, $s1
 finding_first: #round1
 lw $s3, 0($s4)
 move $a0, $s3
 move $a1, $s7
 jal remove 
 beqz $v0, val_found
 addi $s4, $s4, 4
 addi $s5, $s5, 1
 j finding_first
 
 val_found:
  move $a0, $s7
  jal card_points
  li $s6, 0 #round points
  add $s6, $s6, $v0
  li $t0, 0xFF0000 
  and $t0, $s7, $t0 #suit
  move $t3, $s5 #player we're at
  
  li $t1, 1 #num of players
  li $t2, 0 #index
  j next_player
  going_through_the_player:
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    addi $sp, $sp, -4
    sw $t1, 0($sp)
    addi $sp, $sp, -4
    sw $t2, 0($sp)
    addi $sp, $sp, -4
    sw $t3, 0($sp) 
    addi $sp, $sp, -4
    sw $t9, 0($sp)     #storing all the t values
   
   move $a0, $s3
   move $a1, $t2
   jal get_value
 
    lw $t9, 0($sp)
    addi $sp, $sp, 4  
    lw $t3, 0($sp)
    addi $sp, $sp, 4
    lw $t2, 0($sp)
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    addi $sp, $sp, 4
    lw $t0, 0($sp)
    addi $sp, $sp, 4 #loading back all the t values
   
   li $t5, 0xFF0000
   bltz $v0, remove_top_card
   and $t4, $v1, $t5
   beq $t4, $t0, card_found_pt11
   addi $t2, $t2, 1
   j going_through_the_player
   
   remove_top_card:
    move $a0, $s3
    
      addi $sp, $sp, -4
      sw $t0, 0($sp)
      addi $sp, $sp, -4
      sw $t1, 0($sp)     #storing t vals
      addi $sp, $sp, -4
      sw $t3, 0($sp) 
      addi $sp, $sp, -4
      sw $t9, 0($sp) 
      
    jal draw_card
       
      lw $t9, 0($sp)
      addi $sp, $sp, 4 
      lw $t3, 0($sp)
      addi $sp, $sp, 4
      lw $t1, 0($sp)
      addi $sp, $sp, 4
      lw $t0, 0($sp)
      addi $sp, $sp, 4 #loading back all the t values

    j next_player
    
   card_found_pt11:
      addi $sp, $sp, -4
      sw $t0, 0($sp)
      addi $sp, $sp, -4
      sw $t1, 0($sp) 
      addi $sp, $sp, -4
      sw $t3, 0($sp)  
      addi $sp, $sp, -4
      sw $t9, 0($sp)  #storing t vals
      
    move $a0, $v1
    jal card_points
    add $s6, $s6, $v0
    li $t5, 0xFF00
    and $t6, $t5, $s7
    and $t5, $t5, $v1
    srl $t6, $t6, 8 #s7 val
    srl $t5, $t5, 8 #v1 val
    
    li $t8, 57
    bgt $t5, $t8, check_letters
  
    bgt $t6, $t5, remove_the_player
     move $s7, $v1
     move $s5, $t3
     j remove_the_player
    
    check_letters: 
     li $t8, 65
     beq $t6, $t8, remove_the_player
     beq $t5, $t8, switch_s7
     li $t8, 75
     beq $t6, $t8, remove_the_player
     beq $t5, $t8, switch_s7
     li $t8, 81
     beq $t6, $t8, remove_the_player
     beq $t5, $t8, switch_s7
     li $t8, 74
     beq $t6, $t8, remove_the_player
     beq $t5, $t8, switch_s7
     li $t8, 84
     beq $t6, $t8, remove_the_player
     beq $t5, $t8, switch_s7
     
     switch_s7:
     move $s7, $v1
     move $s5, $t3
     j remove_the_player
     
    remove_the_player:    
    move $a0, $s3
    move $a1, $v1
    jal remove
    
      lw $t9, 0($sp)
      addi $sp, $sp, 4
      lw $t3, 0($sp)
      addi $sp, $sp, 4
      lw $t1, 0($sp)
      addi $sp, $sp, 4
      lw $t0, 0($sp)
      addi $sp, $sp, 4 #loading back all the t values
      
   next_player:
    li $t5, 4
    beq $t5, $t1, round_done
    li $t5, 3
    beq $t5, $t3, go_back_to_0
    addi $t3, $t3, 1
    addi $t1, $t1, 1
    addi $s4, $s4, 4
    lw $s3, 0($s4)
    li $t2, 0 #reset index
    j going_through_the_player
    go_back_to_0:
     move $s4, $s1
     li $t3, 0
     lw $s3, 0($s4)
     addi $t1, $t1, 1
     li $t2, 0 #reset index
     j going_through_the_player
   
  round_done:
   li $t0, 0
   
   #storing the points
   shifting_loop_pt11:
   beq $t0, $s5, add_to_returnval
   sll $s6, $s6, 8
   addi $t0, $t0, 1
   j shifting_loop_pt11
   add_to_returnval:
    add $s0, $s0, $s6
   
   addi $t9, $t9, 1
   beq $t9, $s2, finished_with_rounds
   move $s4, $s1
   li $t0, 0
   getting_next_val:
    beq $t0, $s5, draw_from_player
    addi $s4, $s4, 4
    addi $t0, $t0, 1
    j getting_next_val 
    draw_from_player:
     lw $s3, 0($s4)
     move $a0, $s3
      addi $sp, $sp, -4
      sw $t9, 0($sp)
     jal draw_card
      lw $t9, 0($sp)
      addi $sp, $sp, 4
     move $s7, $v1
     j val_found
   
 finished_with_rounds:
  move $v0, $s0   
    
pt12end:
lw $ra, 0($sp)
addi $sp, $sp, 4 
lw $s7, 0($sp)
addi $sp, $sp, 4
lw $s6, 0($sp)
addi $sp, $sp, 4
lw $s5, 0($sp)
addi $sp, $sp, 4
lw $s4, 0($sp)
addi $sp, $sp, 4
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
