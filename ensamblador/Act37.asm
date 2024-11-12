; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que implementa
;              una pila (push y pop) usando un arreglo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; class Pila:
;     def __init__(self, capacidad):
;         self.capacidad = capacidad
;         self.pila = []
;
;     def push(self, elemento):
;         if len(self.pila) < self.capacidad:
;             self.pila.append(elemento)
;         else:
;             raise OverflowError("Pila llena")
;
;     def pop(self):
;         if not self.esta_vacia():
;             return self.pila.pop()
;         else:
;             raise IndexError("Pila vacía")
;
;     def esta_vacia(self):
;         return len(self.pila) == 0
;
;     def esta_llena(self):
;         return len(self.pila) == self.capacidad
;
; pila = Pila(5)
; pila.push(10)
; pila.push(20)
; print("Elemento extraído:", pila.pop())  # Resultado: 20
; ----------------------------------------------

section .data
    capacidad db 5                    ; Capacidad máxima de la pila
    pila db 0, 0, 0, 0, 0             ; Arreglo para almacenar la pila
    top db -1                         ; Índice del elemento en la cima de la pila
    msg_push db "Elemento insertado en la pila.", 0
    msg_pop db "Elemento extraído de la pila: ", 0
    msg_overflow db "Error: Pila llena.", 0
    msg_underflow db "Error: Pila vacía.", 0

section .bss
    temp resb 1                       ; Variable temporal para operaciones de pila

section .text
    global _start

_start:
    ; Empujar un elemento en la pila
    mov al, 10                        ; Elemento a insertar
    call push

    mov al, 20                        ; Otro elemento a insertar
    call push

    ; Extraer el elemento superior de la pila
    call pop

    ; Salir del programa
    jmp fin_programa

; ------------------- Función push -------------------
; Inserta un elemento en la cima de la pila
push:
    ; Verificar si la pila está llena (top == capacidad - 1)
    mov al, [top]
    inc al
    cmp al, [capacidad]
    je pila_llena                     ; Si top == capacidad - 1, la pila está llena

    ; Aumentar el índice de la cima
    inc byte [top]
    mov al, [top]                     ; Obtener el índice de la cima
    mov bl, [esp + 4]                 ; Obtener el valor a insertar (argumento)
    mov [pila + eax], bl              ; Almacenar en la cima

    ; Imprimir mensaje de éxito
    mov eax, 4                        ; Llamada al sistema para escribir
    mov ebx, 1                        ; Escribir en salida estándar (stdout)
    lea ecx, [msg_push]
    mov edx, len msg_push
    int 0x80
    ret

pila_llena:
    ; Imprimir mensaje de error de desbordamiento
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_overflow]
    mov edx, len msg_overflow
    int 0x80
    ret

; ------------------- Función pop -------------------
; Extrae el elemento en la cima de la pila
pop:
    ; Verificar si la pila está vacía (top == -1)
    cmp byte [top], -1
    je pila_vacia                    ; Si top == -1, la pila está vacía

    ; Obtener el valor de la cima
    mov al, [top]
    mov bl, [pila + eax]             ; Almacenar el valor extraído en BL
    mov [temp], bl                   ; Guardar temporalmente en temp

    ; Disminuir el índice de la cima
    dec byte [top]

    ; Imprimir mensaje y el valor extraído
    mov eax, 4                       ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [msg_pop]
    mov edx, len msg_pop
    int 0x80

    ; Imprimir el valor extraído
    mov eax, 4
    mov ebx, 1
    mov ecx, temp                    ; Dirección del valor extraído
    mov edx, 1                       ; Tamaño del elemento (1 byte)
    int 0x80
    ret

pila_vacia:
    ; Imprimir mensaje de error de subdesbordamiento
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_underflow]
    mov edx, len msg_underflow
    int 0x80
    ret

fin_programa:
    ; Salir del programa
    mov eax, 1                       ; Llamada para salir
    xor ebx, ebx                     ; Código de salida 0
    int 0x80
