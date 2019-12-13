;ASCII convertor

extern printf
extern scanf

global main

section .text

addTotal:
  inc rdx               ; keep count
  mov al, [rdi]         ; 1st char of message
  mov ah, [rsi]         ; number for that character


  cmp al, 47            ; end when /esc is typed
  je endOfString

  add ah, al            ; get ascii value
  jmp copy

copy:
  mov [total], ah       ; copy to total
  jmp outputNumber

outputNumber:
  ; printf("%d is your number", total)
  mov rdi, outputFormat
  mov rsi, [total]
  mov rax, 0
  call printf

  ; printf("Enter your next character")
  mov rdi, outputFormat2
  mov rax, 0
  call printf

  ; scanf("%s", message)
  mov rdi, inputFormat
  mov rsi, message
  mov rax, 0
  call scanf

  ;addTotal(message, original)
  mov rdi, message
  mov rsi, original
  call addTotal

endOfString:
  ret                   ; end func

main:
  ; printf(prompt1)
  mov rdi, prompt1
  mov rax, 0
  call printf

  ; printf(prompt2)
  mov rdi, prompt2
  mov rax, 0
  call printf

  ; printf(prompt3)
  mov rdi, prompt3
  mov rax, 0
  call printf

  ; scanf("%s", message)
  mov rdi, inputFormat
  mov rsi, message
  mov rax, 0
  call scanf

  mov rdi, message
  mov rsi, original
  mov rdx, counter
  mov rax, 0
  call addTotal

  ; printf("Thanks for using my ASCII convertor!")
  mov rdi, output
  mov rax, 0
  call printf


section .data
  prompt1         db "Welcome to the character to ASCII converter!", 0ah, 0dh, 0
  prompt2         db "This program is an easy to use ASCII convertor. To exit simply type, '/esc'", 0ah, 0dh, 0
  prompt3         db "Please enter your character: ", 0
  inputFormat     db "%s", 0
  outputFormat    db "%d is your number", 0ah, 0dh, 0
  outputFormat2   db "Enter your next character: ", 0
  output          db "Thanks for using my ASCII convertor!", 0ah, 0dh, 0
  total:          dq 0
  original:       dq 0


section .bss
  message:        resb 800
  counter:        resw 100
