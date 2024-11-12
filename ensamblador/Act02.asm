; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para sumar 
;              dos números. Se incluye una versión 
;              en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def sumar(a, b):
;     return a + b
; 
; a = 5
; b = 10
; resultado = sumar(a, b)
; print("La suma es:", resultado)
; ----------------------------------------------

section .data
    msg db "La suma es: ", 0
    format db "%d", 0 ; Formato para imprimir enteros

section .bss
    num1 resb 4   ; Primer número a sumar
    num2 resb 4   ; Segundo número a sumar
    suma resb 4   ; Resultado de la suma

section .text
    global _start

_start:
    ; Cargar los números a sumar (ejemplo: 5 y 10)
    mov eax, 5           ; Almacena el valor 5 en eax
    mov ebx, 10          ; Almacena el valor 10 en ebx

    ; Realizar la suma
    add eax, ebx         ; Sumar eax y ebx, el resultado queda en eax

    ; Almacenar el resultado
    mov [suma], eax

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
