; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que verifica 
;              si un número es un número de Armstrong.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def es_armstrong(numero):
;     # Convertir el número a una lista de dígitos
;     digitos = [int(d) for d in str(numero)]
;     n = len(digitos)
;     suma = sum(d ** n for d in digitos)
;     return suma == numero
; 
; # Ejemplo de uso
; numero = 153
; if es_armstrong(numero):
;     print(f"{numero} es un número de Armstrong")
; else:
;     print(f"{numero} no es un número de Armstrong")
; ----------------------------------------------

section .data
    msg_yes db "Es un numero de Armstrong.", 0
    msg_no db "No es un numero de Armstrong.", 0
    newline db 10, 0                     ; Nueva línea
    numero dq 153                        ; Número a verificar (puede cambiarse)

section .bss
    suma resq 1                          ; Espacio para la suma de los dígitos elevados
    temp resq 1                          ; Espacio temporal para cada dígito

section .text
    global _start

_start:
    ; Cargar el número a verificar
    mov rsi, [numero]                   ; Cargar el número en rsi

    ; Calcular el número de dígitos (n)
    mov rax, rsi                        ; Copiar número en rax
    xor rcx, rcx                        ; Limpiar rcx (contador de dígitos)
digit_count:
    div rdx                              ; Dividir rax por 10, rdx = residuo (último dígito)
    inc rcx                              ; Incrementar el contador de dígitos
    test rax, rax                        ; Verificar si el cociente es 0
    jnz digit_count                      ; Si no es 0, continuar contando dígitos

    ; Guardar el número de dígitos en rdx (n)
    mov rdx, rcx                        ; Guardar la cantidad de dígitos en rdx

    ; Restablecer rsi a su valor original
    mov rsi, [numero]

    ; Calcular la suma de los dígitos elevados a la potencia de n
    xor rax, rax                         ; Limpiar rax (suma acumulada)
    mov rcx, rdx                         ; rcx = n (número de dígitos)
sum_digits:
    mov rbx, rsi                         ; Copiar número original en rbx
    div rdx                               ; Dividir por 10
    mov rbx, rdx                         ; rbx = dígito
    imul rbx, rbx                        ; rbx = dígito ^ n (elevado a la potencia de n)
    add rax, rbx                         ; Sumar el valor al acumulador
    test rsi, rsi                        ; Verificar si quedan dígitos
    jnz sum_digits                       ; Si quedan más dígitos, continuar

    ; Comparar la suma con el número original
    mov rbx, [numero]                    ; Cargar el número original en rbx
    cmp rax, rbx                         ; Comparar suma con el número
    je armstrong                         ; Si son iguales, es un número de Armstrong

    ; Si no es Armstrong, imprimir mensaje "No es un numero de Armstrong"
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [msg_no]
    mov edx, len msg_no
    int 0x80
    jmp fin

armstrong:
    ; Si es Armstrong, imprimir mensaje "Es un numero de Armstrong"
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [msg_yes]
    mov edx, len msg_yes
    int 0x80

fin:
    ; Salir del programa
    mov eax, 1                            ; Llamada para salir
    xor ebx, ebx                          ; Código de salida 0
    int 0x80
