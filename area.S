.global area
# a in %edi, b in %esi, c in %edx; result in %eax
area:
    movl %edi, %eax # result = a
    addl %esi, %eax # result = a+b
    addl %edx, %eax # result = a+b+c
    sarl $1, %eax # (a+b+c)/2

    movl %eax, %ecx # p-a
    subl %edi, %ecx

    movl %eax, %r8d # p-b
    subl %esi, %r8d

    movl %eax, %r9d # p-c
    subl %edx, %r9d

    imull %ecx, %eax # multiply p * (p-a) * (p-b) * (p-c)
    imull %r8d, %eax
    imull %r9d, %eax

    movl %eax, %edi # recursive call
    call r_sqrt

    retq

r_sqrt:
    cmpl $0, %edi # if(x < 0) return -1
    jl .L1

    cmpl $2, %edi # if if(x < 2) return x
    jl .L2

    pushq   %rdi # save x

    sarl $2, %edi # x >> 2
    call r_sqrt
    sall $1, %eax # x << 1

    movl %eax, %ecx 
    incl %ecx # += 1

    movl %ecx, %r8d # save large_cand

    imull %ecx, %ecx # large_cand * large_cand

    popq %rdi # restore x

    cmpl %edi, %ecx #  if (large_cand * large_cand > x) return small_cand
    jg .L3
    
    movl %r8d, %eax # return large_cand
    retq

.L1:
    movl $-1, %eax
    retq


.L2:
    movl %edi, %eax
    retq

.L3:
    retq

# int area(int a, int b, int c){
#     int p = (a + b + c)/2;
#     p = p * (p-a) * (p-b) * (p-c);
#     return sqrt(p);
# }
# calculate recursively the square root of an int (in C)
# int r_sqrt(int x){
#    if(x < 0)
#        return -1;
#    if (x < 2)
#        return x;
#   /* recursive call */
#    int small_cand = r_sqrt(x >> 2) << 1;
#    int large_cand = small_cand + 1;
#    if (large_cand * large_cand > x)
#        return small_cand;
#    else
#        return large_cand;
# }
