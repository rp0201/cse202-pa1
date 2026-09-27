.global isPrime
# n in %edi; result in %eax (1 = prime, 0 = not prime)
isPrime:
  cmpl $2, %edi # if n < 2
  jl .L1

  cmpl $2, %edi # if n == 2
  je .L2

  movl %edi, %eax # eax = n
  cltd
  movl $2, %ecx
  idivl %ecx # n % 2
  cmpl $0, %edx 
  je .L1 

  movl $3, %ecx # i = 3

.loop:
  movl %ecx, %eax # while i * i <= n
  imull %ecx, %eax
  cmpl %edi, %eax
  jg .L2 

  movl %edi, %eax
  cltd
  idivl %ecx # edx = n % i
  cmpl $0, %edx
  je .L1

  addl $2, %ecx # i += 2
  jmp .loop 

.L1:
  movl $0, %eax
  retq # return 0

.L2:
  movl $1, %eax
  retq # return 1


# int isPrime(int n){
#     if(n < 2)
#         return 0;
#     if(n % 2 == 0)
#         return n == 2;
#     /* only test odd divisors i while i*i <= n */
#     for(int i = 3; i * i <= n; i += 2){
#         if(n % i == 0)
#             return 0;
#     }
#     return 1;
# }
