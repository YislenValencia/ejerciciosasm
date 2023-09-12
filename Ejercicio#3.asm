# El programa calcula el valor que se encuentra en la posición
# que ingresa el usuario.
# Ej: la serie de fibonacci = 1,1,2,3,5,8,13,21,34...
# Si el usuario ingresa numero 8, el programa imprimira el valor
# que se encuentra en esa posición, en este caso "21".

# Formula de fibonacci
# 
# n se representara con $a0
# int fibonacci (int n){
# 	if (n <= 1)
#		return n;
#	else
#		return fibonacci (n-1)+fibonacci(n-2);

# Código
.data
dato: .asciiz "Este programa calcula la secuencia de Fibonacci con funciones recursivas.\nIngrese un número = "
mensaje: .asciiz "Fibonacci evaluado en = "
resultado: .asciiz "\nFibonacci evaluado en dato = "
endl: .asciiz "\n"

.text
main:

# Lee la entrada "dato" ingresada por el usuario
	la $a0, dato	# Imprime el valor "dato"
	li $v0, 4 	
	syscall
# Leer el valor "dato" como tipo entero
	li $v0, 5
	syscall

	move $t2, $v0   # Movemos el valor a n a la dirección $t2
# Funciín para llamar a Fibonacci y obtener su valor #dato
	move $a0, $t2
	move $v0, $t2
	jal fibonacci   # Llama fibonacci (dato)
	move $t3, $v0   # Resulatdo esta en la dirección $t3
# Mensaje y dato
	la $a0, mensaje	# Print "Fibonacci evaluado en = + dato"
	li $v0, 4		
	syscall

	move $a0, $t2    # Imprime dato
	li $v0, 1
	syscall

	la $a0, resultado  # Print "Fibonacci en N"
	li $v0, 4
	syscall

	move $a0, $t3    # Imprime la respuesta
	li $v0, 1
	syscall

	la $a0, endl 	# Print el mssg end "\n", salto de linea
	li $v0, 4
	syscall

	li $v0, 10 	# Fin del programa
	syscall

fibonacci:

# Calcular y devolver el número de Fibonacci
	beqz $a0, zero   # Si el valor ingresado es igual a 0, retorna el valor 0
	beq $a0, 1, one   # Si el valor ingresado es igual a 1, retorna el valor 1

# Llamada al Fibonacci (dato - 1)
	sub $sp, $sp, 4   # Almacenamiento de la dirección del retorno de la pila
	sw $ra, 0($sp)

	sub $a0, $a0, 1    # dato - 1
	jal fibonacci   	 # fibonacci (dato - 1)
	add $a0, $a0, 1

	lw $ra, 0($sp)   # Restaura la dirección de retorno de la pila
	add $sp, $sp, 4

	sub $sp, $sp, 4   # Push el valor de retorno a la pila
	sw $v0, 0($sp)
	
# Llamada a fibonnaci (dato - 2)
	sub $sp, $sp, 4   # Almacenamiento de la dirección del retorno de la pila
	sw $ra, 0($sp)

	sub $a0, $a0, 2   # dato - 2
	jal fibonacci   	# fibonacci (dato - 2)
	add $a0, $a0, 2

	lw $ra, 0($sp)   # Restaura la dirección de retorno de la pila
	add $sp, $sp, 4

	lw $s7, 0($sp)   # Pop valor de retorno de la pila
	add $sp, $sp, 4

	add $v0, $v0, $s7 # fibonacci(dato - 2) + fibonacci (dato - 1)
	jr $ra # Decremento/Siguiente de la pila

zero:
	li $v0, 0 # Función que retorno los el valor 0
	jr $ra 

one:
	li $v0, 1 # Función que retorno los el valor 1
	jr $ra

