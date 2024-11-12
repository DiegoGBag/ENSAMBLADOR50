; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para ordenar
;              un arreglo mediante el método de
;              ordenamiento burbuja.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def burbuja(arreglo):
;     n = len(arreglo)
;     for i in range(n):
;         for j in range(0, n - i - 1):
;             if arreglo[j] > arreglo[j + 1]:
;                 arreglo[j], arreglo[j + 1] = arreglo[j + 1], arreglo[j]
; arreglo = [5, 2, 9, 1, 5, 6]
; burbuja(arreglo)
; print("Arreglo ordenado:", arreglo)
; ----------------------------------------------

section .data
    arreglo db 5, 2, 9, 1, 5, 6, 0       ; Arreglo de números (0 marca el final)
    msg_ordenado db "Arreglo ordenado: ", 0
    n db 6                               ; Tamaño del arreglo (sin incluir el 0 de fin)

section .bss
    temp resb 1                          ; Variable temporal para intercambio

section .text
    global _start

_start:
    ; Inicializar el contador externo i = 0
    xor rbx, rbx                         ; rbx se usa como el índice externo (i = 0)

bucle_externo:
    ; Comparar i con n para ver si hemos terminado
    mov al, [n]
    sub al, bl                           ; n - i
    cmp al, 1                            ; Verificar si queda al menos un par para comparar
    jle fin_ordenamiento                 ; Si no, el arreglo está ordenado

    ; Inicializar el contador interno j = 0
    xor rcx, rcx                         ; rcx se usa como índice interno (j = 0)

bucle_interno:
    ; Comparar j con n - i - 1
    mov al, [n]
    sub al, bl                           ; al = n - i
    dec al                               ; al = n - i - 1
    cmp cl, al                           ; Comparar j con n - i - 1
    jge siguiente_paso                   ; Si j >= n - i - 1, salir del bucle interno

    ; Comparar arreglo[j] y arreglo[j + 1]
    mov al, [arreglo + rcx]
    mov dl, [arreglo + rcx + 1]
    cmp al, dl
    jle sin_intercambio                  ; Si arreglo[j] <= arreglo[j + 1], no intercambiar

    ; Intercambiar arreglo[j] y arreglo[j + 1]
    mov [temp], al                       ; temp = arreglo[j]
    mov [arreglo + rcx], dl              ; arreglo[j] = arreglo[j + 1]
    mov al, [temp]
    mov [arreglo + rcx + 1], al          ; arreglo[j + 1] = temp

sin_intercambio:
    inc rcx                              ; j++
    jmp bucle_interno                    ; Volver al inicio del bucle interno

siguiente_paso:
    inc rbx                              ; i++
    jmp bucle_externo                    ; Volver al inicio del bucle externo

fin_ordenamiento:
    ; Imprimir el mensaje de salida
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en salida estándar (stdout)
    lea ecx, [msg_ordenado]              ; Mensaje "Arreglo ordenado: "
    mov edx, len msg_ordenado            ; Longitud del mensaje
    int 0x80                             ; Llamada a la interrupción del sistema

    ; Imprimir el arreglo ordenado
    mov rcx, 0                           ; Inicializar índice de impresión

imprimir_arreglo:
    mov al, [arreglo + rcx]
    cmp al, 0                            ; Comprobar si es el final del arreglo
    je fin                               ; Si es 0, fin de impresión

    ; Imprimir el elemento actual
    mov eax, 4                           ; Llamada al sistema para escribir
    mov ebx, 1                           ; Escribir en salida estándar (stdout)
    lea ecx, [arreglo + rcx]             ; Elemento actual del arreglo
    mov edx, 1                           ; Tamaño de un byte
    int 0x80                             ; Llamada a la interrupción del sistema

    ; Espacio entre números
    mov eax, 4
    mov ebx, 1
    mov ecx, " "                         ; Espacio en blanco
    mov edx, 1
    int 0x80

    inc rcx                              ; Incrementar índice
    jmp imprimir_arreglo                 ; Continuar con el siguiente elemento

fin:
    ; Salir
    mov eax, 1                           ; Llamada para salir
    xor ebx, ebx                         ; Código de salida 0
    int 0x80
