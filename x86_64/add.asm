# auther: Naman Tamrakar
# date: 06.07.2023
# description: A sample program in 64-bit assembly to add a list and print sum to console
.section .data
array:
    .long 1,2,3,4,5   # Example array
array_end:
array_size = (array_end-array)/4
sum_msg:
    .asciz "Sum: %d\n"
.section .text
.globl main
main:
    pushq %rbp                  # Save base pointer
    movq %rsp, %rbp             # Set up stack frame
    
    # Iterate over the array
    movq $array, %rdx           # Load array address into rdx
    movl $array_size, %ecx      # Load array size into ecx
    # i = 0
    movl $0, %edi
    # Initialize sum to 0
    movl $0, %eax
sum_loop:
    cmpl %edi, %ecx             # check if i == size
    je sum_done                 # jump to end
    addl (%rdx,%rdi,4), %eax    # sum += arr[i]
    incl %edi                   # i++
    jmp sum_loop                # jump to loop start
sum_done:
    # Print the sum
    movl %eax, %esi             # Move sum to second argument
    movq $sum_msg, %rdi         # Move format string to first argument
    movl $0, %eax               # No floating point arguments
    call printf
    
    # Return 0
    movl $0, %eax
    popq %rbp                   # Restore base pointer
    ret