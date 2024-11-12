; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que realiza
;              operaciones AND, OR, XOR a nivel de bits.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def operaciones_bits(a, b):
;     and_result = a & b
;     or_result = a | b
;     xor_result = a ^ b
;     return and_result, or_result, xor_result
;
; a = 5  # 0101 en binario
; b = 3  # 0011 en binario
; and_result, or_result, xor_result = operaciones_bits(a, b)
; print(f"AND: {and_result}, OR: {or_result}, XOR: {xor_result}")
; ----------------------------------------------

section .data
    ; Definir dos números para operar (en binario 5 = 0101, 3 = 0011)
    num1 db 5         ; 0101 en binario
    num2 db 3         ; 0011 en binario
    msg_and db "AND Result: ", 0
    msg_or db "OR Result: ", 0
    msg_xor db "XOR Result: ", 0

section .bss
    result_and resb 4    ; Espacio para almacenar el resultado de AND
    result_or resb 4     ; Espacio para almacenar el resultado de OR
    result_xor resb 4    ; Espacio para almacenar el resultado de XOR

section .text
    global _start

_start:
    ; Cargar los números a operar
    mov al, [num1]   ; Cargar num1 (5)
    mov bl, [num2]   ; Cargar num2 (3)

    ; Operación AND
    and al, bl        ; AL = AL AND BL (5 & 3)
    mov [result_and], al  ; Almacenar el resultado de AND (5 & 3 = 1)

    ; Imprimir el resultado de AND
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    lea ecx, [msg_and]     ; Mensaje para el resultado de AND
    mov edx, len msg_and
    int 0x80               ; Llamada al sistema

    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result_and]  ; Cargar el resultado de AND
    mov edx, 4
    int 0x80               ; Imprimir el resultado de AND

    ; Operación OR
    mov al, [num1]   ; Recargar num1 (5)
    mov bl, [num2]   ; Recargar num2 (3)
    or al, bl        ; AL = AL OR BL (5 | 3)
    mov [result_or], al  ; Almacenar el resultado de OR (5 | 3 = 7)

    ; Imprimir el resultado de OR
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    lea ecx, [msg_or]      ; Mensaje para el resultado de OR
    mov edx, len msg_or
    int 0x80               ; Llamada al sistema

    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result_or]   ; Cargar el resultado de OR
    mov edx, 4
    int 0x80               ; Imprimir el resultado de OR

    ; Operación XOR
    mov al, [num1]   ; Recargar num1 (5)
    mov bl, [num2]   ; Recargar num2 (3)
    xor al, bl       ; AL = AL XOR BL (5 ^ 3)
    mov [result_xor], al  ; Almacenar el resultado de XOR (5 ^ 3 = 6)

    ; Imprimir el resultado de XOR
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    lea ecx, [msg_xor]     ; Mensaje para el resultado de XOR
    mov edx, len msg_xor
    int 0x80               ; Llamada al sistema

    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result_xor]  ; Cargar el resultado de XOR
    mov edx, 4
    int 0x80               ; Imprimir el resultado de XOR

fin:
    ; Salir
    mov eax, 1             ; Llamada para salir
    xor ebx, ebx           ; Código de salida 0
    int 0x80

section .data
    msg_and db "AND Result: ", 0
    msg_or db "OR Result: ", 0
    msg_xor db "XOR Result: ", 0
