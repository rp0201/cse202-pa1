.global commonPrefix
# a in %rdi, b in %rsi; result (prefix length) in %eax
commonPrefix:
  movl $0, %eax # n=0

.loop:
  movb (%rdi, %rax), %cl # cl = a[n]
  cmpb $0, %cl # a[n] == 0
  je .L1

  cmpb %cl, (%rsi, %rax) # a[n] == b[n]
  jne .L1

  incl %eax # n++
  jmp .loop

.L1:
  retq


# length of the longest common prefix of two null-terminated strings
# int commonPrefix(char *a, char *b){
#     int n = 0;
#     while(a[n] && a[n] == b[n])
#         n++;
#     return n;
# }
