.data
argument: .word 7
str1: .string "th number in the Fibonacci sequence is "

.text

main:
    # load and call function
    lw      a0,argument
    jal     ra,Fibonacci
    # print the result
    mv      a1,a0
    lw      a0,argument
    jal     ra,printResult
    # exit
    li      a7,10
    ecall

Fibonacci:
    # reserve stack
    addi    sp,sp,-16
    # store a0 and ra in stack
    sw      a0,0(sp)
    sw      ra,8(sp)
    # judge
    addi    t0,a0,-2
    bge     t0,zero,nFibonacci

    # restore stack
    addi    sp,sp,16
    ret

nFibonacci:
    # call fionacci(n-1)
    addi    a0,a0,-1
    jal     ra,Fibonacci
    # add
    mv      t2,t1
    mv      t1,a0
    add     t3,t1,t2
    # get ra
    lw      ra,8(sp)
    # restore stack
    addi    sp,sp,16
    # refresh
    mv      a0,t3
    ret

# a0=argument
# a1=result
printResult:
    # copy a0,a1 to t0,t1
    mv      t0,a0
    mv      t1,a1
    # copy address from t0 to a0
    mv      a0,t0
    li      a7,1
    ecall
    # copy address from str1 to a0 and print
    la      a0,str1
    li      a7,4
    ecall
    # copy address from t1 to a0
    mv      a0,t1
    li      a7,1
    ecall

    ret