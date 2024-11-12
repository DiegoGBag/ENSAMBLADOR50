; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para restar 
;              dos números. Se incluye una versión 
;              en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def restar(a, b):
;     return a - b
; 
; a = 15
; b = 7
; resultado = restar(a, b)
; print("La resta es:", resultado)
; ----------------------------------------------

section .data
    msg db "La resta es: ", 0
    format db "%d", 0 ; Formato para imprimir enteros

section .bss
    num1 resb 4   ; Primer número a restar
    num2 resb 4   ; Segundo número a restar
    resta resb 4  ; Resultado de la resta

section .text
    global _start

_start:
    ; Cargar los números a restar (ejemplo: 15 - 7)
    mov eax, 15          ; Almacena el valor 15 en eax
    mov ebx, 7           ; Almacena el valor 7 en ebx

    ; Realizar la resta
    sub eax, ebx         ; Restar ebx de eax, el resultado queda en eax

    ; Almacenar el resultado
    mov [resta], eax

    ; Imprimir el resultado
    mov eax, 4           ; Llamada al sistema para escribir
    mov ebx, 1           ; Escribir en salida estándar (stdout)
    mov ecx, msg         ; Mensaje a imprimir
    mov edx, len msg     ; Longitud del mensaje
    int 0x80             ; Llamada a la interrupción del sistema

    ; Salir
    mov eax, 1           ; Llamada para salir
    xor ebx, ebx         ; Código de salida 0
    int 0x80
