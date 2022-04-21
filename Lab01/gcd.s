.data
num1: .word 4
num2: .word 8
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "
.text

main:
    # load data
    lw      a0,num1
    lw      a1,num2
    jal     ra,gcd

    # print
    mv      a2,a0
    lw      a0,num1
    lw      a1,num2
    jal     ra,printResult      
    
    # exit
    li      a7,10
    ecall

gcd:
    # reserve stack
    addi    sp,sp,-24

    # store a0,a1,ra in stack
    sw      a0,0(sp)
    sw      a1,8(sp)
    sw      ra,16(sp)

    # judge
    mv      t3,a1
    bne     t3,zero,ngcd

    # n==0 return m(a0)

    # restore stack
    addi    sp,sp,24
    ret

ngcd:
    # count r(rem)
    mv      t0,a0
    mv      t1,a1
    rem     t2,t0,t1
    
    # call gcd(n,r)
    mv      a0,a1
    mv      a1,t2
    jal     ra,gcd

    # get ra
    lw      ra,16(sp)

    # restore stack
    addi    sp,sp,24

    # return
    ret

printResult:
    # copy a0,a1,a2 to t0,t1,t2
    mv      t0,a0
    mv      t1,a1
    mv      t2,a2
    
    #str1
    la      a0,str1
    li      a7,4
    ecall

    #t0
    mv      a0,t0
    li      a7,1
    ecall

    #str2
    la      a0,str2
    li      a7,4
    ecall

    #t0
    mv      a0,t1
    li      a7,1
    ecall

    #str3
    la      a0,str3
    li      a7,4
    ecall

    #t0
    mv      a0,t2
    li      a7,1
    ecall

    ret