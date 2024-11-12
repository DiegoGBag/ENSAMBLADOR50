; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para encontrar
;              el valor mínimo en un arreglo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def encontrar_minimo(arreglo):
;     minimo = arreglo[0]
;     for num in arreglo:
;         if num < minimo:
;             minimo = num
;     return minimo
;
; arreglo = [3, 5, 7, 2, 8, 6]
; minimo = encontrar_minimo(arreglo)
; print("El valor mínimo es:", minimo)
; ----------------------------------------------

section .data
    arreglo db 3, 5, 7, 2, 8, 6, 0     ; Arreglo de números, el último valor debe ser 0 para marcar el fin
    msg_minimo db "El valor mínimo es: ", 0
    minimo resb 1                      ; Variable para almacenar el valor mínimo

section .text
    global _start

_start:
    ; Inicializar el valor mínimo con el primer elemento del arreglo
    mov al, [arreglo]                  ; Cargar el primer elemento del arreglo en AL
    mov [minimo], al                   ; Guardar el primer elemento como valor mínimo inicial

    ; Apuntar al segundo elemento del arreglo
    lea rsi, [arreglo + 1]             ; Apuntar al siguiente elemento en el arreglo

encontrar_minimo:
    mov al, [rsi]                      ; Cargar el siguiente valor del arreglo en AL
    cmp al, 0                          ; Comparar con 0 (fin del arreglo)
    je mostrar_minimo                  ; Si es 0, terminar la búsqueda

    ; Comparar el valor actual con el valor mínimo
    cmp al, [minimo]                   ; Comparar AL con el valor mínimo actual
    jge continuar                      ; Si AL >= mínimo, continuar con el siguiente valor
    mov [minimo], al                   ; Si AL < mínimo, actualizar el valor mínimo

continuar:
    inc rsi                            ; Mover al siguiente elemento del arreglo
    jmp encontrar_minimo               ; Repetir el ciclo

mostrar_minimo:
    ; Imprimir el mensaje de salida
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en salida estándar (stdout)
    lea ecx, [msg_minimo]              ; Mensaje "El valor mínimo es: "
    mov edx, len msg_minimo            ; Longitud del mensaje
    int 0x80                           ; Llamada a la interrupción del sistema

    ; Imprimir el valor mínimo
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en salida estándar (stdout)
    mov ecx, minimo                    ; Valor mínimo
    mov edx, 1                         ; Tamaño de un byte
    int 0x80                           ; Llamada a la interrupción del sistema

fin:
    ; Salir
    mov eax, 1                         ; Llamada para salir
    xor ebx, ebx                       ; Código de salida 0
    int 0x80
