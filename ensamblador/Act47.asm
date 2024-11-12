; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que detecta
;              el desbordamiento en una operación de suma.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def detectar_desbordamiento(a, b):
;     try:
;         resultado = a + b
;         # Si la suma excede los límites, se lanza una excepción
;         if resultado > 2147483647 or resultado < -2147483648:
;             raise OverflowError("Desbordamiento detectado")
;         return resultado
;     except OverflowError as e:
;         return str(e)
; 
; # Ejemplo de uso
; a = 2147483647
; b = 1
; print(detectar_desbordamiento(a, b))  # Detectará el desbordamiento
; ----------------------------------------------

section .data
    msg_no_overflow db "No hubo desbordamiento.", 0
    msg_overflow db "Desbordamiento detectado.", 0
    newline db 10, 0                     ; Nueva línea

section .bss
    result resq 1                        ; Espacio para el resultado de la suma

section .text
    global _start

_start:
    ; Cargar los valores a sumar (por ejemplo, 2147483647 + 1)
    mov rsi, 2147483647                  ; Primer operando a
    mov rdi, 1                            ; Segundo operando b

    ; Sumar los números
    add rsi, rdi                          ; rsi = rsi + rdi (a + b)

    ; Comprobar si hubo desbordamiento
    jo overflow_detected                 ; Si hubo desbordamiento, salta a overflow_detected

    ; Si no hubo desbordamiento, imprimir "No hubo desbordamiento"
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [msg_no_overflow]
    mov edx, len msg_no_overflow
    int 0x80

    jmp fin                               ; Saltar al final del programa

overflow_detected:
    ; Si hubo desbordamiento, imprimir "Desbordamiento detectado"
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [msg_overflow]
    mov edx, len msg_overflow
    int 0x80

fin:
    ; Imprimir salto de línea
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [newline]                    ; Nueva línea
    mov edx, 1                            ; Longitud de nueva línea
    int 0x80

    ; Salir del programa
    mov eax, 1                            ; Llamada para salir
    xor ebx, ebx                          ; Código de salida 0
    int 0x80
