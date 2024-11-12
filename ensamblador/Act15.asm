; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 para realizar
;              una búsqueda binaria en un arreglo ordenado.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; def busqueda_binaria(arreglo, valor):
;     inicio = 0Act
;     fin = len(arreglo) - 1
;     while inicio <= fin:
;         medio = (inicio + fin) // 2
;         if arreglo[medio] == valor:
;             return medio  # Índice del valor encontrado
;         elif arreglo[medio] < valor:
;             inicio = medio + 1
;         else:
;             fin = medio - 1
;     return -1  # Valor no encontrado
;
; arreglo = [1, 3, 5, 7, 9, 11]
; valor = 7
; indice = busqueda_binaria(arreglo, valor)
; if indice != -1:
;     print("Valor encontrado en el índice:", indice)
; else:
;     print("Valor no encontrado")
; ----------------------------------------------

section .data
    arreglo db 1, 3, 5, 7, 9, 11       ; Arreglo ordenado de números
    valor db 7                          ; Valor a buscar
    msg_encontrado db "Valor encontrado en el índice: ", 0
    msg_no_encontrado db "Valor no encontrado", 0
    indice resb 1                       ; Variable para almacenar el índice si se encuentra el valor

section .bss
    inicio resb 1                       ; Límite inferior para la búsqueda
    fin resb 1                          ; Límite superior para la búsqueda
    medio resb 1                        ; Índice medio del arreglo

section .text
    global _start

_start:
    ; Inicializar los límites para la búsqueda binaria
    mov byte [inicio], 0                ; inicio = 0
    mov byte [fin], 5                   ; fin = tamaño del arreglo - 1

busqueda_binaria:
    ; Calcular el índice medio: medio = (inicio + fin) / 2
    mov al, [inicio]
    add al, [fin]
    shr al, 1                           ; Dividir por 2
    mov [medio], al                     ; Guardar en 'medio'

    ; Comparar el valor en el índice medio con el valor buscado
    mov al, [arreglo + rax]             ; Cargar arreglo[medio] en AL
    cmp al, byte [valor]                ; Comparar con el valor buscado
    je encontrado                       ; Si son iguales, valor encontrado

    ; Si arreglo[medio] < valor, buscar en la mitad superior
    jl mitad_superior

    ; Si arreglo[medio] > valor, buscar en la mitad inferior
    mov al, [medio]
    dec al                              ; fin = medio - 1
    mov [fin], al
    jmp verificar_limites

mitad_superior:
    mov al, [medio]
    inc al                              ; inicio = medio + 1
    mov [inicio], al

verificar_limites:
    ; Verificar si inicio <= fin
    mov al, [inicio]
    cmp al, [fin]
    jle busqueda_binaria                ; Si inicio <= fin, continuar la búsqueda

no_encontrado:
    ; Imprimir mensaje de valor no encontrado
    mov eax, 4                          ; Llamada al sistema para escribir
    mov ebx, 1                          ; Escribir en salida estándar (stdout)
    lea ecx, [msg_no_encontrado]        ; Mensaje "Valor no encontrado"
    mov edx, len msg_no_encontrado      ; Longitud del mensaje
    int 0x80                            ; Llamada a la interrupción del sistema
    jmp fin

encontrado:
    mov [indice], al                    ; Guardar el índice donde se encontró el valor

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

fin:
    ; Salir
    mov eax, 1                          ; Llamada para salir
    xor ebx, ebx                        ; Código de salida 0
    int 0x80
