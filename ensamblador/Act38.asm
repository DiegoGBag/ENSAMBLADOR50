; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que implementa
;              una cola (enqueue y dequeue) usando un arreglo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; class Cola:
;     def __init__(self, capacidad):
;         self.capacidad = capacidad
;         self.cola = [None] * capacidad
;         self.frente = 0
;         self.final = -1
;         self.size = 0
;
;     def enqueue(self, elemento):
;         if self.size == self.capacidad:
;             raise OverflowError("Cola llena")
;         self.final = (self.final + 1) % self.capacidad
;         self.cola[self.final] = elemento
;         self.size += 1
;
;     def dequeue(self):
;         if self.size == 0:
;             raise IndexError("Cola vacía")
;         elemento = self.cola[self.frente]
;         self.frente = (self.frente + 1) % self.capacidad
;         self.size -= 1
;         return elemento
;
; cola = Cola(5)
; cola.enqueue(10)
; cola.enqueue(20)
; print("Elemento extraído:", cola.dequeue())  # Resultado: 10
; ----------------------------------------------

section .data
    capacidad db 5                    ; Capacidad máxima de la cola
    cola db 0, 0, 0, 0, 0             ; Arreglo para almacenar la cola
    frente db 0                       ; Índice del frente de la cola
    final db -1                       ; Índice del final de la cola
    size db 0                         ; Tamaño actual de la cola
    msg_enqueue db "Elemento insertado en la cola.", 0
    msg_dequeue db "Elemento extraído de la cola: ", 0
    msg_overflow db "Error: Cola llena.", 0
    msg_underflow db "Error: Cola vacía.", 0

section .bss
    temp resb 1                       ; Variable temporal para almacenar el elemento extraído

section .text
    global _start

_start:
    ; Insertar elementos en la cola
    mov al, 10                        ; Elemento a insertar
    call enqueue

    mov al, 20                        ; Otro elemento a insertar
    call enqueue

    ; Extraer un elemento de la cola
    call dequeue

    ; Salir del programa
    jmp fin_programa

; ------------------- Función enqueue -------------------
; Inserta un elemento en el final de la cola
enqueue:
    ; Verificar si la cola está llena (size == capacidad)
    mov al, [size]
    cmp al, [capacidad]
    je cola_llena                     ; Si size == capacidad, la cola está llena

    ; Actualizar el índice del final en la cola de manera circular
    mov al, [final]
    inc al
    mov bl, [capacidad]
    div bl                             ; Final = (final + 1) % capacidad
    mov [final], ah                    ; Almacenar el nuevo índice de final
    mov al, [esp + 4]                  ; Obtener el valor a insertar (argumento)
    mov [cola + ebx], al               ; Almacenar el valor en la posición final

    ; Incrementar el tamaño de la cola
    inc byte [size]

    ; Imprimir mensaje de éxito
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1                         ; Escribir en salida estándar (stdout)
    lea ecx, [msg_enqueue]
    mov edx, len msg_enqueue
    int 0x80
    ret

cola_llena:
    ; Imprimir mensaje de error de desbordamiento
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_overflow]
    mov edx, len msg_overflow
    int 0x80
    ret

; ------------------- Función dequeue -------------------
; Extrae el elemento en el frente de la cola
dequeue:
    ; Verificar si la cola está vacía (size == 0)
    cmp byte [size], 0
    je cola_vacia                     ; Si size == 0, la cola está vacía

    ; Obtener el valor en el frente
    mov al, [frente]
    mov bl, [cola + eax]              ; Almacenar el valor extraído en BL
    mov [temp], bl                    ; Guardar temporalmente en temp

    ; Actualizar el índice del frente en la cola de manera circular
    inc byte [frente]
    mov bl, [capacidad]
    div bl                             ; Frente = (frente + 1) % capacidad
    mov [frente], ah

    ; Disminuir el tamaño de la cola
    dec byte [size]

    ; Imprimir mensaje y el valor extraído
    mov eax, 4                         ; Llamada al sistema para escribir
    mov ebx, 1
    lea ecx, [msg_dequeue]
    mov edx, len msg_dequeue
    int 0x80

    ; Imprimir el valor extraído
    mov eax, 4
    mov ebx, 1
    mov ecx, temp                      ; Dirección del valor extraído
    mov edx, 1                         ; Tamaño del elemento (1 byte)
    int 0x80
    ret

cola_vacia:
    ; Imprimir mensaje de error de subdesbordamiento
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_underflow]
    mov edx, len msg_underflow
    int 0x80
    ret

fin_programa:
    ; Salir del programa
    mov eax, 1                         ; Llamada para salir
    xor ebx, ebx                       ; Código de salida 0
    int 0x80
