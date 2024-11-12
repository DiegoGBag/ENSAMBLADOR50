; ===============================================
; Autor: Diego Samuel Garcia Bagnis
; Fecha: 6 de Noviembre de 2024
; Descripción: Programa en Asembler64 que escribe
;              datos en un archivo.
;              Se incluye una versión en Python para referencia.
; ===============================================

; -------- Código en Python (comentado) ------------
; # Función para escribir en un archivo
; def escribir_en_archivo():
;     with open("salida.txt", "w") as archivo:
;         archivo.write("Hola, este es un archivo de prueba.")
; 
; # Ejemplo de uso
; escribir_en_archivo()
; ----------------------------------------------

section .data
    mensaje db "Hola, este es un archivo de prueba.", 0  ; Mensaje a escribir
    archivo db "salida.txt", 0                            ; Nombre del archivo
    mensaje_len equ $ - mensaje                           ; Longitud del mensaje

section .text
    global _start

_start:
    ; Abrir el archivo para escritura (sys_open)
    mov eax, 5                            ; Llamada al sistema para abrir archivo (sys_open)
    lea ebx, [archivo]                    ; Dirección del nombre del archivo
    mov ecx, 0101h                        ; Opción: O_WRONLY | O_CREAT
    mov edx, 0666h                        ; Permisos del archivo: lectura y escritura
    int 0x80                               ; Interrupción para ejecutar la llamada al sistema

    ; El descriptor de archivo se devuelve en eax
    mov ebx, eax                           ; Guardamos el descriptor de archivo

    ; Escribir el mensaje en el archivo (sys_write)
    mov eax, 4                            ; Llamada al sistema para escribir (sys_write)
    mov ecx, ebx                          ; Descriptor del archivo
    lea edx, [mensaje]                     ; Dirección del mensaje a escribir
    mov esi, mensaje_len                  ; Longitud del mensaje
    int 0x80                               ; Interrupción para ejecutar la llamada al sistema

    ; Cerrar el archivo (sys_close)
    mov eax, 6                            ; Llamada al sistema para cerrar archivo (sys_close)
    int 0x80                               ; Interrupción para ejecutar la llamada al sistema

    ; Salir del programa
    mov eax, 1                            ; Llamada para salir
    xor ebx, ebx                          ; Código de salida 0
    int 0x80
