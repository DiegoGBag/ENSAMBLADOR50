; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que calcula
;              la multiplicación de dos matrices 2x2.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def multiplicar_matrices(matriz1, matriz2):
;     resultado = [
;         [
;             matriz1[0][0] * matriz2[0][0] + matriz1[0][1] * matriz2[1][0],
;             matriz1[0][0] * matriz2[0][1] + matriz1[0][1] * matriz2[1][1]
;         ],
;         [
;             matriz1[1][0] * matriz2[0][0] + matriz1[1][1] * matriz2[1][0],
;             matriz1[1][0] * matriz2[0][1] + matriz1[1][1] * matriz2[1][1]
;         ]
;     ]
;     return resultado
;
; matriz1 = [[1, 2], [3, 4]]
; matriz2 = [[5, 6], [7, 8]]
; resultado = multiplicar_matrices(matriz1, matriz2)
; print("Resultado de la multiplicación de matrices:", resultado)
; ----------------------------------------------

section .data
    ; Definir las dos matrices 2x2
    matriz1 db 1, 2
            db 3, 4
    matriz2 db 5, 6
            db 7, 8

    ; Mensaje de salida para el resultado
    msg_resultado db "Resultado de la multiplicación de matrices: ", 0

section .bss
    resultado resb 4    ; Espacio para almacenar la matriz resultado 2x2

section .text
    global _start

_start:
    ; Imprimir mensaje de salida
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1               ; Escribir en salida estándar (stdout)
    lea ecx, [msg_resultado] ; Mensaje "Resultado de la multiplicación de matrices: "
    mov edx, len msg_resultado
    int 0x80                 ; Llamada a la interrupción del sistema

    ; Calcular cada elemento de la matriz resultado
    ; resultado[0][0] = matriz1[0][0] * matriz2[0][0] + matriz1[0][1] * matriz2[1][0]
    mov al, [matriz1]        ; Cargar matriz1[0][0]
    imul al, [matriz2]       ; Multiplicar por matriz2[0][0]
    mov bl, al               ; Guardar resultado parcial en bl
    mov al, [matriz1 + 1]    ; Cargar matriz1[0][1]
    imul al, [matriz2 + 2]   ; Multiplicar por matriz2[1][0]
    add al, bl               ; Sumar al resultado parcial
    mov [resultado], al      ; Guardar en resultado[0][0]

    ; resultado[0][1] = matriz1[0][0] * matriz2[0][1] + matriz1[0][1] * matriz2[1][1]
    mov al, [matriz1]        ; Cargar matriz1[0][0]
    imul al, [matriz2 + 1]   ; Multiplicar por matriz2[0][1]
    mov bl, al               ; Guardar resultado parcial en bl
    mov al, [matriz1 + 1]    ; Cargar matriz1[0][1]
    imul al, [matriz2 + 3]   ; Multiplicar por matriz2[1][1]
    add al, bl               ; Sumar al resultado parcial
    mov [resultado + 1], al  ; Guardar en resultado[0][1]

    ; resultado[1][0] = matriz1[1][0] * matriz2[0][0] + matriz1[1][1] * matriz2[1][0]
    mov al, [matriz1 + 2]    ; Cargar matriz1[1][0]
    imul al, [matriz2]       ; Multiplicar por matriz2[0][0]
    mov bl, al               ; Guardar resultado parcial en bl
    mov al, [matriz1 + 3]    ; Cargar matriz1[1][1]
    imul al, [matriz2 + 2]   ; Multiplicar por matriz2[1][0]
    add al, bl               ; Sumar al resultado parcial
    mov [resultado + 2], al  ; Guardar en resultado[1][0]

    ; resultado[1][1] = matriz1[1][0] * matriz2[0][1] + matriz1[1][1] * matriz2[1][1]
    mov al, [matriz1 + 2]    ; Cargar matriz1[1][0]
    imul al, [matriz2 + 1]   ; Multiplicar por matriz2[0][1]
    mov bl, al               ; Guardar resultado parcial en bl
    mov al, [matriz1 + 3]    ; Cargar matriz1[1][1]
    imul al, [matriz2 + 3]   ; Multiplicar por matriz2[1][1]
    add al, bl               ; Sumar al resultado parcial
    mov [resultado + 3], al  ; Guardar en resultado[1][1]

    ; Imprimir la matriz resultado
    mov ecx, 0               ; Inicializar índice

imprimir_resultado:
    mov al, [resultado + ecx]
    add al, '0'              ; Convertir a carácter ASCII
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1
    mov edx, 1
    int 0x80                 ; Imprimir el número

    ; Imprimir espacio entre números
    mov eax, 4
    mov ebx, 1
    mov ecx, " "
    mov edx, 1
    int 0x80

    inc ecx                  ; Incrementar índice
    cmp ecx, 4
    jl imprimir_resultado    ; Continuar imprimiendo hasta el último elemento

fin:
    ; Salir
    mov eax, 1               ; Llamada para salir
    xor ebx, ebx             ; Código de salida 0
    int 0x80
