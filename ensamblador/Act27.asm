; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que realiza
;              desplazamientos a la izquierda y derecha
;              a nivel de bits.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def desplazamientos(a):
;     shl_result = a << 2  # Desplazamiento a la izquierda (multiplica por 2^2)
;     shr_result = a >> 2  # Desplazamiento a la derecha (divide entre 2^2)
;     return shl_result, shr_result
;
; a = 5  # 0101 en binario
; shl_result, shr_result = desplazamientos(a)
; print(f"SHL (izquierda): {shl_result}, SHR (derecha): {shr_result}")
; ----------------------------------------------

section .data
    ; Definir un número para operar (en binario 5 = 0101)
    num db 5         ; 0101 en binario
    msg_shl db "Desplazamiento a la izquierda: ", 0
    msg_shr db "Desplazamiento a la derecha: ", 0

section .bss
    result_shl resb 4    ; Espacio para almacenar el resultado de SHL
    result_shr resb 4    ; Espacio para almacenar el resultado de SHR

section .text
    global _start

_start:
    ; Cargar el número para operar
    mov al, [num]   ; Cargar num (5)

    ; Desplazamiento a la izquierda (SHL)
    shl al, 2        ; AL = AL << 2 (desplazamiento a la izquierda por 2 bits)
    mov [result_shl], al  ; Almacenar el resultado de SHL (5 << 2 = 20)

    ; Imprimir el resultado de SHL
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    lea ecx, [msg_shl]     ; Mensaje para el resultado de SHL
    mov edx, len msg_shl
    int 0x80               ; Llamada al sistema

    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result_shl]  ; Cargar el resultado de SHL
    mov edx, 4
    int 0x80               ; Imprimir el resultado de SHL

    ; Recargar el número para operar
    mov al, [num]   ; Recargar num (5)

    ; Desplazamiento a la derecha (SHR)
    shr al, 2        ; AL = AL >> 2 (desplazamiento a la derecha por 2 bits)
    mov [result_shr], al  ; Almacenar el resultado de SHR (5 >> 2 = 1)

    ; Imprimir el resultado de SHR
    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1             ; Escribir en salida estándar (stdout)
    lea ecx, [msg_shr]     ; Mensaje para el resultado de SHR
    mov edx, len msg_shr
    int 0x80               ; Llamada al sistema

    mov eax, 4             ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [result_shr]  ; Cargar el resultado de SHR
    mov edx, 4
    int 0x80               ; Imprimir el resultado de SHR

fin:
    ; Salir
    mov eax, 1             ; Llamada para salir
    xor ebx, ebx           ; Código de salida 0
    int 0x80

section .data
    msg_shl db "Desplazamiento a la izquierda: ", 0
    msg_shr db "Desplazamiento a la derecha: ", 0
