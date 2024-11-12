; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que convierte
;              un valor ASCII a su valor entero.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def ascii_a_entero(caracter):
;     return ord(caracter)
;
; caracter = '5'
; entero = ascii_a_entero(caracter)
; print(f"El valor entero de '{caracter}' es: {entero}")
; ----------------------------------------------

section .data
    ; Definir el valor ASCII de un carácter (por ejemplo, '5' -> 53 en ASCII)
    ascii_char db '5'  ; Caracter a convertir (ASCII)
    msg_resultado db "El valor entero es: ", 0

section .bss
    resultado resb 4    ; Espacio para almacenar el valor entero

section .text
    global _start

_start:
    ; Imprimir mensaje de salida
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1               ; Escribir en salida estándar (stdout)
    lea ecx, [msg_resultado] ; Mensaje "El valor entero es: "
    mov edx, len msg_resultado
    int 0x80                 ; Llamada a la interrupción del sistema

    ; Convertir el valor ASCII a su valor entero
    mov al, [ascii_char]     ; Cargar el carácter ASCII
    sub al, '0'              ; Restar el valor ASCII de '0' (48) para obtener el valor numérico
    mov [resultado], al      ; Almacenar el valor entero resultante

    ; Imprimir el valor entero
    mov al, [resultado]      ; Cargar el valor entero
    add al, '0'              ; Convertirlo de nuevo a su valor ASCII
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1
    mov edx, 1
    int 0x80                 ; Imprimir el número

fin:
    ; Salir
    mov eax, 1               ; Llamada para salir
    xor ebx, ebx             ; Código de salida 0
    int 0x80
