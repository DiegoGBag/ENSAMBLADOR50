; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que convierte
;              un número decimal a binario.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def decimal_a_binario(decimal):
;     binario = ""
;     while decimal > 0:
;         binario = str(decimal % 2) + binario
;         decimal //= 2
;     return binario if binario else "0"
;
; numero_decimal = 10
; print(f"Binario: {decimal_a_binario(numero_decimal)}")  # Resultado: "1010"
; ----------------------------------------------

section .data
    decimal db 10                 ; Número decimal a convertir (ejemplo: 10)
    binario db 8 dup(0)           ; Arreglo para almacenar el número binario (hasta 8 bits)
    msg db "Binario: ", 0
    newline db 10, 0              ; Nueva línea

section .bss
    idx resb 1                    ; Índice para almacenar bits en el arreglo binario
    temp resb 1                   ; Variable temporal para dividir el número

section .text
    global _start

_start:
    mov al, [decimal]             ; Cargar el número decimal en AL
    mov bl, al                    ; Copiar el número a BL para operaciones
    mov byte [idx], 7             ; Comenzar desde el bit más significativo en el arreglo

convertir_a_binario:
    mov ah, 0                     ; Limpiar AH para dividir
    mov al, bl                    ; Mover el número decimal actual a AL
    mov cl, 2                     ; Dividir entre 2
    div cl                        ; AL = AL / 2, AH = residuo (bit menos significativo)
    mov [binario + idx], ah       ; Almacenar el residuo en el arreglo binario
    mov bl, al                    ; Actualizar el número decimal para la siguiente iteración
    dec byte [idx]                ; Decrementar índice para siguiente bit

    cmp bl, 0                     ; Si el número es 0, terminamos
    jne convertir_a_binario

; Imprimir el mensaje "Binario: "
    mov eax, 4                    ; Llamada al sistema para escribir
    mov ebx, 1                    ; Escribir en stdout
    lea ecx, [msg]
    mov edx, len msg
    int 0x80

; Imprimir cada bit del arreglo binario
    mov ecx, 8                    ; 8 bits a imprimir
imprimir_binario:
    mov al, [binario + ecx - 1]   ; Cargar el bit desde el arreglo
    add al, '0'                   ; Convertir a carácter ('0' o '1')
    mov eax, 4                    ; Llamada al sistema para escribir
    mov ebx, 1                    ; Escribir en stdout
    mov edx, 1                    ; Tamaño del carácter
    int 0x80

    loop imprimir_binario          ; Repetir hasta imprimir todos los bits

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
