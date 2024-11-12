; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para invertir 
;              una cadena de texto. 
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def invertir_cadena(cadena):
;     return cadena[::-1]
; 
; cadena = "Hola Mundo"
; resultado = invertir_cadena(cadena)
; print("Cadena invertida:", resultado)
; ----------------------------------------------

section .data
    mensaje db "Hola Mundo", 0    ; Cadena original a invertir
    msg_invertida db "Cadena invertida: ", 0

section .bss
    reversed resb 20             ; Buffer para la cadena invertida
    len_resb resb 4              ; Longitud de la cadena invertida

section .text
    global _start

_start:
    ; Cargar la dirección de la cadena original
    lea rsi, [mensaje]          ; Cargar la dirección de la cadena en rsi
    mov rdi, reversed           ; Dirección de destino (cadena invertida)
    
invertir_cadena:
    ; Leer un byte de la cadena original
    mov al, byte [rsi]          ; Cargar el siguiente byte de la cadena original
    cmp al, 0                   ; Comparar con el byte nulo (fin de la cadena)
    je fin_inversion            ; Si es el fin de la cadena, finalizar

    ; Copiar el byte a la posición de la cadena invertida
    dec rdi                     ; Decrementar la dirección de la cadena invertida
    mov [rdi], al               ; Almacenar el byte invertido en la nueva cadena

    inc rsi                     ; Avanzar al siguiente byte de la cadena original
    jmp invertir_cadena         ; Repetir el ciclo

fin_inversion:
    ; Imprimir la cadena invertida
    mov eax, 4                  ; Llamada al sistema para escribir
    mov ebx, 1                  ; Escribir en salida estándar (stdout)
    lea ecx, [msg_invertida]    ; Mensaje "Cadena invertida: "
    mov edx, len msg_invertida  ; Longitud del mensaje
    int 0x80                    ; Llamada a la interrupción del sistema

    ; Imprimir la cadena invertida
    mov eax, 4                  ; Llamada al sistema para escribir
    mov ebx, 1                  ; Escribir en salida estándar (stdout)
    lea ecx, [reversed]         ; Cadena invertida
    mov edx, 20                 ; Longitud de la cadena invertida
    int 0x80                    ; Llamada a la interrupción del sistema

    ; Salir
    mov eax, 1                  ; Llamada para salir
    xor ebx, ebx                ; Código de salida 0
    int 0x80
