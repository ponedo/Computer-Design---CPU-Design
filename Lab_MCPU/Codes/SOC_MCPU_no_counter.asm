			lui $v1, 0xf000				# ����IO�˿ڵ�ַ��$v1=SW/LED��ַ=F00000000
			addi $s4, $zero, 0x3f		# ���ó���3F
			lui $t0, 0x8000				# ��ȡCounter0_OUT����
			add $a0, $v1, $v1			# ����IO�˿ڵ�ַ,$a0=7-seg��ַ=E00000000
			addi $v0, $zero, 1			# ����$v0=1
			nor $at, $zero, $zero		# ����FFFFFFFFF
			add $t2, $at, $zero
			addi $a3, $zero, 3
			nor $a3, $a3, $a3			# $a3=FFFFFFFC
			addi $a2, $zero, 0x7fff		# $a2=0000ffff, ������ֵ
			add $s1, $zero, $zero		# $s1=00000000,��ʼ��7��ͼ�����ݻ���ַ
			addi $a1, $zero, 0x2AB		# $a1=000002AB=����1010101011
			sw $a1, 0x0($v1)			# ���ü�����ͨ��counter_set=11���ƶ˿ں�LED��ʼ��ֵ�� {GPIOf0[13:0],LED,counter_set}
			addi $s2, $zero, 2			#
			sw $zero, 4($v1)			# ���ü�������ֵ
			lw $a1, ($v1)				# ����SW���ص�״̬:{counter0_out,counter1_out,counter2_out,led_out[12:0], SW}
			add $a1, $a1, $a1			# ����SW������LED���
			add $a1, $a1, $a1			# ���ּ���ͨ��0������SW����=LED���
			sw $a1, ($v1)				# ���ü�����ͨ��counter_set=00���ƶ˿ڡ�LED=SW�� {GPIOf0[13:0],LED,counter_set}
			sw $a2, 4($v1)				# ���ü�������ֵcounter ch0 :f0000004��������ַ������������һֱ��00000000Ϊֹ
			lui $t5, 0xFFFF				# $t5=FFFF0000
loop:		lw $a1, 0($v1)				# ����SW���ص�״̬:{counter0_out,counter1_out,counter2_out,led_out[12:0], SW}
			add $a1, $a1, $a1			# ����SW������LED���
			add $a1, $a1, $a1			# ���ּ���ͨ��0������SW����=LED���
			sw $a1, 0($v1)				# ���ü�����ͨ��counter_set=00���ƶ˿ڡ�LED=SW��{GPIOf0[13:0],LED,counter_set}
			lw $a1, 0($v1)				# �ض�F00000000�˿�
			and $t3, $a1, $t0			# ��ȡCounter0_out��$t0=80000000
			addi $t5, $t5, 1			# ����(���)������ʱ
			beq $t5, $zero, Next		# ���������ʱ�������޸�7������ʾ
Disp:		lw $a1, 0($v1)				# �ж�7������ʾģʽ��SW[4:3]����
			addi $s2, $zero, 0x18		# $18=00000018(00011000)
			and $t3, $a1, $s2
			beq $t3, $zero,L00			# SW[4:3]=00,7����ʾ"��"ѭ����λ��L))��SW0=0
			beq $t3, $s2, L11			# SW[4:3]=11����ʾ�߶�ͼ�Σ�L11��SW0=0
			addi $s2, $zero, 8			# $s2=8=00001000
			beq $t3, $s2, L01			# SW[4:3]=01,�߶���ʾԤ�����֣�L01��SW0=1
			sw $t1, ($a0)				# SW[4:3]=10����ʾr9��SW0=1
			j loop	
L00:		beq $t2, $at, L4			# $10=ffffffff, ת��L4
			j L3	
L4:			nor $t2, $zero, $zero		# $10=ffffffff
			add $t2, $t2, $t2			# $10=fffffffe
L3:			sw $t2, ($a0)				# SW[4:3]=00,7����ʾ����λ����ʾ
			j loop	
L11:		lw $t1, 0x2A0($s1)
			sw $t1, ($a0)				# SW[4:3]=11����ʾ�߶�ͼ��
			j loop
L01:		lw $t1, 0x260($s1)
			sw $t1, ($a0)				# SW[4:3]=01,�߶���ʾԤ������
			j loop
Next:		lui $t5, 0xffff				# �����������޸���ʾ�ͼ�������
			add $t2, $t2, $t2			# $10=fffffffc��7��ͼ�ε�����
			or $t2, $t2, $v0			# r10ĩλ��1����Ӧ���Ͻǲ���ʾ
			addi $s1, $s1, 4			# r17=00000004��LEDͼ�ηô��ַ+4
			and $s1, $s1, $s4			# r17=000000XX�����ε�ַ��λ��ֻȡ6λ
			addi $t1, $t1, 1			# r9+1
			beq $t1, $at, L6			# ��r9=ffffffff,����r9=5
			j L7
L6:			addi $t1, $t1, 5			# $9=00000005
L7:			lw $a1, 0($v1)
			add $t3, $a1, $a1			# ����SW������LED���
			add $t3, $t3, $t3			# ���ü���ͨ��0������SW����=LED���
			sw $t3, 0($v1)				# ���ü���ͨ��0
			sw $a2, 4($v1)				# ���ü�������ֵ
			j Disp