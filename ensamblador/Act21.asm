; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que calcula
;              la transposición de una matriz 2x2.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def transponer_matriz(matriz):
;     resultado = [
;         [matriz[0][0], matriz[1][0]],
;         [matriz[0][1], matriz[1][1]]
;     ]
;     return resultado
;
; matriz = [[1, 2], [3, 4]]
; resultado = transponer_matriz(matriz)
; print("Resultado de la transposición de la matriz:", resultado)
; ----------------------------------------------

section .data
    ; Definir la matriz 2x2
    matriz db 1, 2
           db 3, 4

    ; Mensaje de salida para el resultado
    msg_resultado db "Resultado de la transposición de la matriz: ", 0

section .bss
    resultado resb 4    ; Espacio para almacenar la matriz resultado 2x2

section .text
    global _start

_start:
    ; Imprimir mensaje de salida
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1               ; Escribir en salida estándar (stdout)
    lea ecx, [msg_resultado] ; Mensaje "Resultado de la transposición de la matriz: "
    mov edx, len msg_resultado
    int 0x80                 ; Llamada a la interrupción del sistema

    ; Calcular la transposición
    ; resultado[0][0] = matriz[0][0]
    mov al, [matriz]         ; Cargar matriz[0][0]
    mov [resultado], al      ; Almacenar en resultado[0][0]

    ; resultado[0][1] = matriz[1][0]
    mov al, [matriz + 2]     ; Cargar matriz[1][0]
    mov [resultado + 1], al  ; Almacenar en resultado[0][1]

    ; resultado[1][0] = matriz[0][1]
    mov al, [matriz + 1]     ; Cargar matriz[0][1]
    mov [resultado + 2], al  ; Almacenar en resultado[1][0]

    ; resultado[1][1] = matriz[1][1]
    mov al, [matriz + 3]     ; Cargar matriz[1][1]
    mov [resultado + 3], al  ; Almacenar en resultado[1][1]

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
