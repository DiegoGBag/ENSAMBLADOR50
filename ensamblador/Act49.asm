; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que lee 
;              una cadena de caracteres desde el teclado.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; # Función para leer entrada desde el teclado
; def leer_entrada():
;     entrada = input("Ingresa un texto: ")
;     return entrada
; 
; # Ejemplo de uso
; texto = leer_entrada()
; print(f"Texto ingresado: {texto}")
; ----------------------------------------------

section .data
    prompt db "Ingresa un texto: ", 0   ; Mensaje que se muestra en consola
    prompt_len equ $ - prompt            ; Longitud del mensaje
    buffer resb 128                      ; Espacio para almacenar la entrada

section .bss
    bytes_read resq 1                    ; Almacenar la cantidad de bytes leídos

section .text
    global _start

_start:
    ; Imprimir el mensaje de solicitud
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [prompt]
    mov edx, prompt_len
    int 0x80

    ; Leer la entrada desde el teclado
    mov eax, 3                            ; Llamada al sistema para leer (sys_read)
    mov ebx, 0                            ; Leer desde stdin
    lea ecx, [buffer]                     ; Dirección del buffer para la entrada
    mov edx, 128                          ; Tamaño máximo de la entrada
    int 0x80                               ; Interrupción de sistema

    ; Almacenar el número de bytes leídos
    mov [bytes_read], eax

    ; Imprimir el texto ingresado (mostramos los primeros 128 caracteres)
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [buffer]                     ; Dirección del buffer con la entrada
    mov edx, 128                          ; Tamaño máximo
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [newline]                    ; Nueva línea
    mov edx, 1                            ; Longitud de nueva línea
    int 0x80

    ; Salir del programa
    mov eax, 1                            ; Llamada para salir
    xor ebx, ebx                          ; Código de salida 0
    int 0x80

section .data
    newline db 10, 0                      ; Nueva línea
