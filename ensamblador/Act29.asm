; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que cuenta los bits activados (bits en 1)
;              en un número.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def contar_bits_activados(n):
;     count = 0
;     while n:
;         count += n & 1  # Agrega 1 al conteo si el bit menos significativo es 1
;         n >>= 1         # Desplaza a la derecha para verificar el siguiente bit
;     return count
; 
; numero = 29  # Ejemplo: 29 en binario es 11101, tiene 4 bits en 1
; print("Bits activados:", contar_bits_activados(numero))
; ----------------------------------------------

section .data
    num db 29               ; Número a evaluar (29 en binario es 11101)
    msg db "Bits activados: ", 0

section .bss
    count resb 1            ; Espacio para almacenar el conteo de bits activados

section .text
    global _start

_start:
    ; Cargar el número a evaluar
    mov al, [num]           ; Cargar el valor de num en AL
    xor bl, bl              ; Reiniciar el contador de bits en BL

count_bits:
    ; Verificar si el bit menos significativo es 1
    test al, 1              ; Realiza una operación AND con 1
    jz skip_increment       ; Si el resultado es 0, no incrementar el contador
    inc bl                  ; Incrementa el contador si el bit es 1

skip_increment:
    ; Desplazar a la derecha para verificar el siguiente bit
    shr al, 1               ; Desplazar AL una posición a la derecha
    jnz count_bits          ; Repetir mientras haya bits por verificar

    ; Almacenar el resultado en 'count'
    mov [count], bl         ; Guardar el total de bits en 1

    ; Imprimir el mensaje
    mov eax, 4              ; Llamada al sistema para escribir
    mov ebx, 1              ; Escribir en salida estándar (stdout)
    lea ecx, [msg]          ; Mensaje de salida
    mov edx, len msg
    int 0x80                ; Llamada al sistema

    ; Imprimir el conteo de bits activados
    mov eax, 4              ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [count]        ; Cargar el conteo de bits activados
    mov edx, 1
    int 0x80                ; Imprimir el conteo

    ; Salir
    mov eax, 1              ; Llamada para salir
    xor ebx, ebx            ; Código de salida 0
    int 0x80
