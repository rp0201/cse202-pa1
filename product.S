.global product
# a in %rdi, b in %rsi, c in %rdx, size in %ecx
product:
    movl $0, %eax # i = 0

.loop:
    cmpl %ecx, %eax
    jge .L1 # i >= size

    movss (%rdi, %rax, 4), %xmm0 # xmm = a[i]
    mulss (%rsi, %rax, 4), %xmm0 # xmm = a[i]*b[i]
    movss %xmm0, (%rdx, %rax, 4) # c[i] = a[i]*b[i]

    incl %eax # i++
    jmp .loop
.L1: 
    retq

# Product of two vectors in C
# void product(float *a, float *b, float *c, unsigned size){
#    for(int i=0; i<size; i++){
#        c[i] = a[i] * b[i];
#    }
# }
