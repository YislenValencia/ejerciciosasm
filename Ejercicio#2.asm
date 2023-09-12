.data
    mensaje1: .asciiz "Ingresa el primer numero: "
    mensaje2: .asciiz "Ingresa el segundo numero: "
    mensaje3: .asciiz "Ingresa el tercer numero: "
    mensaje_menor: .asciiz "El numero menor es: "

.text
    # Imprime mensaje 1 y lee el primer número
    li $v0, 4
    la $a0, mensaje1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  # Guarda el primer número en $t0

    # Imprime mensaje 2 y lee el segundo número
    li $v0, 4
    la $a0, mensaje2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0  # Guarda el segundo número en $t1

    # Imprime mensaje 3 y lee el tercer número
    li $v0, 4
    la $a0, mensaje3
    syscall

    li $v0, 5
    syscall
    move $t2, $v0  # Guarda el tercer número en $t2

    # Compara los números para encontrar el menor
    # Suponemos que $t0 es el número menor inicialmente
    bgt $t1, $t0, menor1
    move $t0, $t1  # $t1 es el nuevo número menor
    j menor2

menor1:
    bgt $t2, $t0, menor2
    move $t0, $t2  # $t2 es el nuevo número menor

menor2:
    # Ahora $t0 contiene el número menor
    jal imprimir_menor
    j fin

imprimir_menor:
    # Imprime el número menor
    li $v0, 4
    la $a0, mensaje_menor
    syscall

    li $v0, 1
    move $a0, $t0  # Carga el número menor en $a0
    syscall

fin:
    # Termina el programa
    li $v0, 10
    syscall