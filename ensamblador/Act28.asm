; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que realiza
;              operaciones de establecer, borrar y alternar bits.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def operaciones_bits(a, bit_pos):
;     # Establecer el bit en la posición indicada (ponerlo a 1)
;     set_bit = a | (1 << bit_pos)
;     
;     # Borrar el bit en la posición indicada (ponerlo a 0)
;     clear_bit = a & ~(1 << bit_pos)
;     
;     # Alternar el bit en la posición indicada (invertirlo)
;     toggle_bit = a ^ (1 << bit_pos)
;     
;     return set_bit, clear_bit, toggle_bit
; 
; a = 5  # 0101 en binario
; bit_pos = 1  # Operar sobre el segundo bit (posición 1)
; set_bit, clear_bit, toggle_bit = operaciones_bits(a, bit_pos)
; print(f"Set bit: {set_bit}, Clear bit: {clear_bit}, Toggle bit: {toggle_bit}")
; ----------------------------------------------

section .data
    ; Definir un número para operar (en binario 5 = 0101)
    num db 5         ; 0101 en binario
    bit_pos db 1     ; Posición del bit que vamos a operar
    msg_set db "Set bit: ", 0
    msg_clear db "Clear bit: ", 0
    msg_toggle db "Toggle bit: ", 0

section .bss
    result_set resb 4    ; Espacio para almacenar el resultado de Set bit
    result_clear resb 4  ; Espacio para almacenar el resultado de Clear bit
    result_toggle resb 4 ; Espacio para almacenar el resultado de Toggle bit

section .text
    global _start

_start:
    ; Cargar el número para operar (5)
    mov al, [num]       ; Cargar num (5)

    ; Cargar la posición del bit
    mov cl, [bit_pos]   ; Cargar bit_pos (1)

    ; Establecer el bit (ponerlo a 1)
    mov bl, 1           ; Cargar 1 en bl
    shl bl, cl          ; Desplazar 1 a la posición del bit (1 << bit_pos)
    or al, bl           ; AL = AL | (1 << bit_pos)
    mov [result_set], al ; Almacenar el resultado de Set bit

    ; Imprimir el resultado de Set bit
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    lea ecx, [msg_set]     ; Mensaje para el resultado de Set bit
    mov edx, len msg_set
    int 0x80               ; Llamada al sistema

    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result_set]  ; Cargar el resultado de Set bit
    mov edx, 4
    int 0x80               ; Imprimir el resultado de Set bit

    ; Borrar el bit (ponerlo a 0)
    mov al, [num]         ; Recargar num (5)
    mov bl, 1             ; Cargar 1 en bl
    shl bl, cl            ; Desplazar 1 a la posición del bit (1 << bit_pos)
    not bl                ; Invertir los bits de bl (poner 0 en la posición del bit)
    and al, bl            ; AL = AL & ~(1 << bit_pos)
    mov [result_clear], al ; Almacenar el resultado de Clear bit

    ; Imprimir el resultado de Clear bit
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    lea ecx, [msg_clear]   ; Mensaje para el resultado de Clear bit
    mov edx, len msg_clear
    int 0x80               ; Llamada al sistema

    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result_clear] ; Cargar el resultado de Clear bit
    mov edx, 4
    int 0x80               ; Imprimir el resultado de Clear bit

    ; Alternar el bit (invertirlo)
    mov al, [num]         ; Recargar num (5)
    mov bl, 1             ; Cargar 1 en bl
    shl bl, cl            ; Desplazar 1 a la posición del bit (1 << bit_pos)
    xor al, bl            ; AL = AL ^ (1 << bit_pos)
    mov [result_toggle], al ; Almacenar el resultado de Toggle bit

    ; Imprimir el resultado de Toggle bit
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    lea ecx, [msg_toggle]  ; Mensaje para el resultado de Toggle bit
    mov edx, len msg_toggle
    int 0x80               ; Llamada al sistema

    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result_toggle] ; Cargar el resultado de Toggle bit
    mov edx, 4
    int 0x80               ; Imprimir el resultado de Toggle bit

fin:
    ; Salir
    mov eax, 1             ; Llamada para salir
    xor ebx, ebx           ; Código de salida 0
    int 0x80

section .data
    msg_set db "Set bit: ", 0
    msg_clear db "Clear bit: ", 0
    msg_toggle db "Toggle bit: ", 0
