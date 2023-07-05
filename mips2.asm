#Moath ridi 1201507
.data
print1:.asciiz"is dictionary file exist or not?\n1.Yes\n2.NO\n Enter the number of your choice!\n"
dictionary:.asciiz"dictionary.txt"
output_file:.space 1024
output_file2:.space 1024
print2:.asciiz"Enter the path of the dictionary file!\n"
dictionaryPath:.space 1024
result: .space 1024
hexcode:.asciiz"0x"
dtem2:.word 0
dtem1: .space 1024
spacecode:.asciiz"0x0000"
temp:.space 1024
deCom:.space 1024
tem: .space 1024
tmp:.space 1024
dicArray:.space 1024
darray:.space 1024
compressedPath:.space 1024
Data:.space 1024
print3:.asciiz"\nWhat do you want to do? a Compression , Decompression or Quit\n"
print4:.asciiz"Enter the path of the file to be compressed !\n"
print5:.asciiz"Enter the path of the compressed file to save !\n"
print6:.asciiz"Enter the path of the decompresse file to save !\n"
print7:.asciiz"The compressed file size = "
print8:.asciiz" bits = "
print9:.asciiz"byets"
print10:.asciiz"The uncompressed file size = "
print11:.asciiz"File Compression Ratio =  "
cordAnswer:.space 20
msg2: .asciiz "Given String are equal"
msg3: .asciiz "Given string are not equal"
c:.byte'c'
dot:.asciiz"."
newline: .asciiz "\n"
compress:.asciiz"compress"
compression:.asciiz"compression"
d:.byte'd'
decompress:.asciiz"decompress"
decompression:.asciiz"decompression"
q:.byte'q'
quit:.asciiz"quit"
lower:.space 60
error: .asciiz "Invalid option!\n"
Quit: .asciiz "Quitting program...\n"
compress_msg: .asciiz "Performing compression...\n"
decompress_msg: .asciiz "Performing decompression...\n"
quotient:   .float 10           # Quotient (result) value
error_msg: .asciiz "Invalid hexadecimal number."
.text
main:
menue:    
     li $v0,4 #printing ont the screen
     la $a0,print1  #load the address of my message
     syscall
     
     #get user choice of the nenue 
     li $v0,5
     syscall
     #store usere choice
     move $t0,$v0
     
     #check user choice if it has a dictionary
     li $t1,1
     beq $t0,$t1,yes
     
     #if the choice was no 
     li $t2,2
     beq $t0,$t2,no
     
     
     #defult case 
     j main
     
     
     
yes:     
     li $v0,4 #printing ont the screen
     la $a0,print2  #load the address of my message
     syscall
     
     #read the path from user
     li $v0,8
     la $a0,dictionaryPath
     li $a1,1024
     syscall
     li $s0,0
     jal removeW2
     ##############loading the dictionary here !!!!!!!(2)
     ##opening the file for reading
     li $v0,13
     la $a0,dictionaryPath
     li $a1,0
     syscall
     move $s0,$v0
     #read the file 
     li $v0,14
     move $a0,$s0
     la $a1,temp
     la $a2,5000
     syscall
    
    # Close the file
    li $v0, 16                # System call number for closing a file
    move $a0, $s0             # Move the file descriptor to $a0
    syscall 
    
     # loading dictionary
     la $t0,temp   # Load the current character from the sentence
     la $t1,dicArray
     li $t6,'0'
     li $t4, '$'         
 againd:    ##read word by word
     lbu $t3, 0($t0)
     beqz $t3,  cORd
     beq $t3, $t4, cut 
     sb $t3,0($t1)             
     addi $t0,$t0,1
     addi $t1,$t1,1
     
     j againd
 
    j cORd
cut:
     sb $t6,0($t1)
    addu $t1,$t1,1
    addu $t0,$t0,1
    j againd
     
     
     
     j cORd
    
no:
     #creat the dictionary file
     li $v0,13
     la $a0,dictionary
     la $a1,1
     syscall
     move $s0,$v0
     # Close the file
    li $v0, 16                # System call number for closing a file
    move $a0, $s0             # Move the file descriptor to $a0
    syscall                   # Perform the system call 
     j cORd

cORd:     #######Asking user wither he want to do? a Compression , Decompression or Quit 
    
    li $v0, 4
    la $a0, print3
    syscall

    # Read user input
    li $v0, 8
    la $a0, cordAnswer
    li $a1, 20
    syscall
  #  
    #la $t0, cordAnswer        # Load address of str1
   # la $t1, lower        # Load address of str2
   # jal to_lower            # Call the to_lower function
    

    move $t9,$a0
    li $t8,0
    ##compress section !
  ##if user entered c 
   la $a1,c
   
   li $t4,0
   
    jal compare_char
    
    ##if user entered compress
css:    
        addu $t4,$t4,1
        la $a1,compress
        la $a0,cordAnswer
        jal compare
        
     ##if user entered compression    
cion: 

        addu $t4,$t4,1
        la $a1,compression
        la $a0,cordAnswer
        jal compare

decheck:
##decompress section !
  ##if user entered d 
  
   la $a1,d
   la $a0,cordAnswer
   li $t7,0
   
    jal compare_char
    
    ##if user entered compress
dss:    
        addu $t7,$t7,1
        la $a1,decompress
        la $a0,cordAnswer
        jal compare
     ##if user entered compression
        
dion: 

        addu $t7,$t7,1
        la $a1,decompression
        la $a0,cordAnswer
        jal compare

qcheck:

##quit section !
  ##if user entered q 
 
    la $a1,q
    la $a0,cordAnswer
   li $t9,0
   
    jal compare_char
    
    ##if user entered quit
qut:    
        addu $t9,$t9,1
         la $a1,quit
        la $a0,cordAnswer
        jal compare






exit:   

    #priint uncompressed data ==>
    li $v0,4 #printing ont the screen
     la $a0,print10  #load the address of my message
     syscall
     li $s7,16
     mul $s4,$s3,$s7
     li $v0 ,1
     move $a0,$s4
     syscall
     move $t0,$s4
     li $v0,4 #printing ont the screen
     la $a0,print8  #load the address of my message
     syscall
     # print in bytes
     li $s7,8
     div $s4,$s4,$s7
     li $v0 ,1
     move $a0,$s4
     syscall
     
     li $v0,4 #printing ont the screen
     la $a0,print9  #load the address of my message
     syscall
     li $v0,4 #printing new line
     la $a0,newline  #load the address of my message
     syscall



    #print the retio compressed data==>
     li $v0,4 #printing ont the screen
     la $a0,print7  #load the address of my message
     syscall
     li $s7,16
     mul $s4,$s7,$s6
     li $v0 ,1
     move $a0,$s4
     syscall
     move $t1,$s4
     li $v0,4 #printing ont the screen
     la $a0,print8  #load the address of my message
     syscall
     # print in bytes
     li $s7,8
     div $s4,$s4,$s7
     li $v0 ,1
     move $a0,$s4
     syscall
     li $v0,4 #printing ont the screen
     la $a0,print9  #load the address of my message
     syscall
      li $v0,4 #printing new line
     la $a0,newline  #load the address of my message
     syscall
     
     li $v0,4 #printing ont the screen
     la $a0,print11  #load the address of my message
     syscall
     
       div $t0, $t1 # Hi contains the remainder, Lo contains quotient
       mfhi $t2 # remainder moved into $t0
       mflo $t3 # quotient moved into $t1
       
       
       li $v0, 1                 # System call code for print integer
       move $a0, $t3             # Move the quotient value to $a0
       syscall
       
       li $v0,4 #printing ont the screen
       la $a0,dot  #load the address of my message
       syscall
       li $v0, 1                 # System call code for print integer
       move $a0, $t2             # Move the quotient value to $a0
       syscall
       
      j exitd
exitd:
      li $v0, 10 # Exit program
      syscall
      
compare_char:

        lb $t1, 0($a0)      # Load byte from first string
        lb $t2, 0($a1)      # Load byte from second string
        beq $t1, $t2, equal
        j notequal
               # Return from the function
compare:
   li $t0, 1             # Assume strings are equal
    loop:
        lb $t1, 0($a0)      # Load byte from first string
        lb $t2, 0($a1)      # Load byte from second string
        beq $t1, $t2, next   # If bytes are equal, move to next byte
                 # If bytes are not equal, set $t0 to 0 and exit loop
        j notequal
    next:
        addi $a0, $a0, 1    # Increment first string pointer
        addi $a1, $a1, 1    # Increment second string pointer
        bne $t1, $zero, loop # If end of string not reached, loop again
        j equal      # Return from function

equal:
    #if $t8 =0 -> compress,$t8=1->decompress, $t8=3 quit , else erorr
    beqz $t8,Compression
    li $t0,1
    beq $t8,$t0,decompressionmsg
    li $t0,2
    beq $t8,$t0,quitmsg
    bne $t8,$t0,errormsg
    
    
    
    
  
    li $v0, 4
    la $a0, msg2
    syscall

    j exit  #finally, jump to the exit label

notequal:
    li $t5,1
    li $t6,2
    beq $t4,$zero,css
    beq $t4,$t5,cion
    beq $t4,$t6,cstart
    
    #de compression
     beq $t7,$zero,dss
    beq $t7,$t5, dion 
    beq $t7,$t6,dstart
    beq $t9,$zero,qut
    beq $t9,$t5,qstart
    
    ################### 
cstart:
   addu $t8,$t8,1
   addu $t4,$t4,1
   j decheck
###################    
dstart:
    addu $t8,$t8,1
    addu $t7,$t7,1
    j qcheck
qstart:
      li $v0,4 #printing ont the screen
     la $a0,error  #load the address of my message
     syscall
    
    
errormsg:
    
    li $v0, 4
    la $a0, error
    syscall

    j exit  #finally, jump to the exit label
    
 quitmsg:
    li $v0, 4
    la $a0, Quit
    syscall
    j exit  #finally, jump to the exit label   
    
    
decompressionmsg:
   ########################################### 
    li $v0,4 #printing ont the screen
     la $a0,print6  #load the address of my message
     syscall
     
     #read the path of decompressed from user
     li $v0,8
     la $a0,output_file2
     li $a1,1024
     syscall
     li $s0,0
     jal removeW4
     move $s0,$v0
     
     ##opening the file for reading
     li $v0,13
     la $a0,output_file2
     li $a1,0
     syscall
     move $s0,$v0
     #read the file 
     li $v0,14
     move $a0,$s0
     la $a1,deCom
     la $a2,1024
     syscall
     
     #printing the file conntent
     li $v0, 4
     la $a0,deCom
     syscall
     # Close the file
     li $v0, 16                # System call number for closing a file
     move $a0, $s0             # Move the file descriptor to $a0
     syscall                   # Perform the system call 
    
    la $s0,deCom
    li $s1,'\n'
    li $s2,'\0'
    la $s4,dtem1
    li,$t0,0
    li $t1,2
    
    
cut_onR:
    lb $s3,0($s0)
    beq $s3,$s1,endOfCut
    beq $s3,$s2,exitd
    blt  $t0,$t1,skipN
    sb $s3,($s4)
    addi $s0,$s0,1
    addi $s4,$s4,1
    j cut_onR
   
 endOfCut:
   move $s6,$s0
    jal convert_word
    li $v0,1
    move $a0,$t2
    syscall
    
    jal hexToDec
    li,$t0,0
    li $t1,2
    la $s4,dtem1
     move $s0,$s6
    addi $s0,$s0,1
    j cut_onR
    
 skipN:
  addi $t0,$t0,1
  addi $s0,$s0,1
    j cut_onR
    
    
    
    
    
    
    
    j exitd
#comprission function
Compression:
    li $s6,0 #counter for the hex codes
    li $s3,0
    
    li $v0, 4
    la $a0, print4
    syscall
    
    li $v0,8
    la $a0,compressedPath
    li $a1,1024
    syscall
    
    li $s0,0
    jal removeW1
     ##opening the file for reading
     li $v0,13
     la $a0,compressedPath
     li $a1,0
     syscall
     move $s0,$v0
     #read the file 
     li $v0,14
     move $a0,$s0
     la $a1,Data
     la $a2,1024
     syscall
     # Close the file
     li $v0, 16                # System call number for closing a file
     move $a0, $s0             # Move the file descriptor to $a0
     syscall                   # Perform the system call 
     #printing the file conntent
     #li $v0, 4
     #la $a0,Data
     #syscall
     
     li $v0,4 #printing ont the screen
     la $a0,print5  #load the address of my message
     syscall
     
     #read the path of compressed from user
     li $v0,8
     la $a0,output_file
     li $a1,1024
     syscall
     li $s0,0
     jal removeW3
     
     #creat the compress file
     li $v0,13
     la $a0,output_file
     la $a1,1
     syscall
     move $s0,$v0
     # Close the file
     li $v0, 16                # System call number for closing a file
     move $a0, $s0             # Move the file descriptor to $a0
     syscall                   # Perform the system call 
     la $t0,Data   # Load the current character from the sentence
     la $t1,darray
     la $t8,tem       
 again:    ##read word by word
     li $t6,'0'
     li $t7,0
     li $t4, ' '
     lbu $t3, 0($t0)
     beqz $t3, wExist
     beq $t3, $t4, is_space
     sb $t3,0($t1)
     addi $s3,$s3,1 # add countr of char
     sb $t3,0($t8)           
     addi $t0,$t0,1
     addi $t8,$t8,1
     addi $t1,$t1,1
     j again

is_space:
    addi $s3,$s3,1 # add countr of char
    sb $t6,0($t1)  # t6 =0  , t3=current char
    sb $t6,0($t8)
    la $t9,dicArray
    lb $t4,0($t9)
    beqz $t4,add_toDic
    jal check_dictionary #check two words if are equal and return a flag in $t6
    #flag =0 => not eexist ->add it to dic,,,flag=1=>exist convert it to hex then print it to file
    
    beqz $t6,add_toDic
ddn: 
    la $t8, tem 
       # Load the address of the string into $a0
clear_loop:
    lb $t4, ($t8)       # Load a byte from the string into $t0
    beqz $t4, end_clear # If the byte is zero (end of the string), exit the loop
    li $t6, '\0'        # Load the null character into $t1
    sb $t6, ($t8)       # Store the null character at the current position in the string
    addiu $t8, $t8, 1   # Increment the string address to move to the next character
    j clear_loop        # Jump back to the beginning of the loop        
end_clear:
    la $t8, tem   # Load the address of the string into $a0
    addu $t1,$t1,1
    addu $t0,$t0,1
    j again
    
wExist:
#when we are here , all words must be at the dic and ready to code it
# find the index then convert the number to hex then print it to compressed file
   la $t8,tem
   la $a2,darray 
   li $t0,'0'
   
lod:
   li $t0,'0'
   li $t1,'\0'
   beq $t9,$t1,exit
   lb $t9,0($a2)
   beq $t9,$t0,wdn
   sb $t9,0($t8)
   addi $t8,$t8,1
   addi $a2,$a2,1
   j lod
   
wdn:  
     sb $t0,0($t8)
     li $s4,0
     move $s4,$a2
     jal checkindex
     jal decimal_hex
     jal print_c_tofile
     
 
mo:
    la $t8, tem  
clear_loops:
    lb $t4, ($t8)       # Load a byte from the string into $t4
    beqz $t4, end_clears # If the byte is zero (end of the string), exit the loop
    li $t6, '\0'        # Load the null character into $t1
    sb $t6, ($t8)       # Store the null character at the current position in the string
    addiu $t8, $t8, 1   # Increment the string address to move to the next character
    j clear_loops        # Jump back to the beginning of the loop        
end_clears:
    la $t8, tem   # Load the address of the string into $t8
    move $a2,$s4
    addu $a2,$a2,1
    lb $t9,0($a2)
    j lod
  ##use the index to convert it to hex and print it 
   
   
   
 j exit 
    
add_toDic:
# Copy first string to result buffer
  la $a0, dicArray
  la $a1, dicArray
  jal strcopier
  # Concatenate second string on result buffer
  la $a0, tem
  or $a1, $v0, $zero
  jal strcopier
  j cfinish
 #######################################################      
# String copier function
strcopier:
  or $t2, $a0, $zero # Source
  or $t3, $a1, $zero # Destination          

loop_copy:
  lb $t9, 0($t2)
  beq $t9, $zero, endc
  addiu $t2, $t2, 1
  sb $t9, 0($t3)
  addiu $t3, $t3, 1
  b loop_copy

endc:
  or $v0, $t3, $zero # Return last position on result buffer
  jr $ra


cfinish:
    
     #replace the 0 char to $ and save it to file
    la $a3,dicArray
    la $t9,tmp
    
cc:    
    lb $t7,0($a3)
    li $t8,'$'
    li $t6,'0'
    beq $t6,$t7,put$
    beqz $t7,pp
    sb $t7,0($t9)
    addi $t9,$t9,1
    addi $a3,$a3,1
    
    j cc
    
put$:
    
    sb ,$t8,0($t9)
    addi $t9,$t9,1
    addi $t7,$t7,1
    addi $a3,$a3,1
    j cc
    # Open the file for writing
pp:

     
    # Open the file for writing
    li $v0, 13                # System call number for opening a file
    la $a0, dictionary       # Load the address of the file name
    li $a1, 1                 # Open the file in write mode
    li $a2, 0                 # Set the file's permission to default
    syscall                   # Perform the system call

    move $s0, $v0             # Store the file descriptor in $s0

    # Write the string to the file
    li $v0, 15                # System call number for writing to a file
    move $a0, $s0             # Move the file descriptor to $a0
    la $a1, tmp               # Load the address of the string to print
    li $a2, 1024              # Set the length of the string
    syscall                   # Perform the system call

    # Close the file
    li $v0, 16                # System call number for closing a file
    move $a0, $s0             # Move the file descriptor to $a0
    syscall 
  j ddn
               
 ###########################################################                               
 #check if the dictionary has a spesafic word or not and return a flag $t6 0 or 1                 
check_dictionary:
   la $a0,dicArray
   la $a1,tem
   li $t2,'0'
   li $t6,0 #flag 
   li $t7,0
lop:   
   lb $t3,0($a0)
   lb $t4,0($a1)
   beqz $t3,notequals
   beq $t4,$t2,ends
   beq $t3,$t2,addAdress 
   beq $t3,$t4,equals
   bne $t3,$t4,contin
   
addAdress:
   addi,$a0,$a0,1
   j lop
equals: 
   li $t6,1
   li $t7,1
   addi $a0,$a0,1
   addi $a1,$a1,1
   j lop
   
ends: 
   beq $t3,$t2,seeflag
   j notequals
contin:
   li $t6,0
   addi $a0,$a0,1 
   la $a1,tem
   j lop
notequals: 
   li $t6,0
   jr $ra 
   
seeflag:
   beqz $t6,notequals
   jr $ra
################################################################   
 #function to find the index at the dictionay array 
checkindex:  
    la $a1,tem
    la $a0,dicArray
    li $t0,'0'
    li $t1,0 #counter of the index
    li $t2,0 #flag if if fount
ckk:  
    lb $t3,0($a1)#t3 => data
    lb $t4,0($a0)#t4=> dictionary
    beq $t4,$t0,addindx
    beq $t3,$t0,founded
    beqz $t4,founded
    beq $t3,$t4,eql
    bne $t3,$t4,contn
    
addindx:
   addi $t1,$t1,1
   addi $a0,$a0,1
   j ckk
eql: 
   li $t2,1
   addi $a0,$a0,1
   addi $a1,$a1,1
   j ckk
contn:
   li $t6,0
   addi $a0,$a0,1 
   la $a1,tem
   j ckk
founded: 
   jr $ra ## index in t1
 
###########################################################
#print to file
print_c_tofile:
   addi $s6,$s6,2
# Open the file for writing
    li $v0, 13                # System call number for opening a file
    la $a0, output_file       # Load the address of the file name
    li $a1, 9                 # Open the file in write mode with truncate flag
    li $a2, 0                 # Set the file's permission to default
    syscall                   # Perform the system call

    move $s0, $v0             # Store the file descriptor in $s0
    li $v0, 15                # System call number for writing to a file
    move $a0, $s0             # Move the file descriptor to $a0
    la $a1, hexcode               # Load the address of the string to print
    li $a2, 2 
    syscall            # Move the string length to $a2
    # Calculate the string length
    la $t0, result               # Load the address of the string
    li $t1, 0                 # Initialize a counter for string length
    count_length:
        lb $t2, ($t0)         # Load the byte at the current address
        beqz $t2, write_string   # If the byte is null, exit the loop
        addi $t1, $t1, 1      # Increment the counter
        addi $t0, $t0, 1      # Move to the next byte
        j count_length        # Continue the loop

    write_string:
    # Write the string to the file
    li $v0, 15                # System call number for writing to a file
    move $a0, $s0             # Move the file descriptor to $a0
    la $a1, result               # Load the address of the string to print
    move $a2, $t1             # Move the string length to $a2
    syscall    
                   # Perform the system call
   # Write a new line character to the file
    li $v0, 15             # System call code for write
    la $a1, newline        # Load the newline address into $a1
    li $a2, 1              # Length of the newline character
    syscall                # Perform the system call
    
    # Write a space  to the file
    li $v0, 15             # System call code for write
    la $a1, spacecode        # Load the newline address into $a1
    li $a2, 6              # Length of the newline character
    syscall                # Perform the system call
    
    # Write a new line character to the file
    li $v0, 15             # System call code for write
    la $a1, newline        # Load the newline address into $a1
    li $a2, 1              # Length of the newline character
    syscall                # Perform the system call
    # Close the file
    li $v0, 16                # System call number for closing a file
    move $a0, $s0             # Move the file descriptor to $a0
    syscall                   # Perform the system call
 
    jr $ra


########################################
#remove \n from file name
	li $s0,0			# Set index to 0
	removeW1:
	lb $a3,compressedPath($s0)		# Load character at index
	addi $s0,$s0,1			# Increment index
	bnez $a3,removeW1		# Loop until the end of string is reached
	subiu $s0,$s0,2			# If above not true, Backtrack index to '\n'
	sb $0, compressedPath($s0)		# Add the terminating character in its place   
          jr $ra
    
    
#remove \n from dictionary path
	li $s0,0			# Set index to 0
	removeW2:
	lb $a3,dictionaryPath($s0)		# Load character at index
	addi $s0,$s0,1			# Increment index
	bnez $a3,removeW2		# Loop until the end of string is reached
	subiu $s0,$s0,2			# If above not true, Backtrack index to '\n'
	sb $0, dictionaryPath($s0)		# Add the terminating character in its place   
          jr $ra   
#remove \n from compressd path
	li $s0,0			# Set index to 0
	removeW3:
	lb $a3,output_file($s0)		# Load character at index
	addi $s0,$s0,1			# Increment index
	bnez $a3,removeW3		# Loop until the end of string is reached
	subiu $s0,$s0,2			# If above not true, Backtrack index to '\n'
	sb $0, output_file($s0)		# Add the terminating character in its place   
          jr $ra   
  #remove \n from decompressd path
	li $s0,0			# Set index to 0
	removeW4:
	lb $a3,output_file2($s0)		# Load character at index
	addi $s0,$s0,1			# Increment index
	bnez $a3,removeW4		# Loop until the end of string is reached
	subiu $s0,$s0,2			# If above not true, Backtrack index to '\n'
	sb $0, output_file2($s0)		# Add the terminating character in its place   
          jr $ra          
decimal_hex:
  li ,$t2,0
  move $t2,$t1
  li $t0, 8  # counter 
  la $t9, result  # where answer will be stored 
Loop: 
  beqz $t0, Exit # branch to exit if counter is equal to zero 
  rol $t2, $t2, 4 # rotate 4 bits to the left 
  and $t4, $t2, 0xf # mask with 1111 
  ble $t4, 9, Sum # if less than or equal to nine, branch to sum 
  addi $t4, $t4, 55 # if greater than nine, add 55 
  b End 
Sum: 
  addi $t4, $t4, 48 # add 48 to result 

End: 
  sb $t4, 0($t9) # store hex digit into result 
  addi $t9, $t9, 1 # increment address counter 
  addi $t0, $t0, -1 # decrement loop counter 
  j Loop 
Exit: 
  
  la $a1,result
  li $t3,'\0'
  li $t0,4
lo:##make it 4 bit hex
  beqz $t0,ns
  sb $t3,($a1)
  addi $t0,$t0,-1
  addi $a1,$a1,1
  la $a2,result
  j lo
ns:
  
  lb $t1,0($a1)
  sb $t3,0($a1)
  sb $t1,0($a2)
  addi $a2,$a2,1
  beq $t1,$t3,dn
  addi $a1,$a1,1
  j ns
  
  
 dn:
  jr $ra
######################################################
hexToDec:
    
    lw $t0, dtem2     # Load the address of the string into $a0
    andi $t1, $t0, 0xF      # Extract the rightmost digit (LSB)
    andi $t2, $t0, 0xF0     # Extract the second rightmost digit
    srl $t2, $t2, 4         # Shift the second digit to the rightmost position

    addi $t3, $t1, 0        # Convert the rightmost digit to decimal
    addi $t4, $t2, 0        # Convert the second rightmost digit to decimal

    li $t5, 16              # Load 16 into $t5 for multiplication
    mul $t4, $t4, $t5       # Multiply the second digit by 16

    add $t6, $t3, $t4       # Accumulate the decimal values of both digits
    jr $ra
    
    
convert_word:

        la $t0, dtem1    # Load address of the ASCIIZ string
        lw $t1, ($t0)           # Load the first word of the ASCIIZ string
        li $v0,4
        la $a0,dtem1
        syscall
        li $t2, 0               # Initialize $t2 to 0 for accumulating the value
        li $t3, 10              # $t3 = 10 (used for base 10 conversion)

convert_loop2:
        lbu $t4, 0($t0)         # Load a byte from the ASCIIZ string
        beqz $t4, convert_done  # If the byte is 0 (null terminator), exit the loop

        subu $t4, $t4, 48       # Convert ASCII character to its numerical value
        mul $t2, $t2, $t3       # Multiply the accumulated value by 10
        addu $t2, $t2, $t4      # Add the current digit to the accumulated value

        addiu $t0, $t0, 1       # Increment the address to move to the next character
        j convert_loop2          # Repeat the loop for the next character

convert_done:
        sw $t2, dtem2         # Store the converted value in the result word
        jr $ra