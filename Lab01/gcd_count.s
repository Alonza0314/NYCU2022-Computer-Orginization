.data
num1: .word 4
num2: .word 8
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "
.text

main:
    # load data
    lw      a0,num1             1
    lw      a1,num2             2
    jal     ra,gcd              3

    # print
    mv      a2,a0               42
    lw      a0,num1             43
    lw      a1,num2             44
    jal     ra,printResult      45
    
    # exit
    li      a7,10               68
    ecall                       69

gcd:
    # reserve stack
    addi    sp,sp,-24           4   16  28

    # store a0,a1,ra in stack
    sw      a0,0(sp)            5   17  29
    sw      a1,8(sp)            6   18  30
    sw      ra,16(sp)           7   19  31

    # judge
    mv      t3,a1               8   20  32
    bne     t3,zero,ngcd        9   21  33

    # n==0 return m(a0)

    # restore stack
    addi    sp,sp,24                    34
    ret                                 35

ngcd:
    # count r(rem)
    mv      t0,a0               10  22
    mv      t1,a1               11  23
    rem     t2,t0,t1            12  24

    # call gcd(n,r)
    mv      a0,a1               13  25
    mv      a1,t2               14  26
    jal     ra,gcd              15  27

    # get ra
    lw      ra,16(sp)           39  36

    # restore stack
    addi    sp,sp,24            40  37

    # return
    ret                         41  38

printResult:
    # copy a0,a1,a2 to t0,t1,t2
    mv      t0,a0               46
    mv      t1,a1               47
    mv      t2,a2               48
    
    #str1
    la      a0,str1             49
    li      a7,4                50
    ecall                       51

    #t0
    mv      a0,t0               52
    li      a7,1                53
    ecall                       54

    #str2
    la      a0,str2             55
    li      a7,4                56
    ecall                       57

    #t0
    mv      a0,t1               58
    li      a7,1                59
    ecall                       60

    #str3
    la      a0,str3             61
    li      a7,4                62
    ecall                       63

    #t0
    mv      a0,t2               64
    li      a7,1                65
    ecall                       66

    ret                         67