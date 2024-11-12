; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para encontrar
;              el valor máximo en un arreglo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def encontrar_maximo(arreglo):
;     maximo = arreglo[0]
;     for num in arreglo:
;         if num > maximo:
;             maximo = num
;     return maximo
;
; arreglo = [3, 5, 7, 2, 8, 6]
; maximo = encontrar_maximo(arreglo)
; print("El valor máximo es:", maximo)
; ----------------------------------------------

section .data
    arreglo db 3, 5, 7, 2, 8, 6, 0     ; Arreglo de números, el último valor debe ser 0 para marcar el fin
    msg_maximo db "El valor máximo es: ", 0
    maximo resb 1                      ; Variable para almacenar el valor máximo

section .text
    global _start

_start:
    ; Inicializar el valor máximo con el primer elemento del arreglo
    mov al, [arreglo]                  ; Cargar el primer elemento del arreglo en AL
    mov [maximo], al                   ; Guardar el primer elemento como valor máximo inicial

    ; Apuntar al segundo elemento del arreglo
    lea rsi, [arreglo + 1]             ; Apuntar al siguiente elemento en el arreglo

encontrar_maximo:
    mov al, [rsi]                      ; Cargar el siguiente valor del arreglo en AL
    cmp al, 0                          ; Comparar con 0 (fin del arreglo)
    je mostrar_maximo                  ; Si es 0, terminar la búsqueda

    ; Comparar el valor actual con el valor máximo
    cmp al, [maximo]                   ; Comparar AL con el valor máximo actual
    jle continuar                      ; Si AL <= maximo, continuar con el siguiente valor
    mov [maximo], al                   ; Si AL > maximo, actualizar el valor máximo

continuar:
    inc rsi                            ; Mover al siguiente elemento del arreglo
    jmp encontrar_maximo               ; Repetir el ciclo

mostrar_maximo:
    ; Imprimir el mensaje de salida
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en salida estándar (stdout)
    lea ecx, [msg_maximo]              ; Mensaje "El valor máximo es: "
    mov edx, len msg_maximo            ; Longitud del mensaje
    int 0x80                           ; Llamada a la interrupción del sistema

    ; Imprimir el valor máximo
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en salida estándar (stdout)
    mov ecx, maximo                    ; Valor máximo
    mov edx, 1                         ; Tamaño de un byte
    int 0x80                           ; Llamada a la interrupción del sistema

fin:
    ; Salir
    mov eax, 1                         ; Llamada para salir
    xor ebx, ebx                       ; Código de salida 0
    int 0x80
