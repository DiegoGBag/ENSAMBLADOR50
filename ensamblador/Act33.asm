; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que calcula
;              la suma de los elementos en un arreglo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def suma_arreglo(arreglo):
;     suma = 0
;     for elemento in arreglo:
;         suma += elemento
;     return suma
;
; arreglo = [1, 2, 3, 4, 5]
; print("Suma:", suma_arreglo(arreglo))  # Resultado: 15
; ----------------------------------------------

section .data
    arreglo db 1, 2, 3, 4, 5  ; Arreglo de elementos
    longitud db 5             ; Longitud del arreglo
    msg db "Suma: ", 0

section .bss
    suma resb 1               ; Espacio para almacenar la suma

section .text
    global _start

_start:
    ; Inicializar la suma en 0
    mov al, 0                 ; AL almacena la suma total
    mov ecx, [longitud]       ; Cargar la longitud del arreglo en ECX
    mov esi, arreglo          ; Apuntar al inicio del arreglo

suma_arreglo:
    cmp ecx, 0                ; Comprobar si ya hemos terminado
    je fin_suma               ; Si ECX es 0, terminamos el cálculo

    add al, [esi]             ; Sumar el valor actual al total en AL
    inc esi                   ; Mover al siguiente elemento del arreglo
    dec ecx                   ; Decrementar el contador de elementos
    jmp suma_arreglo          ; Repetir el proceso

fin_suma:
    ; Guardar el resultado de la suma en la variable 'suma'
    mov [suma], al

    ; Imprimir el mensaje "Suma: "
    mov eax, 4                ; Llamada al sistema para escribir
    mov ebx, 1                ; Escribir en salida estándar (stdout)
    lea ecx, [msg]            ; Mensaje para la suma
    mov edx, len msg
    int 0x80                  ; Llamada al sistema

    ; Imprimir el resultado de la suma
    mov eax, 4                ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [suma]           ; Cargar el resultado de la suma
    mov edx, 1                ; Tamaño del resultado
    int 0x80                  ; Imprimir la suma

    ; Salir
    mov eax, 1                ; Llamada para salir
    xor ebx, ebx              ; Código de salida 0
    int 0x80
