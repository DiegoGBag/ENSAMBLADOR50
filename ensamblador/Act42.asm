; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que convierte
;              un número hexadecimal a decimal.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def hexadecimal_a_decimal(hexadecimal):
;     return int(hexadecimal, 16)
;
; numero_hexadecimal = "ff"
; print(f"Decimal: {hexadecimal_a_decimal(numero_hexadecimal)}")  # Resultado: 255
; ----------------------------------------------

section .data
    hexadecimal db 'ff', 0            ; Número hexadecimal a convertir (ejemplo: "ff")
    msg db "Decimal: ", 0
    newline db 10, 0                  ; Nueva línea
    hex_chars db "0123456789ABCDEF"    ; Caracteres hexadecimales

section .bss
    decimal resb 4                    ; Variable para almacenar el número decimal
    idx resb 1                        ; Índice para recorrer los dígitos hexadecimales
    temp resb 1                       ; Variable temporal para almacenar el valor numérico de un dígito hexadecimal

section .text
    global _start

_start:
    ; Inicializar el número decimal en 0
    mov byte [decimal], 0

    ; Recorrer el número hexadecimal de izquierda a derecha
    lea rsi, [hexadecimal]            ; Cargar la dirección de la cadena hexadecimal
    mov byte [idx], 0                 ; Inicializar el índice en 0

convertir_a_decimal:
    mov al, [rsi + byte [idx]]        ; Cargar el siguiente dígito hexadecimal
    cmp al, 0                         ; Si llegamos al final de la cadena, terminamos
    je fin_conversion

    ; Convertir el carácter hexadecimal en valor numérico (0-15)
    sub al, '0'                       ; Convertir a número si es entre '0' y '9'
    cmp al, 9
    jg es_letra                       ; Si el valor es mayor que 9, es una letra A-F
    jmp siguiente

es_letra:
    sub al, 7                         ; Convertir A-F a valores numéricos (10-15)

siguiente:
    ; Multiplicar el número decimal por 16 (desplazar a la izquierda en base 16)
    mov bl, byte [decimal]
    mov ah, 16
    imul ax, ah                       ; Multiplicar decimal por 16
    add byte [decimal], al            ; Sumar el valor del dígito hexadecimal al resultado

    inc byte [idx]                    ; Incrementar el índice para el siguiente dígito
    jmp convertir_a_decimal

fin_conversion:
    ; Imprimir el mensaje "Decimal: "
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en stdout
    lea ecx, [msg]
    mov edx, len msg
    int 0x80

    ; Imprimir el número decimal
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en stdout
    lea ecx, [decimal]
    mov edx, 4                         ; Tamaño del número decimal
    int 0x80

    ; Imprimir nueva línea
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en stdout
    lea ecx, [newline]
    mov edx, 1
    int 0x80

; Salir del programa
    mov eax, 1                         ; Llamada para salir
    xor ebx, ebx                       ; Código de salida 0
    int 0x80
