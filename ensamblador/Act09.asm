; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para verificar 
;              si un número es primo. 
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def es_primo(n):
;     if n <= 1:
;         return False
;     for i in range(2, int(n ** 0.5) + 1):
;         if n % i == 0:
;             return False
;     return True
; 
; n = 29
; if es_primo(n):
;     print(n, "es primo.")
; else:
;     print(n, "no es primo.")
; ----------------------------------------------

section .data
    msg_primo db "El número es primo", 0
    msg_no_primo db "El número no es primo", 0

section .bss
    n resb 4       ; Número a verificar
    i resb 4       ; Variable para el divisor
    sqrt_n resb 4  ; Raíz cuadrada de N (aproximación para límite superior)

section .text
    global _start

_start:
    ; Definir el valor de N (ejemplo: N = 29)
    mov eax, 29         ; Almacena 29 en eax (número a verificar)

    ; Verificar si N es menor o igual a 1
    cmp eax, 1
    jle no_primo        ; Si N <= 1, no es primo

    ; Establecer el valor de i (comenzar desde 2)
    mov ebx, 2

    ; Calcular la raíz cuadrada de N (aproximación)
    ; Usamos un valor arbitrario para simplificar la comparación
    ; Aquí, podrías optimizar el cálculo de la raíz cuadrada si se requiere precisión
    mov ecx, eax
    sqrt_loop:
        imul edx, ecx, ecx ; calcular ecx^2
        cmp edx, eax       ; comparar ecx^2 con N
        jl sqrt_loop       ; Si ecx^2 < N, incrementar
        mov [sqrt_n], ecx  ; guardar la raíz cuadrada aproximada

    ; Verificar si N es divisible por cualquier número entre 2 y sqrt(N)
    verificar_divisor:
        cmp ebx, [sqrt_n]   ; Compara i con la raíz cuadrada de N
        jg es_primo         ; Si i > sqrt(N), N es primo

        ; Verificar si N es divisible por i
        mov edx, 0          ; Limpiar edx antes de la división
        div ebx             ; Dividir eax (N) por ebx (i)
        cmp edx, 0          ; Si el residuo es 0, no es primo
        je no_primo         ; Si N % i == 0, N no es primo

        inc ebx             ; Incrementar el divisor
        jmp verificar_divisor ; Repetir el ciclo

es_primo:
    ; Imprimir que el número es primo
    mov eax, 4            ; Llamada al sistema para escribir
    mov ebx, 1            ; Escribir en salida estándar (stdout)
    mov ecx, msg_primo    ; Mensaje "El número es primo"
    mov edx, len msg_primo ; Longitud del mensaje
    int 0x80              ; Llamada a la interrupción del sistema
    jmp fin

no_primo:
    ; Imprimir que el número no es primo
    mov eax, 4            ; Llamada al sistema para escribir
    mov ebx, 1            ; Escribir en salida estándar (stdout)
    mov ecx, msg_no_primo ; Mensaje "El número no es primo"
    mov edx, len msg_no_primo ; Longitud del mensaje
    int 0x80              ; Llamada a la interrupción del sistema

fin:
    ; Salir
    mov eax, 1            ; Llamada para salir
    xor ebx, ebx          ; Código de salida 0
    int 0x80
