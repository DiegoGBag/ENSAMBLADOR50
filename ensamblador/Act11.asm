; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para verificar 
;              si una cadena es un palíndromo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def es_palindromo(cadena):
;     return cadena == cadena[::-1]
; 
; cadena = "anilina"
; if es_palindromo(cadena):
;     print("La cadena es un palíndromo.")
; else:
;     print("La cadena no es un palíndromo.")
; ----------------------------------------------

section .data
    mensaje db "anilina", 0            ; Cadena a verificar
    msg_palindromo db "La cadena es un palíndromo", 0
    msg_no_palindromo db "La cadena no es un palíndromo", 0

section .bss
    longitud resb 4                    ; Longitud de la cadena
    mitad resb 4                       ; Mitad de la longitud
    i resb 4                           ; Índice para recorrer la cadena

section .text
    global _start

_start:
    ; Calcular la longitud de la cadena
    lea rsi, [mensaje]                 ; Cargar la dirección de la cadena en rsi
    xor rcx, rcx                       ; Contador para la longitud

calcular_longitud:
    cmp byte [rsi + rcx], 0            ; Comparar con el byte nulo (fin de cadena)
    je longitud_calculada              ; Si es el fin de la cadena, detener el conteo
    inc rcx                            ; Incrementar la longitud
    jmp calcular_longitud

longitud_calculada:
    mov [longitud], rcx                ; Guardar la longitud de la cadena
    shr rcx, 1                         ; Dividir la longitud entre 2 para comparar
    mov [mitad], rcx                   ; Guardar la mitad de la longitud
    xor rdi, rdi                       ; Índice inicial (i = 0)

verificar_palindromo:
    ; Comparar el carácter en la posición i con el carácter en la posición (longitud - i - 1)
    mov al, [mensaje + rdi]            ; Cargar el carácter desde el inicio
    mov bl, [mensaje + rcx - rdi - 1]  ; Cargar el carácter desde el final
    cmp al, bl                         ; Comparar los dos caracteres
    jne no_palindromo                  ; Si no coinciden, no es palíndromo

    inc rdi                            ; Incrementar índice
    cmp rdi, [mitad]                   ; Comparar índice con la mitad
    jl verificar_palindromo            ; Si aún no se llega a la mitad, continuar

    ; La cadena es un palíndromo
es_palindromo:
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en salida estándar (stdout)
    mov ecx, msg_palindromo            ; Mensaje "La cadena es un palíndromo"
    mov edx, len msg_palindromo        ; Longitud del mensaje
    int 0x80                           ; Llamada a la interrupción del sistema
    jmp fin

no_palindromo:
    ; La cadena no es un palíndromo
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en salida estándar (stdout)
    mov ecx, msg_no_palindromo         ; Mensaje "La cadena no es un palíndromo"
    mov edx, len msg_no_palindromo     ; Longitud del mensaje
    int 0x80                           ; Llamada a la interrupción del sistema

fin:
    ; Salir
    mov eax, 1                         ; Llamada para salir
    xor ebx, ebx                       ; Código de salida 0
    int 0x80

