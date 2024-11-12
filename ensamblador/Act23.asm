; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que convierte
;              un valor entero a su valor ASCII.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def entero_a_ascii(entero):
;     return chr(entero)
;
; entero = 53
; ascii_char = entero_a_ascii(entero)
; print(f"El valor ASCII de {entero} es: '{ascii_char}'")
; ----------------------------------------------

section .data
    ; Definir un valor entero (por ejemplo, 53 corresponde al carácter '5')
    entero db 53  ; Valor entero a convertir
    msg_resultado db "El valor ASCII es: ", 0

section .bss
    resultado resb 1    ; Espacio para almacenar el valor ASCII

section .text
    global _start

_start:
    ; Imprimir mensaje de salida
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1               ; Escribir en salida estándar (stdout)
    lea ecx, [msg_resultado] ; Mensaje "El valor ASCII es: "
    mov edx, len msg_resultado
    int 0x80                 ; Llamada a la interrupción del sistema

    ; Convertir el valor entero a su correspondiente valor ASCII
    mov al, [entero]         ; Cargar el valor entero
    add al, '0'              ; Convertir el valor a su equivalente ASCII
    mov [resultado], al      ; Almacenar el valor ASCII resultante

    ; Imprimir el valor ASCII
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [resultado]     ; Cargar el carácter ASCII
    mov edx, 1
    int 0x80                 ; Imprimir el carácter

fin:
    ; Salir
    mov eax, 1               ; Llamada para salir
    xor ebx, ebx             ; Código de salida 0
    int 0x80
