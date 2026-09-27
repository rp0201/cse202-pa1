.global gcd
# a in %edi, b in %esi; result in %eax
gcd:
    cmpl $0, %esi # b==0
    je .L1

    movl %edi, %eax # eax = a
    cltd
    idivl %esi # edx = a % b 

    movl %esi, %edi # b 
    movl %edx, %esi # a % b
    call gcd # gcd(b, a % b)

    retq

.L1:
    movl %edi, %eax
    retq


# greatest common divisor via Euclid's algorithm (recursive)
# int gcd(int a, int b){
#     if(b == 0)
#         return a;
#     /* recursive call */
#     return gcd(b, a % b);
# }
