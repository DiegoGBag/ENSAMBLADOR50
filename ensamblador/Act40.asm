; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que convierte
;              un número binario a decimal.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def binario_a_decimal(binario):
;     decimal = 0
;     for i, bit in enumerate(reversed(binario)):
;         decimal += int(bit) * (2 ** i)
;     return decimal
;
; binario = "1010"
; print(f"Decimal: {binario_a_decimal(binario)}")  # Resultado: 10
; ----------------------------------------------

section .data
    binario db '1010', 0            ; Número binario a convertir (ejemplo: "1010")
    msg db "Decimal: ", 0
    newline db 10, 0                ; Nueva línea

section .bss
    decimal resb 4                  ; Variable para almacenar el número decimal (4 bytes)
    idx resb 1                      ; Índice para recorrer los bits
    temp resb 1                     ; Variable temporal para multiplicación de bits

section .text
    global _start

_start:
    ; Inicializar el número decimal en 0
    mov byte [decimal], 0

    ; Recorrer el número binario de derecha a izquierda
    lea rsi, [binario]              ; Cargar la dirección de la cadena binaria
    mov byte [idx], 0               ; Inicializar el índice en 0

convertir_a_decimal:
    ; Cargar el siguiente bit de la cadena binaria
    mov al, [rsi + byte [idx]]
    cmp al, 0                       ; Si llegamos al final de la cadena, terminamos
    je fin_conversion

    ; Convertir el carácter '0' o '1' en número (restando '0')
    sub al, '0'

    ; Obtener el valor de 2^idx (potencia de 2)
    mov cl, byte [idx]              ; Cargar el índice
    mov bl, 2
    mov ah, 1                       ; Inicializar potencia de 2 como 1
potencia_de_2:
    shl ah, 1                       ; Multiplicar por 2
    dec cl
    jnz potencia_de_2

    ; Multiplicar el bit por 2^idx y sumar al resultado decimal
    imul ax, byte [decimal]         ; Multiplicar el valor actual de decimal por 2^idx
    add [decimal], ax               ; Sumar el valor resultante

    inc byte [idx]                  ; Incrementar el índice
    jmp convertir_a_decimal

fin_conversion:
    ; Imprimir el mensaje "Decimal: "
    mov eax, 4                       ; Llamada al sistema para escribir
    mov ebx, 1                       ; Escribir en stdout
    lea ecx, [msg]
    mov edx, len msg
    int 0x80

    ; Imprimir el número decimal
    mov eax, 4                       ; Llamada al sistema para escribir
    mov ebx, 1                       ; Escribir en stdout
    lea ecx, [decimal]
    mov edx, 4                       ; Tamaño del número decimal
    int 0x80

    ; Imprimir nueva línea
    mov eax, 4                       ; Llamada al sistema para escribir
    mov ebx, 1                       ; Escribir en stdout
    lea ecx, [newline]
    mov edx, 1
    int 0x80

; Salir del programa
    mov eax, 1                       ; Llamada para salir
    xor ebx, ebx                     ; Código de salida 0
    int 0x80
