.data
num1: .word 4
str1: .string "Array¡G\n"
str2: .string "\nSorted¡G\n"
spac: .string " "
datas: .word 5,3,6,7
sizee: .word 16
.text

main:
    # printarray
    la      a0,str1
    li      a7,4
    ecall

    jal     ra,printarray

    # bubbble sort:
    lw      s0,num1
    jal     ra,bubblesort

    # print sort-array
    la      a0,str2
    li      a7,4
    ecall

    jal ra,printarray

    # exit
    li      a7,10
    ecall

bubblesort:
    # store ra and temp  into stack
    addi    sp,sp,-8
    sw      ra,0(sp)

    la      t2,datas

    # int i=0
    li      s1,0
    loops_i:
        bge     s1,s0,loops_i_exit
        
        # int j=i-1
        addi    s2,s1,-1
        loops_j:
            blt     s2,zero,loops_j_exit
            slli    a0,s2,2
            add     a0,a0,t2

            # load data[j] and data[j+1]
            lw      t0,0(a0)
            lw      t1,4(a0)

            bge     t1,t0,loops_j_exit

            mv      s3,s2
            jal     ra,swap
            
            # j--
            addi    s2,s2,-1
            j       loops_j
        loops_j_exit:
            addi    s1,s1,1
            j       loops_i
    loops_i_exit:
        lw      ra,0(sp) 
        addi    sp,sp,8
        ret

swap:
    slli    a0,s3,2
    add     a0,a0,t2
    lw      t4,0(a0)
    lw      t5,4(a0)
    sw      t4,4(a0)
    sw      t5,0(a0)
    ret

printarray:
    # set array and final place and its size
    la      t0,datas
    lw      t1,sizee
    add     t2,t0,t1

    loops:
        # print number
        lw      a0,0(t0)
        li      a7,1
        ecall  

        # print space
        la      a0,spac
        li      a7,4
        ecall

        # loops condition
        addi    t0,t0,4
        bne     t0,t2,loops

    ret