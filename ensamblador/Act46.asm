; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que encuentra
;              el prefijo común más largo entre dos cadenas.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def prefijo_comun_mas_largo(str1, str2):
;     # Inicializar el prefijo vacío
;     prefijo = ""
;     # Recorrer ambas cadenas y comparar los caracteres
;     for i in range(min(len(str1), len(str2))):
;         if str1[i] == str2[i]:
;             prefijo += str1[i]
;         else:
;             break
;     return prefijo
; 
; # Ejemplo de uso
; str1 = "apple"
; str2 = "apricot"
; print(f"El prefijo común más largo es: {prefijo_comun_mas_largo(str1, str2)}")
; ----------------------------------------------

section .data
    str1 db "apple", 0          ; Primera cadena
    str2 db "apricot", 0        ; Segunda cadena
    msg db "Prefijo comun mas largo: ", 0
    newline db 10, 0            ; Nueva línea

section .bss
    prefijo resb 100            ; Espacio para el prefijo común
    i resb 1                    ; Índice temporal para las comparaciones

section .text
    global _start

_start:
    ; Inicializar punteros a las cadenas
    lea rsi, [str1]             ; Cargar la dirección de str1 en rsi
    lea rdi, [str2]             ; Cargar la dirección de str2 en rdi
    xor rbx, rbx                ; Limpiar rbx (índice de comparación)
    xor rcx, rcx                ; Limpiar rcx (longitud del prefijo)

compare_chars:
    ; Cargar el siguiente carácter de cada cadena
    mov al, byte [rsi + rbx]    ; Cargar carácter de str1 en al
    mov dl, byte [rdi + rbx]    ; Cargar carácter de str2 en dl

    ; Comparar los caracteres
    cmp al, dl
    jne done                    ; Si no son iguales, terminar

    ; Si son iguales, agregar al prefijo
    mov byte [prefijo + rcx], al ; Guardar el carácter común en el prefijo
    inc rcx                      ; Incrementar la longitud del prefijo
    inc rbx                      ; Incrementar el índice
    test al, al                  ; Verificar si hemos llegado al final de una de las cadenas
    jnz compare_chars           ; Si no es el final, continuar comparando

done:
    ; Imprimir el mensaje "Prefijo común más largo"
    mov eax, 4                   ; Llamada al sistema para escribir
    mov ebx, 1                   ; Escribir en stdout
    lea ecx, [msg]               ; Cargar mensaje en ecx
    mov edx, len msg             ; Longitud del mensaje
    int 0x80

    ; Imprimir el prefijo común más largo
    mov eax, 4                   ; Llamada al sistema para escribir
    mov ebx, 1                   ; Escribir en stdout
    lea ecx, [prefijo]           ; Cargar prefijo en ecx
    mov edx, rcx                 ; Longitud del prefijo
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4                   ; Llamada al sistema para escribir
    mov ebx, 1                   ; Escribir en stdout
    lea ecx, [newline]           ; Nueva línea
    mov edx, 1                   ; Longitud de nueva línea
    int 0x80

    ; Salir del programa
    mov eax, 1                   ; Llamada para salir
    xor ebx, ebx                 ; Código de salida 0
    int 0x80
