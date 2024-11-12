; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que mide
;              el tiempo de ejecución de una función.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; import time
; 
; def funcion_a_tiempo():
;     # Simulamos una tarea que toma tiempo
;     total = 0
;     for i in range(1000000):
;         total += i
;     return total
; 
; # Medir el tiempo de ejecución
; start_time = time.time()
; funcion_a_tiempo()
; end_time = time.time()
; print(f"Tiempo de ejecución: {end_time - start_time} segundos")
; ----------------------------------------------

section .data
    msg_start db "Iniciando la funcion...", 0
    msg_end db "Funcion ejecutada. Tiempo de ejecucion: ", 0
    newline db 10, 0                     ; Nueva línea

section .bss
    start_time resq 1                    ; Espacio para almacenar el tiempo de inicio
    end_time resq 1                      ; Espacio para almacenar el tiempo de finalización
    result resq 1                        ; Espacio para el resultado

section .text
    global _start

_start:
    ; Imprimir mensaje de inicio
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [msg_start]
    mov edx, len msg_start
    int 0x80

    ; Obtener el tiempo de inicio (marco de tiempo del sistema)
    rdtsc                                  ; Lee el contador de tiempo en rdx (alta) y rax (baja)
    mov [start_time], rax                  ; Guardar el tiempo de inicio en start_time

    ; Llamada a la función (función que queremos medir)
    call funcion_a_tiempo

    ; Obtener el tiempo de finalización
    rdtsc                                  ; Leer nuevamente el contador de tiempo
    mov [end_time], rax                    ; Guardar el tiempo de finalización en end_time

    ; Calcular la diferencia entre el tiempo de inicio y final
    mov rax, [end_time]
    sub rax, [start_time]                  ; Resta el tiempo de inicio del tiempo final
    mov [result], rax                      ; Guardar el resultado en result

    ; Imprimir el mensaje final con el tiempo de ejecución
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [msg_end]
    mov edx, len msg_end
    int 0x80

    ; Imprimir el tiempo de ejecución (resultado de la resta)
    mov eax, 4                            ; Llamada al sistema para escribir
    mov ebx, 1                            ; Escribir en stdout
    lea ecx, [result]                     ; Dirección del resultado
    mov edx, 8                            ; Tamaño del resultado (8 bytes)
    int 0x80

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

funcion_a_tiempo:
    ; Simula una tarea que toma tiempo
    xor rbx, rbx                        ; Limpiar rbx (suma acumulada)
    mov rcx, 1000000                     ; Número de iteraciones
suma_loop:
    add rbx, rcx                         ; Incrementar suma
    loop suma_loop                       ; Bajar rcx y repetir si rcx != 0
    ret
