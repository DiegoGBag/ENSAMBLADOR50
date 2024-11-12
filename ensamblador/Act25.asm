; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que cuenta
;              las vocales y consonantes en una cadena.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def contar_vocales_consonantes(cadena):
;     vocales = "aeiouAEIOU"
;     vocal_count = 0
;     consonant_count = 0
;     for char in cadena:
;         if char in vocales:
;             vocal_count += 1
;         elif char.isalpha():  # Verifica si es una letra (consonante)
;             consonant_count += 1
;     return vocal_count, consonant_count
;
; cadena = "Hola Mundo"
; vocales, consonantes = contar_vocales_consonantes(cadena)
; print(f"Vocales: {vocales}, Consonantes: {consonantes}")
; ----------------------------------------------

section .data
    ; Definir la cadena (terminada en null)
    cadena db 'Hola Mundo', 0   ; Cadena de caracteres terminada en null (0)
    vocales db 'aeiouAEIOU', 0   ; Letras consideradas vocales

section .bss
    vocal_count resb 4  ; Espacio para almacenar el número de vocales
    consonant_count resb 4  ; Espacio para almacenar el número de consonantes

section .text
    global _start

_start:
    ; Inicializar registros
    xor ecx, ecx          ; ECX será el índice de la cadena
    xor edx, edx          ; EDX será el contador de vocales
    xor ebx, ebx          ; EBX será el contador de consonantes

count_loop:
    mov al, [cadena + ecx]  ; Cargar el carácter de la cadena en AL
    cmp al, 0               ; Comparar con null (0)
    je done                 ; Si es null, hemos llegado al final

    ; Verificar si el carácter es una vocal
    mov si, 0               ; Inicializar el índice de las vocales a 0
check_vocal:
    mov dl, [vocales + si]  ; Cargar el carácter de las vocales
    cmp al, dl              ; Comparar con el carácter de las vocales
    je is_vowel             ; Si es vocal, ir a is_vowel
    inc si                  ; Avanzar al siguiente carácter en 'vocales'
    cmp byte [vocales + si], 0 ; Verificar si hemos recorrido todas las vocales
    jne check_vocal         ; Si no hemos terminado, seguir comparando

    ; Si no es vocal, verificar si es consonante (letra)
    ; Comprobar si es una letra
    cmp al, 'a'             ; Comparar con 'a'
    jl next_char            ; Si es menor, no es una letra
    cmp al, 'z'             ; Comparar con 'z'
    jg next_char            ; Si es mayor, no es una letra
    inc ebx                 ; Contar consonante

is_vowel:
    inc edx                 ; Contar vocal
next_char:
    inc ecx                 ; Avanzar al siguiente carácter de la cadena
    jmp count_loop          ; Repetir el bucle

done:
    ; Almacenar los resultados en memoria
    mov [vocal_count], edx  ; Almacenar el número de vocales
    mov [consonant_count], ebx  ; Almacenar el número de consonantes

    ; Imprimir los resultados (número de vocales)
    mov eax, 4              ; Llamada al sistema para escribir
    mov ebx, 1              ; Escribir en salida estándar (stdout)
    lea ecx, [msg_vocales]  ; Mensaje de salida para vocales
    mov edx, len msg_vocales
    int 0x80                ; Llamada al sistema

    ; Imprimir el número de vocales
    mov eax, 4              ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [vocal_count]  ; Cargar el número de vocales
    mov edx, 4
    int 0x80                ; Imprimir las vocales

    ; Imprimir los resultados (número de consonantes)
    mov eax, 4              ; Llamada al sistema para escribir
    mov ebx, 1              ; Escribir en salida estándar (stdout)
    lea ecx, [msg_consonantes]  ; Mensaje de salida para consonantes
    mov edx, len msg_consonantes
    int 0x80                ; Llamada al sistema

    ; Imprimir el número de consonantes
    mov eax, 4              ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [consonant_count]  ; Cargar el número de consonantes
    mov edx, 4
    int 0x80                ; Imprimir las consonantes

fin:
    ; Salir
    mov eax, 1              ; Llamada para salir
    xor ebx, ebx            ; Código de salida 0
    int 0x80

section .data
    msg_vocales db "Vocales: ", 0
    msg_consonantes db "Consonantes: ", 0
