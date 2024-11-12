; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que genera 
;              números aleatorios utilizando una semilla
;              mediante el generador congruente lineal.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; import random
; 
; def generar_aleatorio(seed):
;     random.seed(seed)  # Establecer la semilla
;     return random.randint(0, 100)  # Generar un número aleatorio entre 0 y 100
; 
; # Ejemplo de uso
; semilla = 12345
; print(f"Número aleatorio generado: {generar_aleatorio(semilla)}")
; ----------------------------------------------

section .data
    msg db "Número aleatorio generado: ", 0
    newline db 10, 0                     ; Nueva línea
    semilla dq 12345                     ; Semilla inicial (puede cambiarse)
    m dq 2147483647                      ; Modulo M (número grande para limitar el rango)
    a dq 1664525                         ; Constante multiplicativa A (recomendada para calidad)
    c dq 1013904223                      ; Constante de incremento C
    max_value dq 100                     ; Límite máximo para el número aleatorio

section .bss
    resultado resq 1                     ; Espacio para el número aleatorio generado

section .text
    global _start

_start:
    ; Cargar la semilla inicial
    mov rsi, [semilla]                  ; Cargar semilla en rsi
    mov rbx, [a]                        ; Cargar constante A
    mov rcx, [c]                        ; Cargar constante C
    mov rdx, [m]                        ; Cargar modulo M

    ; Generación de número aleatorio (Xn = (A * Xn-1 + C) mod M)
    ; Paso 1: multiplicar A por la semilla
    imul rsi, rbx                       ; rsi = rsi * A (multiplicación)
    add rsi, rcx                         ; rsi = rsi + C (suma)
    mov rax, rsi                         ; Copiar el resultado en rax
    div rdx                               ; rax = rax / M, rdx = resto
    mov [resultado], rdx                 ; El resto (rdx) es el número aleatorio

    ; Limitar el número aleatorio al rango [0, 100]
    mov rbx, [max_value]                 ; Cargar el valor máximo 100
    div rbx                               ; rdx = rdx % max_value

    ; Imprimir mensaje
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [msg]
    mov edx, len msg
    int 0x80

    ; Imprimir el número aleatorio generado
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [resultado]
    mov edx, 1                            ; Tamaño de un byte (resultado)
    int 0x80

    ; Salto a nueva línea
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [newline]
    mov edx, 1                            ; Tamaño de un byte
    int 0x80

    ; Salir del programa
    mov eax, 1                            ; Llamada para salir
    xor ebx, ebx                          ; Código de salida 0
    int 0x80
