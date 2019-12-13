extern printf
extern scanf

global main

section .text

encrypt:
  mov al, [rdi]         ; 1st char of message
  mov ah, [rsi]         ; 1st char of key

  cmp ah, 0             ; key char == null (end of key)
  je keyReset           ; reset key back to first char

  cmp al, 0             ; message char == null (end of message)
  je endOfString        ; end func

  add al, ah            ; message + key
  sub al, [a]           ; (message + key) - A

  cmp al, [z]           ; new < 'Z'
  jbe copy              ; copy

  cmp al, [z]           ; new > 'Z'
  ja modify             ; modify

nextChar:
  inc rdi               ; increment message
  inc rsi               ; increment key
  jmp encrypt

modify:
  sub al, [num]          ; new - 26
  mov [rdi], al          ; copy
  jmp nextChar

copy:
  mov [rdi], al         ; copy new -> rdi
  jmp nextChar

keyReset:               ;start over key
  mov rsi, key
  jmp encrypt

endOfString:
  ret                   ; end func

main:

  ; printf(messageInput)
  mov rdi, messageInput
  mov rax, 0
  call printf

  ; scanf("%s", message)
  mov rdi, inputFormat
  mov rsi, message
  mov rax, 0
  call scanf

  ; printf(keyInput)
  mov rdi, keyInput
  mov rax, 0
  call printf

  ;scanf("%s", key)
  mov rdi, inputFormat
  mov rsi, key
  mov rax, 0
  call scanf

  ;decrypt(message, key)
  mov rdi, message
  mov rsi, key
  mov rax, 0
  call decrypt

  ;printf("Encrypted message: %s\n", message)
  mov rdi, messageOutput
  mov rsi, message
  mov rax, 0
  call printf

  endOfProgram:
    mov rax, 0
    ret

section .data
  messageInput    db "Enter the encrypted message: ", 0
  keyInput        db "Enter the key: ", 0
  messageOutput   db "Encrypted message: %s", 0ah, 0dh, 0
  inputFormat     db "%s", 0
  a               db 'A'
  z               db 'Z'
  num             dq 26

section .bss
  message:        resb 101
  key:            resb 101
