 .section .rodata

err_msg:
  .ascii "This command expects exactly one argument.\n"

newline:
  .ascii "\n" 

  .section .text

  .globl _start
_start:
  ## Print message to standard output.
  ## Let's start by checking the argument count and make sure its 2 or trigger error message.
  movl 0(%esp), %eax
  
  cmpl $2, %eax

  #jump if not equal to 2 to our error message printing
  jne err_call

  #after input validation continue with regular behavior
  movl 8(%esp), %ecx

  #let's get length of the input

  #use edi for iterating edx for counting 
  movl %ecx, %edi
  xorl %edx, %edx
  
str_len:
  #let's load byte by byte
  movb (%edi), %al

  #so we need to terminate the loop now once we reach the null terminator
  cmpb $0, %al
  je str_end
  
  #increment address in edi by one byte (aka next character)
  incl %edi
  incl %edx
  jmp str_len

str_end:
  #all string values found ready to print it out to stdout which is fd 1
  movl $4, %eax

  movl $1, %ebx

  int $0x80

  #time to print trailing newline
  
  movl $4, %eax
 
  movl $1, %ebx

  movl $newline, %ecx

  #last time we already had the count in edx
  movl $1, %edx

  int $0x80

  #need to exit with code 0 now, sysexit is 1

  movl $1, %eax

  movl $0, %ebx

  int $0x80

err_call:
  movl $4, %eax

  #stderr is fd 2
  movl $2, %ebx

  #set our target string
  movl $err_msg, %ecx

  movl $43, %edx

  int $0x80
   
  #need to exit with code 0 now

  movl $1, %eax

  movl $1, %ebx

  int $0x80