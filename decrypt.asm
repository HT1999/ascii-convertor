extern printf
extern scanf

global main

section .text

decrypt:
  mov al, [rdi]         ; 1st char of message
  mov ah, [rsi]         ; 1st char of key

  cmp ah, 0             ; key char == null (end of key)
  je keyReset           ; reset key back to first char

  cmp al, 0             ; message char == null (end of message)
  je endOfString        ; end func

  cmp ah, al            ; account for negative offsets
  ja modify1

  cmp ah, al            ; account for positive/0 offsets
  jbe modify2

nextChar:
  inc rdi               ; increment message
  inc rsi               ; increment key
  jmp decrypt

modify1:
  sub al, ah            ; message - key
  add al, [num]         ; (message - key) + 91 ('Z')
  mov [rdi], al         ; copy
  jmp nextChar

modify2:
  sub al, ah            ; message - key
  add al, [a]           ; (message - key) + 65 ('A')
  mov [rdi], al         ; copy
  jmp nextChar


keyReset:               ;start over key
  mov rsi, key
  jmp decrypt

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

  ;encrypt(message, key)
  mov rdi, message
  mov rsi, key
  mov rax, 0
  call decrypt

  ;printf("Decrypted message: %s\n", message)
  mov rdi, messageOutput
  mov rsi, message
  mov rax, 0
  call printf

  endOfProgram:
    mov rax, 0
    ret

section .data
  messageInput    db "Enter the message: ", 0
  keyInput        db "Enter the key: ", 0
  messageOutput   db "Decrypted message: %s", 0ah, 0dh, 0
  inputFormat     db "%s", 0
  a               db 'A'
  z               db 'Z'
  num             dq 91

section .bss
  message:        resb 101
  key:            resb 101
