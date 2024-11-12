; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que calcula el
;              Máximo Común Divisor (MCD) de dos números.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def calcular_mcd(a, b):
;     while b != 0:
;         a, b = b, a % b
;     return a
; 
; numero1 = 48
; numero2 = 18
; print("MCD:", calcular_mcd(numero1, numero2))  # Resultado: 6
; ----------------------------------------------

section .data
    num1 db 48           ; Primer número (48)
    num2 db 18           ; Segundo número (18)
    msg db "MCD: ", 0

section .bss
    result resb 1        ; Espacio para almacenar el resultado del MCD

section .text
    global _start

_start:
    ; Cargar los valores iniciales de num1 y num2
    mov al, [num1]       ; Cargar num1 en AL
    mov bl, [num2]       ; Cargar num2 en BL

calcular_mcd:
    ; Comprobar si bl es 0 (caso base)
    cmp bl, 0
    je fin_calculo       ; Si BL es 0, AL contiene el MCD y terminamos

    ; Calcular a % b
    mov ah, 0            ; Limpiar AH para la división
    div bl               ; AL = AL / BL, el residuo queda en AH
    mov al, bl           ; AL toma el valor de BL (b pasa a ser el nuevo a)
    mov bl, ah           ; BL toma el residuo (nuevo b)

    ; Repetir hasta que el residuo sea 0
    jmp calcular_mcd

fin_calculo:
    ; Almacenar el resultado del MCD
    mov [result], al     ; Guardar el MCD en 'result'

    ; Imprimir el mensaje
    mov eax, 4           ; Llamada al sistema para escribir
    mov ebx, 1           ; Escribir en salida estándar (stdout)
    lea ecx, [msg]       ; Mensaje para MCD
    mov edx, len msg
    int 0x80             ; Llamada al sistema

    ; Imprimir el resultado del MCD
    mov eax, 4           ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result]    ; Cargar el resultado del MCD
    mov edx, 1
    int 0x80             ; Imprimir el MCD

    ; Salir
    mov eax, 1           ; Llamada para salir
    xor ebx, ebx         ; Código de salida 0
    int 0x80
