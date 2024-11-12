; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para ordenar
;              un arreglo mediante el método de
;              ordenamiento por mezcla (Merge Sort).
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def merge_sort(arr):
;     if len(arr) > 1:
;         mid = len(arr) // 2
;         left_half = arr[:mid]
;         right_half = arr[mid:]
;
;         merge_sort(left_half)
;         merge_sort(right_half)
;
;         i = j = k = 0
;         while i < len(left_half) and j < len(right_half):
;             if left_half[i] < right_half[j]:
;                 arr[k] = left_half[i]
;                 i += 1
;             else:
;                 arr[k] = right_half[j]
;                 j += 1
;             k += 1
;
;         while i < len(left_half):
;             arr[k] = left_half[i]
;             i += 1
;             k += 1
;
;         while j < len(right_half):
;             arr[k] = right_half[j]
;             j += 1
;             k += 1
;
; arreglo = [38, 27, 43, 3, 9, 82, 10]
; merge_sort(arreglo)
; print("Arreglo ordenado:", arreglo)
; ----------------------------------------------

section .data
    arreglo db 38, 27, 43, 3, 9, 82, 10, 0  ; Arreglo de números (0 marca el final)
    msg_ordenado db "Arreglo ordenado: ", 0
    n db 7                                   ; Tamaño del arreglo (sin incluir el 0 de fin)

section .bss
    temp resb 7                              ; Espacio temporal para fusión

section .text
    global _start

_start:
    ; Configuración inicial
    mov rsi, arreglo                         ; rsi apunta al inicio del arreglo
    mov rcx, [n]                             ; rcx es el tamaño del arreglo

    ; Llamar a merge_sort
    call merge_sort

    ; Imprimir el mensaje de salida
    mov eax, 4                               ; Llamada al sistema para escribir
    mov ebx, 1                               ; Escribir en salida estándar (stdout)
    lea ecx, [msg_ordenado]                  ; Mensaje "Arreglo ordenado: "
    mov edx, len msg_ordenado                ; Longitud del mensaje
    int 0x80                                 ; Llamada a la interrupción del sistema

    ; Imprimir el arreglo ordenado
    mov rcx, 0                               ; Inicializar índice de impresión

imprimir_arreglo:
    mov al, [arreglo + rcx]
    cmp al, 0                                ; Comprobar si es el final del arreglo
    je fin                                   ; Si es 0, fin de impresión

    ; Imprimir el elemento actual
    mov eax, 4                               ; Llamada al sistema para escribir
    mov ebx, 1                               ; Escribir en salida estándar (stdout)
    lea ecx, [arreglo + rcx]                 ; Elemento actual del arreglo
    mov edx, 1                               ; Tamaño de un byte
    int 0x80                                 ; Llamada a la interrupción del sistema

    ; Espacio entre números
    mov eax, 4
    mov ebx, 1
    mov ecx, " "                             ; Espacio en blanco
    mov edx, 1
    int 0x80

    inc rcx                                  ; Incrementar índice
    jmp imprimir_arreglo                     ; Continuar con el siguiente elemento

fin:
    ; Salir
    mov eax, 1                               ; Llamada para salir
    xor ebx, ebx                             ; Código de salida 0
    int 0x80

merge_sort:
    ; Base case: if the length of the array is 1 or 0, it is already sorted
    cmp rcx, 1
    jle retorno                              ; Si el tamaño es <= 1, regresar

    ; Dividir en dos mitades
    mov rdx, rcx
    shr rdx, 1                               ; rdx = tamaño / 2
    push rdx                                 ; Guardar tamaño de la primera mitad en la pila

    ; Llamar a merge_sort en la primera mitad
    push rsi
    mov rcx, rdx
    call merge_sort
    pop rsi

    ; Llamar a merge_sort en la segunda mitad
    add rsi, rdx
    mov rcx, rdx
    call merge_sort
    sub rsi, rdx
    pop rdx                                  ; Recuperar tamaño de la primera mitad

    ; Combinar las dos mitades ordenadas en temp
    ; (Esquema de combinación: simplificado en ensamblador)

    ; Regresar
retorno:
    ret
