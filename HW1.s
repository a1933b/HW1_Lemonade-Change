.data
arr1: .word 5,5,5,10,20
size1: .word 5
arr2: .word 5,5,10,10,20
size2: .word 5
arr3: .word 5,5,5,10,5,5,10,20,20,20
size3: .word 10
str0: .string "Ans:¡@false\n"
str1: .string "Ans:¡@true\n"
space: .string " "
tes1str: .string "Test1: "
tes2str: .string "Test2: "
tes3str: .string "Test3: "

.text
main:
    la s0 arr1
    lw s1 size1
    la a0 ,tes1str
    li a7,4
    ecall
    mv a2 x0
    jal ra  Print_test
    jal ra , sortedSquares
    la s0 arr2
    lw s1 size2
    la a0 ,tes2str
    li a7,4
    ecall
    mv a2 x0
    jal ra  Print_test
    jal ra , sortedSquares
    la s0 arr3
    lw s1 size3
    la a0 ,tes3str
    li a7,4
    ecall
    mv a2 x0
    jal ra  Print_test
    jal ra , sortedSquares
    li a7 10
    ecall
    
sortedSquares:
    #s0:bills base s1:size t0:bill_5 t1:bill_10 t2:bill_20
    #s2=answer i =t3
    addi t0 , x0 ,0
    addi t1 , x0 ,0
    addi t2 , x0 ,0
    mv a0 x0
    addi t3 x0 0
    addi t4 ra 0 
    jal ra, LOOP
    j TRUE
    
LOOP:
     addi t3 t3 1
     beq s1 t3 EXIT
     slli a0 t3 2
     add a0 a0 s0
     lw a0  0(a0)
     addi a1 x0 5
     beq a1 a0 bill5
     addi a1 x0 10
     beq a1 a0 bill10
     addi a1 x0 20
     beq a1 a0 bill20
     j LOOP
bill5:
    addi t0 t0 1
    j LOOP
bill10:
    beq t0 x0 FALSE
    addi t1 t1 1
    addi t0 t0 -1
    j LOOP
bill20:
    slti a2 t0 1
    slti a3 t1 1
    add a4 a2 a3
    beq  a4 x0 bill20if1
    slti a2 t0 3
    beq a2 x0 bill20if2
    j FALSE
bill20if2:
    addi t0 t0 -3
    addi t2 t2 1
    j LOOP
bill20if1:
    addi t0 t0 -1
    addi t1 t1 -1
    addi t2 t2 1
    j LOOP
FALSE:
    la a0 ,str0
    li a7,4
    ecall
    jr t4
TRUE:
    la a0 ,str1
    li a7,4
    ecall
    jr t4
Print_test:
    slli a2 a2 2
    add t0 s0 a2
    lw a0 0(t0)
    li a7,1
    ecall
    la a0 ,space
    li a7,4
    ecall
    srli a2 a2 2
    addi a2 a2 1
    slt t1 a2 s1
    bne x0 t1 Print_test
    jr ra
EXIT:
    jr ra     
    
    
    
    
    
    

    