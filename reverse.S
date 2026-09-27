.global reverse
# list in %rdi (array of char*), n in %esi
reverse:
  movl $0, %eax # i = 0

.loop:
  movl %esi, %ecx # ecx = n
  shrl $1, %ecx # ecx = n/2
  cmpl %ecx, %eax
  jge .L1 # if i>=n/2 stop

  movl %esi, %ecx #ecx = n
  subl %eax, %ecx # ecx = n-i
  subl $1, %ecx # ecx=n-i-1

  movq (%rdi, %rax, 8), %rdx #rdx = list[i]
  movq (%rdi, %rcx, 8), %r8 # r8 = list[n-i-1]

  movq %r8, (%rdi, %rax, 8) # list[i] = list[n-i-1]
  movq %rdx, (%rdi, %rcx, 8) # list[n-i-1] = temp

  incl %eax # i++
  jmp .loop

.L1:
  retq


# void reverse(char **list, unsigned n){
#     unsigned i = 0;
#     while (i < n/2){
#      char *temp = list[i];
#      list[i] = list[n-i-1];
#      list[n-i-1] = temp;
#      i++;
#     }
# }
