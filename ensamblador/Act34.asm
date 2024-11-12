; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que invierte
;              los elementos de un arreglo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def invertir_arreglo(arreglo):
;     izquierda = 0
;     derecha = len(arreglo) - 1
;     while izquierda < derecha:
;         arreglo[izquierda], arreglo[derecha] = arreglo[derecha], arreglo[izquierda]
;         izquierda += 1
;         derecha -= 1
;     return arreglo
;
; arreglo = [1, 2, 3, 4, 5]
; print("Arreglo invertido:", invertir_arreglo(arreglo))  # Resultado: [5, 4, 3, 2, 1]
; ----------------------------------------------

section .data
    arreglo db 1, 2, 3, 4, 5  ; Arreglo de elementos
    longitud db 5             ; Longitud del arreglo
    msg db "Arreglo invertido: ", 0

section .text
    global _start

_start:
    ; Inicializar punteros para los extremos del arreglo
    mov esi, arreglo          ; ESI apunta al inicio del arreglo (izquierda)
    mov ecx, [longitud]       ; Cargar la longitud en ECX
    dec ecx                   ; ECX es ahora el índice del último elemento
    lea edi, [arreglo + ecx]  ; EDI apunta al final del arreglo (derecha)

invertir_arreglo:
    ; Terminar si los punteros se cruzan o se encuentran
    cmp esi, edi
    jge fin_inversion         ; Si ESI >= EDI, termina el proceso

    ; Intercambiar los elementos en ESI y EDI
    mov al, [esi]             ; Cargar el elemento en ESI en AL
    mov bl, [edi]             ; Cargar el elemento en EDI en BL
    mov [esi], bl             ; Colocar el valor de EDI en ESI
    mov [edi], al             ; Colocar el valor de ESI en EDI

    ; Mover los punteros hacia el centro
    inc esi                   ; Incrementar ESI para moverse hacia la derecha
    dec edi                   ; Decrementar EDI para moverse hacia la izquierda
    jmp invertir_arreglo      ; Repetir el proceso

fin_inversion:
    ; Imprimir el mensaje "Arreglo invertido: "
    mov eax, 4                ; Llamada al sistema para escribir
    mov ebx, 1                ; Escribir en salida estándar (stdout)
    lea ecx, [msg]            ; Mensaje para el arreglo invertido
    mov edx, len msg
    int 0x80                  ; Llamada al sistema

    ; Imprimir cada elemento del arreglo invertido
    mov ecx, [longitud]       ; Restablecer el número de elementos
    mov esi, arreglo          ; Restablecer el puntero al inicio del arreglo

imprimir_elementos:
    ; Terminar si todos los elementos han sido impresos
    cmp ecx, 0
    je fin_programa

    ; Imprimir el elemento actual
    mov eax, 4                ; Llamada al sistema para escribir
    mov ebx, 1
    mov edx, 1                ; Tamaño del elemento (1 byte)
    mov ecx, esi              ; Dirección del elemento actual
    int 0x80                  ; Imprimir el elemento

    inc esi                   ; Moverse al siguiente elemento
    dec ecx                   ; Decrementar el contador de elementos
    jmp imprimir_elementos    ; Repetir hasta completar

fin_programa:
    ; Salir
    mov eax, 1                ; Llamada para salir
    xor ebx, ebx              ; Código de salida 0
    int 0x80
