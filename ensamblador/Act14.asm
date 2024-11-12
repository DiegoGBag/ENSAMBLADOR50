; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para realizar
;              una búsqueda lineal de un valor en un arreglo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def busqueda_lineal(arreglo, valor):
;     for i in range(len(arreglo)):
;         if arreglo[i] == valor:
;             return i  # Índice del valor encontrado
;     return -1  # Valor no encontrado
;
; arreglo = [3, 5, 7, 2, 8, 6]
; valor = 7
; indice = busqueda_lineal(arreglo, valor)
; if indice != -1:
;     print("Valor encontrado en el índice:", indice)
; else:
;     print("Valor no encontrado")
; ----------------------------------------------

section .data
    arreglo db 3, 5, 7, 2, 8, 6, 0      ; Arreglo de números, el último valor debe ser 0 para marcar el fin
    valor db 7                          ; Valor a buscar en el arreglo
    msg_encontrado db "Valor encontrado en el índice: ", 0
    msg_no_encontrado db "Valor no encontrado", 0
    indice resb 1                       ; Variable para almacenar el índice del valor encontrado

section .bss
    i resb 1                            ; Índice del arreglo para la búsqueda

section .text
    global _start

_start:
    ; Inicializar el índice a 0
    xor rbx, rbx                        ; rbx se usa como índice del arreglo (i = 0)

busqueda_lineal:
    ; Cargar el siguiente elemento del arreglo en AL
    mov al, [arreglo + rbx]
    cmp al, 0                           ; Comparar con 0 (fin del arreglo)
    je no_encontrado                    ; Si es 0, el valor no está en el arreglo

    ; Comparar el valor actual con el valor buscado
    cmp al, byte [valor]                ; Comparar el elemento con el valor buscado
    je encontrado                       ; Si son iguales, valor encontrado

    inc rbx                             ; Incrementar índice
    jmp busqueda_lineal                 ; Repetir la búsqueda con el siguiente elemento

encontrado:
    mov [indice], bl                    ; Guardar el índice donde se encontró el valor

    ; Imprimir mensaje de valor encontrado
    mov eax, 4                          ; Llamada al sistema para escribir
    mov ebx, 1                          ; Escribir en salida estándar (stdout)
    lea ecx, [msg_encontrado]           ; Mensaje "Valor encontrado en el índice: "
    mov edx, len msg_encontrado         ; Longitud del mensaje
    int 0x80                            ; Llamada a la interrupción del sistema

    ; Imprimir el índice del valor encontrado
    mov eax, 4                          ; Llamada al sistema para escribir
    mov ebx, 1                          ; Escribir en salida estándar (stdout)
    mov ecx, indice                     ; Índice donde se encontró el valor
    mov edx, 1                          ; Tamaño de un byte
    int 0x80                            ; Llamada a la interrupción del sistema
    jmp fin

no_encontrado:
    ; Imprimir mensaje de valor no encontrado
    mov eax, 4                          ; Llamada al sistema para escribir
    mov ebx, 1                          ; Escribir en salida estándar (stdout)
    lea ecx, [msg_no_encontrado]        ; Mensaje "Valor no encontrado"
    mov edx, len msg_no_encontrado      ; Longitud del mensaje
    int 0x80                            ; Llamada a la interrupción del sistema

fin:
    ; Salir
    mov eax, 1                          ; Llamada para salir
    xor ebx, ebx                        ; Código de salida 0
    int 0x80
