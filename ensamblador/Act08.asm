; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para calcular 
;              la serie de Fibonacci hasta el n-ésimo término.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def fibonacci(n):
;     a, b = 0, 1
;     for _ in range(n):
;         print(a, end=" ")
;         a, b = b, a + b
; 
; n = 10
; fibonacci(n)
; ----------------------------------------------

section .data
    msg db "Serie de Fibonacci: ", 0
    format db "%d ", 0     ; Formato para imprimir enteros con espacio

section .bss
    n resb 4               ; Número de términos de Fibonacci a generar
    a resb 4               ; Almacena el término actual de la serie
    b resb 4               ; Almacena el siguiente término de la serie
    temp resb 4            ; Variable temporal para el cálculo

section .text
    global _start

_start:
    ; Definir el valor de N (ejemplo: N = 10)
    mov ecx, 10            ; Número de términos a generar (N)
    mov eax, 0             ; Primer término de Fibonacci (a = 0)
    mov ebx, 1             ; Segundo término de Fibonacci (b = 1)

fibonacci_loop:
    ; Imprimir el valor actual de 'a' (término de Fibonacci)
    ; Para este ejemplo, solo mostramos cómo almacenar e imprimir
    push eax               ; Guardar eax en la pila para imprimir
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    mov ecx, msg           ; Mensaje a imprimir
    mov edx, len msg       ; Longitud del mensaje
    int 0x80               ; Llamada a la interrupción del sistema
    pop eax                ; Recupera el valor de eax

    ; Calcular el siguiente término de Fibonacci
    mov esi, eax           ; Copiar a (eax) en esi (temporal)
    add eax, ebx           ; Siguiente término: a = a + b
    mov ebx, esi           ; Actualizar b al valor antiguo de a

    ; Decrementar el contador y repetir el ciclo
    loop fibonacci_loop    ; Repite el ciclo si quedan términos

    ; Salir
    mov eax, 1             ; Llamada para salir
    xor ebx, ebx           ; Código de salida 0
    int 0x80
