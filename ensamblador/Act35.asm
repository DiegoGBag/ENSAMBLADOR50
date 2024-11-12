; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que rota los
;              elementos de un arreglo a la izquierda
;              o a la derecha una posición.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def rotar_izquierda(arreglo):
;     return arreglo[1:] + arreglo[:1]
;
; def rotar_derecha(arreglo):
;     return arreglo[-1:] + arreglo[:-1]
;
; arreglo = [1, 2, 3, 4, 5]
; print("Rotación izquierda:", rotar_izquierda(arreglo))  # Resultado: [2, 3, 4, 5, 1]
; print("Rotación derecha:", rotar_derecha(arreglo))      # Resultado: [5, 1, 2, 3, 4]
; ----------------------------------------------

section .data
    arreglo db 1, 2, 3, 4, 5     ; Arreglo de elementos
    longitud db 5                ; Longitud del arreglo
    msg_izquierda db "Rotación izquierda: ", 0
    msg_derecha db "Rotación derecha: ", 0

section .bss
    temp resb 1                  ; Variable temporal para rotación

section .text
    global _start

_start:
    ; Elegir entre rotación a la izquierda o derecha
    mov al, 1                    ; 1 para rotación izquierda, 2 para derecha

    cmp al, 1
    je rotacion_izquierda
    cmp al, 2
    je rotacion_derecha
    jmp fin_programa

; ---------------- Rotación a la izquierda ----------------
rotacion_izquierda:
    ; Guardar el primer elemento en `temp`
    mov al, [arreglo]
    mov [temp], al

    ; Desplazar todos los elementos hacia la izquierda
    mov ecx, [longitud]
    dec ecx                       ; Número de desplazamientos
    mov esi, arreglo

shift_left:
    mov al, [esi + 1]             ; Cargar el siguiente elemento
    mov [esi], al                 ; Desplazarlo hacia la izquierda
    inc esi                       ; Mover al siguiente elemento
    loop shift_left               ; Repetir hasta que ECX llegue a 0

    ; Colocar el primer elemento al final
    mov al, [temp]
    mov [esi], al                 ; Almacenar en la última posición

    ; Imprimir el mensaje "Rotación izquierda: "
    mov eax, 4                    ; Llamada al sistema para escribir
    mov ebx, 1                    ; Escribir en salida estándar (stdout)
    lea ecx, [msg_izquierda]      ; Mensaje para la rotación izquierda
    mov edx, len msg_izquierda
    int 0x80                      ; Llamada al sistema

    ; Imprimir el arreglo rotado
    mov ecx, [longitud]           ; Restablecer la longitud
    mov esi, arreglo              ; Apuntar al inicio del arreglo

imprimir_arreglo:
    cmp ecx, 0
    je fin_programa

    ; Imprimir cada elemento del arreglo
    mov eax, 4                    ; Llamada al sistema para escribir
    mov ebx, 1
    mov edx, 1                    ; Tamaño del elemento (1 byte)
    mov ecx, esi                  ; Dirección del elemento actual
    int 0x80                      ; Imprimir el elemento

    inc esi                       ; Mover al siguiente elemento
    dec ecx                       ; Decrementar el contador de elementos
    jmp imprimir_arreglo          ; Repetir hasta completar

; ---------------- Rotación a la derecha ----------------
rotacion_derecha:
    ; Guardar el último elemento en `temp`
    mov ecx, [longitud]
    dec ecx
    lea esi, [arreglo + ecx]      ; ESI apunta al último elemento
    mov al, [esi]
    mov [temp], al

    ; Desplazar todos los elementos hacia la derecha
shift_right:
    mov al, [esi - 1]             ; Cargar el elemento anterior
    mov [esi], al                 ; Desplazarlo hacia la derecha
    dec esi                       ; Mover hacia el elemento anterior
    loop shift_right              ; Repetir hasta que ECX llegue a 0

    ; Colocar el último elemento en la primera posición
    mov al, [temp]
    mov [arreglo], al

    ; Imprimir el mensaje "Rotación derecha: "
    mov eax, 4                    ; Llamada al sistema para escribir
    mov ebx, 1                    ; Escribir en salida estándar (stdout)
    lea ecx, [msg_derecha]        ; Mensaje para la rotación derecha
    mov edx, len msg_derecha
    int 0x80                      ; Llamada al sistema

    ; Imprimir el arreglo rotado
    mov ecx, [longitud]           ; Restablecer la longitud
    mov esi, arreglo              ; Apuntar al inicio del arreglo
    jmp imprimir_arreglo

fin_programa:
    ; Salir
    mov eax, 1                    ; Llamada para salir
    xor ebx, ebx                  ; Código de salida 0
    int 0x80
