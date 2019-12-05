section .data
  query db "What is your name? ", 0
  greeting1 db "Hello, ", 0
  greeting2 db ", nice to meet you!", 0

section .bss
  name resb 32

section .text
  global _start

_start:
  call _printQuery
  call _getName
  call _printGreeting1
  call _printName
  call _printGreeting2
  mov rax, 60
  mov rdi, 0
  syscall

_printQuery:
  mov rax, 1
  mov rdi, 1
  mov rsi, query
  mov rdx, 19
  syscall
  ret

_printGreeting1:
  mov rax, 1
  mov rdi, 1
  mov rsi, greeting1
  mov rdx, 7
  syscall
  ret

_getName:
  mov rax, 0
  mov rdi, 0
  mov rsi, name
  mov rdx, 32
  syscall
  ret

_printName:
  mov rax, name
  mov rcx, 0

  nextchar:
    cmp byte [rax], 10
    jz output
    inc rax
    inc rcx
    jmp nextchar

  output:
    mov rax, 1
    mov rdi, 1
    mov rsi, name
    mov rdx, rcx
    syscall
    ret

_printGreeting2:
  mov rax, 1
  mov rdi, 1
  mov rsi, greeting2
  mov rdx, 19
  syscall
  ret
