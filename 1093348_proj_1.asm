.globl	main
.data 	
   endl: 	.string"\n"
   Input:  .string"Input a number:\n"
   Output: .string "The damage:\n"
.text

main: 
    addi sp,sp,16
    la a0,Input
    li a7,4
    ecall
    li a7,5
    ecall
    add t1,a0,zero  # t1 = x
    addi t3,zero,0
    jal ra,Func
    addi sp,sp,16
    la a0,Output
    li a7,4
    ecall
    mv a0,t1
    li a7,1
    ecall
    la a0,endl
    li a7,4
    ecall
    li a7,10
    ecall
Func:
   # x > 99
   addi t2,zero,99 
   bgt t1,t2,case6
   #x > 20
   addi t2,zero,20 
   bgt t1,t2,case1
   #20 >= x > 10
   addi t2,zero,10
    bgt t1,t2,case2
   #10 >= x > 1
   addi t2,zero,1
    bgt t1,t2,case3
    # x == 1
    beq t1,t2,case4
    # x == 0
    beq t1,zero,case5
    #otherwise x = -1
case6:    addi t1,zero,-1
    #return
    jalr ra,ra,0
case1:
    addi sp,sp,+8
    sw ra,0(sp)
    sw t1,4(sp)
    addi t4,zero,5
    div t1,t1,t4 # x = x / 5
    jal ra Func # F(x/5)
    
    addi t4,t1,0 # t4 = t1 = F(x/5)
    lw ra,0(sp)
    lw t1,4(sp) #t1 = x
    addi sp,sp,-8
    slli t1,t1,1 # x = x*2 
    add t1,t1,t4 #x = 2x+F(x/5)
   jalr ra,ra,0 # return 

case2:
    addi sp,sp,8
    sw ra,0(sp)
    sw t1,4(sp)
    addi t1,t1,-2 #x-2
    jal ra,Func
    addi sp,sp,8
    sw ra,0(sp)
    sw t1,4(sp)
   addi sp,sp,-8
    lw ra,0(sp)
    lw t1,4(sp) # t1 =x
    addi sp,sp,8
    addi t1,t1,-3 # t1 =  x-3
    jal ra,Func
    lw ra,0(sp)
    lw t4,4(sp)
    addi sp,sp,-8
    add t1,t4,t1
    lw ra,0(sp)
    lw t4,4(sp)
    addi sp,sp,-8
    jalr ra,ra,0
    
case3: 
    addi sp,sp,8
    sw ra,0(sp)
    sw t1,4(sp)
    addi t1,t1,-1 #x-1
    jal ra,Func
    addi sp,sp,8
    sw ra,0(sp)
    sw t1,4(sp)
   addi sp,sp,-8
    lw ra,0(sp)
    lw t1,4(sp) # t1 =x
    addi sp,sp,8
    addi t1,t1,-2 # t1 =  x-2 
    jal ra,Func
    lw ra,0(sp)
    lw t4,4(sp)
    addi sp,sp,-8
    add t1,t4,t1
    lw ra,0(sp)
    lw t4,4(sp)
    addi sp,sp,-8
    jalr ra,ra,0

case4:
    addi t1,zero,5
     jalr ra,ra,0

case5:
    addi t1,zero,1
     jalr ra,ra,0

    
