; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que calcula
;              la longitud de una cadena de caracteres.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def longitud_cadena(cadena):
;     return len(cadena)
;
; cadena = "Hola"
; longitud = longitud_cadena(cadena)
; print(f"La longitud de la cadena '{cadena}' es: {longitud}")
; ----------------------------------------------

section .data
    ; Definir la cadena (terminada en null)
    cadena db 'Hola', 0  ; Cadena de caracteres terminada en null (0)

section .bss
    longitud resb 4   ; Espacio para almacenar la longitud de la cadena

section .text
    global _start

_start:
    ; Inicializar registros
    xor ecx, ecx          ; ECX será el contador de la longitud (comienza en 0)

    ; Bucle para recorrer la cadena hasta encontrar el null terminator (0)
count_loop:
    mov al, [cadena + ecx]  ; Cargar el carácter de la cadena en AL
    cmp al, 0               ; Comparar con null (0)
    je done                 ; Si es null, hemos llegado al final
    inc ecx                 ; Si no es null, incrementar el contador
    jmp count_loop          ; Repetir el bucle

done:
    ; Almacenar la longitud de la cadena en la variable longitud
    mov [longitud], ecx

    ; Imprimir el mensaje de resultado
    mov eax, 4              ; Llamada al sistema para escribir
    mov ebx, 1              ; Escribir en salida estándar (stdout)
    lea ecx, [msg_resultado]; Mensaje de salida
    mov edx, len msg_resultado
    int 0x80                ; Llamada al sistema

    ; Imprimir la longitud
    mov eax, 4              ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [longitud]     ; Cargar la longitud
    mov edx, 4              ; Longitud del valor (4 bytes)
    int 0x80                ; Imprimir la longitud

fin:
    ; Salir
    mov eax, 1              ; Llamada para salir
    xor ebx, ebx            ; Código de salida 0
    int 0x80
