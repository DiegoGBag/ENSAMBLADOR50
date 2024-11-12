; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para calcular 
;              el factorial de un número. 
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def factorial(n):
;     if n == 0 or n == 1:
;         return 1
;     resultado = 1
;     for i in range(2, n + 1):
;         resultado *= i
;     return resultado
; 
; n = 5
; resultado = factorial(n)
; print("El factorial de", n, "es:", resultado)
; ----------------------------------------------

section .data
    msg db "El factorial es: ", 0
    format db "%d", 0 ; Formato para imprimir enteros

section .bss
    n resb 4           ; Número del cual calcular el factorial
    factorial resb 4   ; Resultado del factorial

section .text
    global _start

_start:
    ; Definir el valor de N (ejemplo: N = 5)
    mov eax, 5           ; Almacena 5 en eax, el valor de N
    mov ebx, eax         ; Copia el valor de N en ebx para el ciclo
    mov ecx, 1           ; Inicializa ecx como el acumulador del resultado

factorial_loop:
    ; Multiplicar el acumulador (ecx) por ebx
    imul ecx, ebx        ; ecx = ecx * ebx
    dec ebx              ; Decrementa ebx en 1

    ; Terminar el ciclo cuando ebx llegue a 1
    cmp ebx, 1
    jg factorial_loop    ; Si ebx > 1, repetir el ciclo

    ; Almacenar el resultado en factorial
    mov [factorial], ecx

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
