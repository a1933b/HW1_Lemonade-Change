.data
arr1: .word 5,5,5,10,20
size1: .word 5
arr2: .word 5,5,10,10,20
size2: .word 5
arr3: .word 5,5,5,10,5,5,10,20,20,20
size3: .word 10
str0: .string "Ans:　false\n"
str1: .string "Ans:　true\n"
space: .string " "
tes1str: .string "Test1: "
tes2str: .string "Test2: "
tes3str: .string "Test3: "

.text
main:
    la s0, arr1                   #load test1 array base address to s0
    lw s1, size1                  #load test1 array size to s1
    la a0, tes1str                #load teststr1 and print                   
    li a7, 4
    ecall
    jal ra, Print_test            #print test1 array
    jal ra, LemonadeChange        #caculate the result
    la s0 arr2                    #load test2 array base address to s0
    lw s1 size2                   #load test2 array size to s1
    la a0,tes2str                 #load teststr2 and print  
    ecall
    jal ra , Print_test           #print test2 array
    jal ra , LemonadeChange       #caculate the result
    la s0 arr3                    #load test3 array base address to s0
    lw s1 size3                   #load test3 array size to s1
    la a0 ,tes3str                #load teststr3 and print 
    ecall
    jal ra  Print_test            #print test3 array
    jal ra , LemonadeChange       #caculate the result
    li a7 10
    ecall
    
LemonadeChange:
    #s0:bills base s1:size t0:bill_5 t1:bill_10 t2:bill_20 t3:i t4:return address to main
    #s2=answer 
    
    addi t0, x0, 0                   #clear reg t0
    addi t1, x0, 0                   #clear reg t1
    addi t2, x0, 0                   #clear reg t2
    mv a0, x0                        #clear reg a0
    addi t3, x0, 0                   #clear reg t2
    addi t4, ra, 0                   #save return addrees to t4
    addi t5, x0, 0                   #clear reg t5
    jal ra, LOOP                     #jump to LOOP and save return address in ra
    j TRUE                           #jump to true
    
LOOP:
     addi t3, t3, 1                  #i = i + 1
     beq s1, t3, EXIT                #for loop end, jump to exit
     slli a0, t3, 2                  #a0 = i *4
     add a0, a0, s0                  #a0= test array base address + i*4
     lw a0,  0(a0)                   #a0= test array[i]
     addi a1, x0, 5                  #set a1 reg to 5
     beq a1, a0, bill5               #current bill = 5?
     addi a1, x0, 10                 #set a1 reg to 10
     beq a1, a0, bill10              #current bill = 10?
     addi a1, x0, 20                 #set a1 reg to 20
     beq a1, a0, bill20              #current bill = 20?
     j LOOP                          #continue for loop
bill5:
    addi t0, t0, 1                   #t0 =t0 + 1
    j LOOP                           #continue for loop
bill10:
    beq t0, x0, FALSE                #if don't have any bill_5 :  false
    addi t1, t1, 1                   #else: bill_10 = bill_10 + 1
    addi t0, t0, -1                  #bill_5 = bill_5  -1
    j LOOP                           #continue for loop
bill20:
    slti a2, t0, 1                   
    slti a3, t1, 1
    add a4, a2, a3 
    beq  a4, x0, bill20if1        #if have bill_5  and bill_10, jump to bill20if1
    slti a2, t0, 3
    beq a2, x0, bill20if2            #if  have 3 or more bill_5, jump to bill20if2
    j FALSE
bill20if1:
    addi t0, t0, -1                  #bill_5 = bill_5 - 1
    addi t1, t1, -1                  #bill_10 = bill_10 - 1
    addi t2, t2, 1                   #bill_20 = bill_20 - 1
    j LOOP                           #continue for loop
bill20if2:
    addi t0, t0, -3                  #bill_5 = bill_5 - 3
    addi t2, t2, 1                   #bill_20 = bill_20 + 1
    j LOOP                           #continue for loop
FALSE:
    la a0, str0
    li a7, 4
    ecall
    jr t4
TRUE:
    la a0, str1
    li a7,4
    ecall
    jr t4
Print_test:
    # t5: j t1: j*4
    slli t1, t5, 2                   #t1 = t5 * 4
    add t0, s0, t1                   #t1 = t1 + s0
    lw a0, 0(t0)                     #a0 = arr[j]
    li a7, 1
    ecall
    la a0, space
    li a7, 4
    ecall
    addi t5, t5, 1 #t5 = t5 +1
    bne t5, s1, Print_test          # if not scan over, then continue Print_test loop
    jr ra    
EXIT:
    jr ra
