.global secondMax
# v1 in %di, v2 in %si, v3 in %dx, v4 in %cx  (signed 16-bit); result in %ax
secondMax:
  cmpw %si, %di
  jge .L1 # if v1 >= v2

  movw %si, %r8w # first = v2
  movw %di, %r9w # second = v1
  jmp .L2

.L1:
  movw %di, %r8w # first = v1
  movw %si, %r9w # second = v2


.L2:
  cmpw %r8w, %dx
  jg .L3 # if v3 > first

  cmpw %r9w, %dx
  jg .L4 # if v3 > second
  jmp .L5

.L3: 
  movw %r8w, %r9w # second = first
  movw %dx, %r8w # first = v3
  jmp .L5

.L4:
  movw %dx, %r9w # second = v3
  jmp .L5

.L5:
  cmpw %r8w, %cx
  jg .L6 # if v4 > first

  cmpw %r9w, %cx
  jg .L8 # if v4 > second
  jmp .L7

.L6:
  movw %r8w, %r9w # second = first
  movw %cx, %r8w # first = v4
  jmp .L7

.L7:
  movw %r9w, %ax # return second
  retq

.L8:
  movw %cx, %r9w
  jmp .L7

# short secondMax(short v1, short v2, short v3, short v4){
#     short first, second;
#     if(v1 >= v2){ first = v1; second = v2; }
#     else        { first = v2; second = v1; }
#     if(v3 > first)       { second = first; first = v3; }
#     else if(v3 > second) { second = v3; }
#     if(v4 > first)       { second = first; first = v4; }
#     else if(v4 > second) { second = v4; }
#     return second;
# }
