.global mult7div8
# a in %dil (signed char), overflow pointer in %rsi; result in %eax
mult7div8:
  movsbl %dil, %eax # eax = a
  imull $7, %eax # 7*a
  movsbl %al, %eax # (char)(7*a)

  movsbl %dil, %ecx # ecx = a

  cmpl $0, %ecx # a==0
  jg .L1  # if a > 0 
  jl .L2 # if a < 0

  movb $0, (%rsi) # overflow = 0
  jmp .L5 

.L1:
  cmpl $0, %eax # mult == 0 
  jl .L3 # if mult < 0 , overflow
  jmp .L4 # no overflow

.L2:
  cmpl $0, %eax # mult == 0
  jg .L3 # if mult > 0, overflow
  jmp .L4 # no overflow 

.L3:
  movb $1, (%rsi) #overflow = 1
  jmp .L5

.L4:
   movb $0, (%rsi) # overflow = 0

.L5:
  movl $8, %ecx 
  cltd # sign extend eax
  idivl %ecx # eax = mult/8
  retq

# char mult7div8(char a, char *overflow){
#     char mult = (7 * a);
#     if(a > 0 && mult < 0 || a < 0 && mult > 0)
#       *overflow = 1;
#     else
#       *overflow = 0;
#     return mult/8;
# }
