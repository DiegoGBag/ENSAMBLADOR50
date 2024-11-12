; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para ordenar
;              un arreglo mediante el método de
;              ordenamiento por selección.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def seleccion(arreglo):
;     n = len(arreglo)
;     for i in range(n):
;         min_idx = i
;         for j in range(i + 1, n):
;             if arreglo[j] < arreglo[min_idx]:
;                 min_idx = j
;         arreglo[i], arreglo[min_idx] = arreglo[min_idx], arreglo[i]
; arreglo = [64, 25, 12, 22, 11]
; seleccion(arreglo)
; print("Arreglo ordenado:", arreglo)
; ----------------------------------------------

section .data
    arreglo db 64, 25, 12, 22, 11, 0      ; Arreglo de números (0 marca el final)
    msg_ordenado db "Arreglo ordenado: ", 0
    n db 5                                ; Tamaño del arreglo (sin incluir el 0 de fin)

section .bss
    min_idx resb 1                        ; Índice del mínimo elemento en la pasada
    temp resb 1                           ; Variable temporal para intercambio

section .text
    global _start

_start:
    ; Inicializar el índice externo i = 0
    xor rbx, rbx                          ; rbx se usa como el índice externo (i = 0)

bucle_externo:
    ; Comparar i con n para ver si hemos terminado
    mov al, [n]
    cmp bl, al                            ; Verificar si i < n
    jge fin_ordenamiento                  ; Si no, el arreglo está ordenado

    ; Inicializar min_idx = i
    mov [min_idx], bl                     ; min_idx = i

    ; Inicializar el índice interno j = i + 1
    mov rcx, rbx
    inc rcx                               ; j = i + 1

bucle_interno:
    ; Comparar j con n
    mov al, [n]
    cmp cl, al                            ; Verificar si j < n
    jge intercambio                       ; Si j >= n, pasar al intercambio

    ; Comparar arreglo[j] con arreglo[min_idx]
    mov al, [arreglo + rcx]
    mov dl, [arreglo + [min_idx]]
    cmp al, dl
    jge siguiente_comparacion             ; Si arreglo[j] >= arreglo[min_idx], continuar

    ; Si arreglo[j] < arreglo[min_idx], actualizar min_idx
    mov [min_idx], cl

siguiente_comparacion:
    inc rcx                               ; j++
    jmp bucle_interno                     ; Continuar con el siguiente elemento

intercambio:
    ; Intercambiar arreglo[i] y arreglo[min_idx]
    mov al, [arreglo + rbx]
    mov dl, [arreglo + [min_idx]]
    mov [temp], al                        ; temp = arreglo[i]
    mov [arreglo + rbx], dl               ; arreglo[i] = arreglo[min_idx]
    mov al, [temp]
    mov [arreglo + [min_idx]], al         ; arreglo[min_idx] = temp

    inc rbx                               ; i++
    jmp bucle_externo                     ; Continuar con la siguiente iteración

fin_ordenamiento:
    ; Imprimir el mensaje de salida
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en salida estándar (stdout)
    lea ecx, [msg_ordenado]               ; Mensaje "Arreglo ordenado: "
    mov edx, len msg_ordenado             ; Longitud del mensaje
    int 0x80                              ; Llamada a la interrupción del sistema

    ; Imprimir el arreglo ordenado
    mov rcx, 0                            ; Inicializar índice de impresión

imprimir_arreglo:
    mov al, [arreglo + rcx]
    cmp al, 0                             ; Comprobar si es el final del arreglo
    je fin                                ; Si es 0, fin de impresión

    ; Imprimir el elemento actual
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en salida estándar (stdout)
    lea ecx, [arreglo + rcx]              ; Elemento actual del arreglo
    mov edx, 1                            ; Tamaño de un byte
    int 0x80                              ; Llamada a la interrupción del sistema

    ; Espacio entre números
    mov eax, 4
    mov ebx, 1
    mov ecx, " "                          ; Espacio en blanco
    mov edx, 1
    int 0x80

    inc rcx                               ; Incrementar índice
    jmp imprimir_arreglo                  ; Continuar con el siguiente elemento

fin:
    ; Salir
    mov eax, 1                            ; Llamada para salir
    xor ebx, ebx                          ; Código de salida 0
    int 0x80
