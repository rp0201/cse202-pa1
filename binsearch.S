.global binsearch
# arr in %rdi, n in %esi, target in %edx
binsearch:
  movl $0, %eax # lo = 0
  movl %esi, %ecx # hi = n
  subl $1, %ecx # hi = n-1

.loop:
  cmpl %ecx, %eax # lo <= hi
  jg .L1

  movl %ecx, %r8d # r8d = hi
  subl %eax, %r8d # r8d = hi - lo
  sarl $1, %r8d # r8d = (hi-lo)/2
  addl %eax, %r8d # r8d = lo + (hi-lo)/2

  movslq %r8d, %r9
  movl (%rdi,%r9,4), %r9d

  cmpl %edx, %r9d # if (arr[mid] == target), return mid
  je .L2

  jl .L3 # if arr[mid] < target

  movl %r8d, %ecx # hi = mid
  subl $1, %ecx # hi = mid - 1
  jmp .loop # loop 

.L1:
  movl $-1, %eax # return -1
  retq

.L2:
  movl %r8d, %eax # return mid 
  retq

.L3:
  movl %r8d, %eax
  addl $1, %eax # mid + 1
  jmp .loop # loop 



# binary search over a sorted int array; returns the index of target, or -1
# int binsearch(int *arr, unsigned n, int target){
#     int lo = 0;
#     int hi = (int)n - 1;
#     while(lo <= hi){
#         int mid = lo + (hi - lo) / 2;
#         if(arr[mid] == target)
#             return mid;
#         else if(arr[mid] < target)
#             lo = mid + 1;
#         else
#             hi = mid - 1;
#     }
#     return -1;
# }
