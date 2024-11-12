; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que calcula el
;              Mínimo Común Múltiplo (MCM) de dos números
;              usando el MCD.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def calcular_mcd(a, b):
;     while b != 0:
;         a, b = b, a % b
;     return a
; 
; def calcular_mcm(a, b):
;     mcd = calcular_mcd(a, b)
;     return abs(a * b) // mcd
; 
; numero1 = 48
; numero2 = 18
; print("MCM:", calcular_mcm(numero1, numero2))  # Resultado: 144
; ----------------------------------------------

section .data
    num1 db 48               ; Primer número (48)
    num2 db 18               ; Segundo número (18)
    msg db "MCM: ", 0

section .bss
    mcd_result resb 1        ; Espacio para almacenar el resultado del MCD
    mcm_result resb 2        ; Espacio para almacenar el resultado del MCM

section .text
    global _start

_start:
    ; Cargar los valores iniciales de num1 y num2
    mov al, [num1]           ; Cargar num1 en AL
    mov bl, [num2]           ; Cargar num2 en BL
    push ax                  ; Guardar el valor original de AL
    push bx                  ; Guardar el valor original de BL

; Calcular el MCD de num1 y num2 usando el algoritmo de Euclides
calcular_mcd:
    cmp bl, 0
    je almacenar_mcd         ; Si BL es 0, AL contiene el MCD

    mov ah, 0                ; Limpiar AH para la división
    div bl                   ; AL = AL / BL, residuo en AH
    mov al, bl               ; AL toma el valor de BL (nuevo a)
    mov bl, ah               ; BL toma el residuo (nuevo b)
    jmp calcular_mcd

almacenar_mcd:
    mov [mcd_result], al     ; Guardar el MCD en mcd_result
    pop bx                   ; Restaurar el valor original de BL (num2)
    pop ax                   ; Restaurar el valor original de AL (num1)

; Calcular el MCM usando la fórmula: (num1 * num2) / MCD
    mov cl, al               ; Guardar num1 en CL
    imul bl                  ; Multiplica num1 (AL) por num2 (BL), resultado en AX
    mov dl, [mcd_result]     ; Cargar el MCD en DL
    div dl                   ; Divide AX entre el MCD (DL), cociente en AL

    mov [mcm_result], ax     ; Guardar el MCM en mcm_result

; Imprimir el mensaje "MCM: "
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1               ; Escribir en salida estándar (stdout)
    lea ecx, [msg]           ; Mensaje para MCM
    mov edx, len msg
    int 0x80                 ; Llamada al sistema

; Imprimir el resultado del MCM
    mov eax, 4               ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [mcm_result]    ; Cargar el resultado del MCM
    mov edx, 2               ; Tamaño del resultado
    int 0x80                 ; Imprimir el MCM

; Salir
    mov eax, 1               ; Llamada para salir
    xor ebx, ebx             ; Código de salida 0
    int 0x80
