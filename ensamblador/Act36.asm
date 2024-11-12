; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que encuentra
;              el segundo elemento más grande de un arreglo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def segundo_mas_grande(arreglo):
;     if len(arreglo) < 2:
;         raise ValueError("El arreglo debe tener al menos dos elementos.")
;     
;     max1 = max2 = float('-inf')
;     
;     for num in arreglo:
;         if num > max1:
;             max2 = max1
;             max1 = num
;         elif num > max2 and num != max1:
;             max2 = num
;     
;     return max2
;
; arreglo = [3, 5, 1, 2, 4]
; print("El segundo elemento más grande es:", segundo_mas_grande(arreglo))  # Resultado: 4
; ----------------------------------------------

section .data
    arreglo db 3, 5, 1, 2, 4    ; Arreglo de elementos
    longitud db 5               ; Longitud del arreglo
    msg db "El segundo elemento más grande es: ", 0

section .bss
    max1 resb 1                 ; Variable para el mayor elemento
    max2 resb 1                 ; Variable para el segundo mayor elemento

section .text
    global _start

_start:
    ; Inicializar max1 y max2 con el valor más bajo posible
    mov byte [max1], -128       ; Valor mínimo en un byte
    mov byte [max2], -128       ; Valor mínimo en un byte

    ; Configurar el contador para recorrer el arreglo
    mov ecx, [longitud]         ; Número de elementos
    mov esi, arreglo            ; Apuntar al inicio del arreglo

buscar_segundo_mas_grande:
    ; Cargar el elemento actual
    mov al, [esi]

    ; Verificar si el elemento actual es mayor que max1
    cmp al, [max1]
    jle verificar_max2           ; Si no es mayor, verificar si es el segundo mayor

    ; Actualizar max2 con el valor de max1 y max1 con el nuevo mayor
    mov bl, [max1]
    mov [max2], bl
    mov [max1], al
    jmp siguiente_elemento

verificar_max2:
    ; Verificar si el elemento actual es mayor que max2 y distinto de max1
    cmp al, [max2]
    jle siguiente_elemento       ; Si no es mayor, pasar al siguiente
    cmp al, [max1]
    je siguiente_elemento        ; Si es igual a max1, pasar al siguiente
    mov [max2], al               ; Actualizar max2

siguiente_elemento:
    ; Moverse al siguiente elemento
    inc esi                      ; Avanzar al siguiente byte del arreglo
    loop buscar_segundo_mas_grande ; Repetir hasta que ECX llegue a 0

    ; Imprimir el mensaje "El segundo elemento más grande es: "
    mov eax, 4                   ; Llamada al sistema para escribir
    mov ebx, 1                   ; Escribir en salida estándar (stdout)
    lea ecx, [msg]               ; Mensaje para el segundo elemento más grande
    mov edx, len msg
    int 0x80                     ; Llamada al sistema

    ; Imprimir el segundo mayor elemento
    mov eax, 4                   ; Llamada al sistema para escribir
    mov ebx, 1
    mov ecx, max2                ; Dirección de max2
    mov edx, 1                   ; Tamaño del elemento (1 byte)
    int 0x80                     ; Imprimir max2

    ; Salir
    mov eax, 1                   ; Llamada para salir
    xor ebx, ebx                 ; Código de salida 0
    int 0x80
