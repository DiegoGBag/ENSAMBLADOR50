; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que calcula
;              la potencia de un número (x^n).
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def calcular_potencia(base, exponente):
;     resultado = 1
;     while exponente > 0:
;         resultado *= base
;         exponente -= 1
;     return resultado
;
; base = 2
; exponente = 3
; print("Resultado:", calcular_potencia(base, exponente))  # Resultado: 8
; ----------------------------------------------

section .data
    base db 2                 ; Base (x = 2)
    exponente db 3            ; Exponente (n = 3)
    msg db "Resultado: ", 0

section .bss
    resultado resb 1          ; Espacio para almacenar el resultado

section .text
    global _start

_start:
    ; Inicializar el resultado en 1
    mov al, 1                 ; AL almacena el resultado
    mov bl, [base]            ; Cargar la base en BL
    mov cl, [exponente]       ; Cargar el exponente en CL

calcular_potencia:
    cmp cl, 0                 ; Comprobar si el exponente es 0
    je fin_calculo            ; Si CL es 0, terminamos el cálculo

    imul al, bl               ; Multiplicar el resultado actual por la base
    dec cl                    ; Decrementar el exponente
    jmp calcular_potencia     ; Repetir el proceso

fin_calculo:
    ; Guardar el resultado en la variable 'resultado'
    mov [resultado], al

    ; Imprimir el mensaje "Resultado: "
    mov eax, 4                ; Llamada al sistema para escribir
    mov ebx, 1                ; Escribir en salida estándar (stdout)
    lea ecx, [msg]            ; Mensaje para resultado
    mov edx, len msg
    int 0x80                  ; Llamada al sistema

    ; Imprimir el resultado de la potencia
    mov eax, 4                ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [resultado]      ; Cargar el resultado de la potencia
    mov edx, 1                ; Tamaño del resultado
    int 0x80                  ; Imprimir el resultado

    ; Salir
    mov eax, 1                ; Llamada para salir
    xor ebx, ebx              ; Código de salida 0
    int 0x80
