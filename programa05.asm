.data
	msg: .asciiz "\nInsira um numero inteiro positivo N: "
	msgPerfeito: .asciiz "N eh um inteiro perfeito.\n"
	msgNaoPerfeito: .asciiz "N nao e um inteiro perfeito."
	erro: .asciiz "O numero inserido nao e um inteiro positivo. Favor inserir novamente.\n"
	
.text

	leitura:
		li $v0, 4	# imprimir uma string
		la $a0, msg	# imprime msg
		syscall
		li $v0, 5	# leitura do inteiro N
		syscall
		move $t0, $v0			# movendo o inteiro N inserido para o registrador $t0, $t0 = N
		
		beq $t0, $zero, imprimeNaoPerfeito	# zero nao eh um inteiro perfeito e nao pode ser verificado atraves dos calculos, entao se torna uma excessao
		ble $t0, $zero, msgerro		# se N <= 0, ocorre erro na leitura
		
	
# ----------------------------------------------------------------------------------------------------------------------

	li $t1, 1	# contador i, $t1 = 1 	
	li $t9, 0	# $t9 vai armazenar a soma dos divisores de N
	
	# verificando se o contador i � divisor de N
	verificador:
	
		beq $t1, $t0, fim	# se $t1 = N, sai do loop
	
		div $t0, $t1	# N / i
		mfhi $t2	# resto da divis�o vai para $t3
		
		beq $t2, $zero, ehDivisor
		
		# se o resto da divis�o n�o for zero, n�o � divisor de N, vai pro pr�ximo n�mero
		addi $t1, $t1, 1	# acrescentando 1 ao contador i
		j verificador
		
	# realizando a soma dos divisores de N
	ehDivisor:
		add $t9, $t9, $t1	# armazenando a soma dos divisores no registrador $t9
		addi $t1, $t1, 1	# acrescentando 1 ao contador i
		j verificador



	fim:
		beq $t9, $t0, imprimePerfeito		# se a soma for igual ao N, � perfeito
		bne $t9, $t0, imprimeNaoPerfeito	# se a soma for diferente de N, n�o � perfeito
		
	imprimePerfeito:
		# imprimindo a mensagem que diz que N � inteiro perfeito
		li $v0, 4		# comando para imprimir uma string
		la $a0, msgPerfeito	# imprime msgPerfeito	
		syscall
		li $v0, 10	# encerra o programa
		syscall
		
		
	imprimeNaoPerfeito:
		# imprimindo a mensagem que diz que N � inteiro perfeito
		li $v0, 4		# comando para imprimir uma string
		la $a0, msgNaoPerfeito	# imprime msgNaoPerfeito	
		syscall
		li $v0, 10	# encerra o programa
		syscall

	msgerro:
		# caso o usuario tenha inserido um numero menor ou igual a zero, imprime uma mensagem de erro e faz a leitura novamente
		li $v0, 4	# imprimir uma string
		la $a0, erro	# imprime erro
		syscall	
		j leitura	# volta para fazer a leitura de um numero correto
		
		




