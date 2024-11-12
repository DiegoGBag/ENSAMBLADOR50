; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para dividir 
;              dos números. Se incluye una versión 
;              en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def dividir(a, b):
;     if b == 0:
;         raise ValueError("El divisor no puede ser cero.")
;     return a / b
; 
; a = 20
; b = 4
; resultado = dividir(a, b)
; print("La división es:", resultado)
; ----------------------------------------------

section .data
    msg db "La división es: ", 0
    format db "%d", 0 ; Formato para imprimir enteros

section .bss
    num1 resb 4       ; Primer número (dividendo)
    num2 resb 4       ; Segundo número (divisor)
    cociente resb 4   ; Resultado de la división

section .text
    global _start

_start:
    ; Cargar los números a dividir (ejemplo: 20 / 4)
    mov eax, 20          ; Almacena el valor 20 en eax (dividendo)
    mov ebx, 4           ; Almacena el valor 4 en ebx (divisor)

    ; Verificar si el divisor es cero
    cmp ebx, 0
    je error_division    ; Si es cero, salta a manejar el error

    ; Realizar la división
    cdq                  ; Extiende el signo de eax a edx para división
    idiv ebx             ; Divide edx:eax por ebx, resultado en eax

    ; Almacenar el cociente
    mov [cociente], eax

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

error_division:
    ; Manejar el caso de división por cero
    ; Aquí podrías agregar un mensaje de error o manejar el caso apropiadamente
    mov eax, 1           ; Llamada para salir
    mov ebx, 1           ; Código de salida 1 (indicando error)
    int 0x80
