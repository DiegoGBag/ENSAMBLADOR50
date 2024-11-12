; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que realiza
;              operaciones matemáticas simples: 
;              suma, resta, multiplicación y división.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def calcular(op, a, b):
;     if op == 'suma':
;         return a + b
;     elif op == 'resta':
;         return a - b
;     elif op == 'multiplicacion':
;         return a * b
;     elif op == 'division':
;         return a / b
;     else:
;         return "Operación no válida"
;
; # Ejemplo de uso
; operacion = 'suma'
; num1 = 10
; num2 = 5
; print(f"Resultado de {operacion}: {calcular(operacion, num1, num2)}") 
; ----------------------------------------------

section .data
    msg_suma db "Resultado de la suma: ", 0
    msg_resta db "Resultado de la resta: ", 0
    msg_multiplicacion db "Resultado de la multiplicacion: ", 0
    msg_division db "Resultado de la division: ", 0
    newline db 10, 0                     ; Nueva línea

section .bss
    num1 resb 4                         ; Número 1
    num2 resb 4                         ; Número 2
    resultado resb 4                    ; Resultado

section .text
    global _start

_start:
    ; Ejemplo: operación de suma
    mov byte [num1], 10                 ; Número 1 (ejemplo)
    mov byte [num2], 5                  ; Número 2 (ejemplo)

    ; Operación de suma
    ; Cargar los números
    mov al, [num1]                      ; Cargar num1 en AL
    add al, [num2]                      ; AL = AL + num2
    mov [resultado], al                 ; Guardar el resultado en la variable resultado

    ; Imprimir mensaje de suma
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [msg_suma]
    mov edx, len msg_suma
    int 0x80

    ; Imprimir resultado de suma
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [resultado]
    mov edx, 1                           ; Tamaño de un byte (resultado)
    int 0x80

    ; Salto a nueva línea
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [newline]
    mov edx, 1                           ; Tamaño de un byte
    int 0x80

    ; Operación de resta
    mov al, [num1]                      ; Cargar num1 en AL
    sub al, [num2]                      ; AL = AL - num2
    mov [resultado], al                 ; Guardar el resultado de la resta

    ; Imprimir mensaje de resta
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [msg_resta]
    mov edx, len msg_resta
    int 0x80

    ; Imprimir resultado de resta
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [resultado]
    mov edx, 1                           ; Tamaño de un byte
    int 0x80

    ; Salto a nueva línea
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [newline]
    mov edx, 1                           ; Tamaño de un byte
    int 0x80

    ; Operación de multiplicación
    mov al, [num1]                      ; Cargar num1 en AL
    mov bl, [num2]                      ; Cargar num2 en BL
    mul bl                               ; AL = AL * BL
    mov [resultado], al                 ; Guardar el resultado de la multiplicación

    ; Imprimir mensaje de multiplicación
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [msg_multiplicacion]
    mov edx, len msg_multiplicacion
    int 0x80

    ; Imprimir resultado de multiplicación
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [resultado]
    mov edx, 1                           ; Tamaño de un byte
    int 0x80

    ; Salto a nueva línea
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [newline]
    mov edx, 1                           ; Tamaño de un byte
    int 0x80

    ; Operación de división
    mov al, [num1]                      ; Cargar num1 en AL
    mov bl, [num2]                      ; Cargar num2 en BL
    div bl                               ; AL = AL / BL (cociente)
    mov [resultado], al                 ; Guardar el resultado de la división

    ; Imprimir mensaje de división
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [msg_division]
    mov edx, len msg_division
    int 0x80

    ; Imprimir resultado de división
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [resultado]
    mov edx, 1                           ; Tamaño de un byte
    int 0x80

    ; Salto a nueva línea
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en stdout
    lea ecx, [newline]
    mov edx, 1                           ; Tamaño de un byte
    int 0x80

; Salir del programa
    mov eax, 1                           ; Llamada para salir
    xor ebx, ebx                         ; Código de salida 0
    int 0x80
