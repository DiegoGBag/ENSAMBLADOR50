; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para calcular 
;              la suma de los N primeros números naturales.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def suma_numeros_naturales(n):
;     if n < 1:
;         return 0
;     return n * (n + 1) // 2
; 
; n = 10
; resultado = suma_numeros_naturales(n)
; print("La suma de los primeros", n, "números naturales es:", resultado)
; ----------------------------------------------

section .data
    msg db "La suma de los primeros N números naturales es: ", 0
    format db "%d", 0 ; Formato para imprimir enteros

section .bss
    n resb 4           ; Número hasta el cual sumar (N)
    suma resb 4        ; Resultado de la suma

section .text
    global _start

_start:
    ; Definir el valor de N (ejemplo: N = 10)
    mov eax, 10          ; Almacena 10 en eax, el valor de N

    ; Calcular la suma de los primeros N números naturales
    ; Usando la fórmula: S = N * (N + 1) / 2
    mov ebx, eax         ; Copia el valor de N en ebx
    add eax, 1           ; Calcula N + 1
    imul eax, ebx        ; Multiplica N * (N + 1)
    mov ebx, 2           ; Divisor para dividir entre 2
    idiv ebx             ; Divide eax entre 2, el resultado queda en eax

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
