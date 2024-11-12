; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que convierte
;              un número decimal a hexadecimal.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def decimal_a_hexadecimal(decimal):
;     return hex(decimal)[2:]  # Usamos hex() para obtener la cadena hexadecimal
;
; numero_decimal = 255
; print(f"Hexadecimal: {decimal_a_hexadecimal(numero_decimal)}")  # Resultado: "ff"
; ----------------------------------------------

section .data
    decimal db 255                ; Número decimal a convertir (ejemplo: 255)
    hex_chars db "0123456789ABCDEF"  ; Caracteres hexadecimales
    msg db "Hexadecimal: ", 0
    newline db 10, 0              ; Nueva línea

section .bss
    hex_result resb 8             ; Arreglo para almacenar el número hexadecimal (hasta 8 dígitos)
    idx resb 1                    ; Índice para almacenar los dígitos hexadecimales
    temp resb 1                   ; Variable temporal para almacenar el residuo

section .text
    global _start

_start:
    mov al, [decimal]             ; Cargar el número decimal en AL
    mov byte [idx], 7             ; Comenzar desde el dígito más significativo en el arreglo hex_result

convertir_a_hexadecimal:
    mov ah, 0                     ; Limpiar AH para dividir
    mov al, [decimal]             ; Cargar el número decimal actual en AL
    mov cl, 16                    ; Dividir entre 16
    div cl                        ; AL = AL / 16, AH = residuo (dígito hexadecimal)
    mov dl, ah                    ; Guardar el residuo en DL
    add dl, '0'                   ; Convertir a carácter (restar '0' para '0' a '9')
    cmp dl, '9'                   ; Si el dígito es mayor que 9, ajustamos para 'A' a 'F'
    jl siguiente
    add dl, 7                     ; Convertir 10-15 en A-F

siguiente:
    mov [hex_result + byte [idx]], dl  ; Almacenar el dígito en el arreglo
    mov bl, al                    ; Actualizar el número decimal para la siguiente iteración
    dec byte [idx]                 ; Decrementar índice para el siguiente dígito

    cmp bl, 0                      ; Si el número es 0, terminamos
    jne convertir_a_hexadecimal

; Imprimir el mensaje "Hexadecimal: "
    mov eax, 4                    ; Llamada al sistema para escribir
    mov ebx, 1                    ; Escribir en stdout
    lea ecx, [msg]
    mov edx, len msg
    int 0x80

; Imprimir cada dígito del arreglo hexadecimal
    mov ecx, 8                    ; 8 dígitos posibles (hasta 8 bytes)
imprimir_hexadecimal:
    mov al, [hex_result + ecx - 1] ; Cargar el siguiente dígito hexadecimal
    add al, 0                      ; Convertir a carácter
    mov eax, 4                    ; Llamada al sistema para escribir
    mov ebx, 1                    ; Escribir en stdout
    mov edx, 1                    ; Tamaño del carácter
    int 0x80

    loop imprimir_hexadecimal     ; Repetir hasta imprimir todos los dígitos

; Imprimir nueva línea
    mov eax, 4                    ; Llamada al sistema para escribir
    mov ebx, 1                    ; Escribir en stdout
    lea ecx, [newline]
    mov edx, 1
    int 0x80

; Salir del programa
    mov eax, 1                    ; Llamada para salir
    xor ebx, ebx                  ; Código de salida 0
    int 0x80
