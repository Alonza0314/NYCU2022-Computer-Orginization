.data
argument: .word 7
str1: .string "th number in the Fibonacci sequence is "

.text

main:
    # load and call function
    lw      a0,argument             1
    jal     ra,Fibonacci            2
    # print the result
    mv      a1,a0                   94
    lw      a0,argument             95
    jal     ra,printResult          96
    # exit
    li      a7,10                   107
    ecall                           108

Fibonacci:
    # reserve stack
    addi    sp,sp,-16               3   10  17  24  31  38  45
    # store a0 and ra in stack
    sw      a0,0(sp)                4   11  18  25  32  39  46
    sw      ra,8(sp)                5   12  19  26  33  40  47
    # judge
    addi    t0,a0,-2                6   13  20  27  34  41  48
    bge     t0,zero,nFibonacci      7   14  21  28  35  42  49  # 49 is not bge

    # restore stack
    addi    sp,sp,16                                        50
    ret                                                     51

nFibonacci:
    # call fionacci(n-1)
    addi    a0,a0,-1                8   15  22  29  36  43
    jal     ra,Fibonacci            9   16  23  30  37  44
    # add
    mv      t2,t1                   87  80  73  66  59  52
    mv      t1,a0                   88  81  74  67  60  53
    add     t3,t1,t2                89  82  75  68  61  54
    # get ra
    lw      ra,8(sp)                90  83  76  69  62  55
    # restore stack
    addi    sp,sp,16                91  84  77  70  63  56
    # refresh
    mv      a0,t3                   92  85  78  71  64  57
    ret                             93  86  79  72  65  58

# a0=argument
# a1=result
printResult:
    # copy a0,a1 to t0,t1
    mv      t0,a0                   97
    mv      t1,a1                   98
    # copy address from t0 to a0
    mv      a0,t0                   99
    li      a7,1                    100
    ecall                           109
    # copy address from str1 to a0 and print
    la      a0,str1                 101
    li      a7,4                    102
    ecall                           110
    # copy address from t1 to a0
    mv      a0,t1                   103
    li      a7,1                    104
    ecall                           105

    ret                             106