			lui $v1, 0xf000				# 设置IO端口地址，$v1=SW/LED地址=F00000000
			addi $s4, $zero, 0x3f		# 设置常数3F
			lui $t0, 0x8000				# 截取Counter0_OUT常数
			add $a0, $v1, $v1			# 设置IO端口地址,$a0=7-seg地址=E00000000
			addi $v0, $zero, 1			# 常数$v0=1
			nor $at, $zero, $zero		# 常数FFFFFFFFF
			add $t2, $at, $zero
			addi $a3, $zero, 3
			nor $a3, $a3, $a3			# $a3=FFFFFFFC
			addi $a2, $zero, 0x7fff		# $a2=0000ffff, 计数初值
			add $s1, $zero, $zero		# $s1=00000000,初始化7段图形数据基地址
			addi $a1, $zero, 0x2AB		# $a1=000002AB=……1010101011
			sw $a1, 0x0($v1)			# 设置计数器通道counter_set=11控制端口和LED初始化值： {GPIOf0[13:0],LED,counter_set}
			addi $s2, $zero, 2			#
			sw $zero, 4($v1)			# 设置计数器初值
			lw $a1, ($v1)				# 读进SW开关的状态:{counter0_out,counter1_out,counter2_out,led_out[12:0], SW}
			add $a1, $a1, $a1			# 对齐SW输入与LED输出
			add $a1, $a1, $a1			# 保持计数通道0，对齐SW输入=LED输出
			sw $a1, ($v1)				# 设置计数器通道counter_set=00控制端口、LED=SW： {GPIOf0[13:0],LED,counter_set}
			sw $a2, 4($v1)				# 设置计数器初值counter ch0 :f0000004计数器地址，减数计数，一直到00000000为止
			lui $t5, 0xFFFF				# $t5=FFFF0000
loop:		lw $a1, 0($v1)				# 读进SW开关的状态:{counter0_out,counter1_out,counter2_out,led_out[12:0], SW}
			add $a1, $a1, $a1			# 对齐SW输入与LED输出
			add $a1, $a1, $a1			# 保持计数通道0，对齐SW输入=LED输出
			sw $a1, 0($v1)				# 设置计数器通道counter_set=00控制端口、LED=SW：{GPIOf0[13:0],LED,counter_set}
			lw $a1, 0($v1)				# 重读F00000000端口
			and $t3, $a1, $t0			# 截取Counter0_out，$t0=80000000
			addi $t5, $t5, 1			# 程序(软件)计数延时
			beq $t5, $zero, Next		# 程序计数延时结束，修改7段码显示
Disp:		lw $a1, 0($v1)				# 判断7段码显示模式：SW[4:3]控制
			addi $s2, $zero, 0x18		# $18=00000018(00011000)
			and $t3, $a1, $s2
			beq $t3, $zero,L00			# SW[4:3]=00,7段显示"点"循环移位：L))，SW0=0
			beq $t3, $s2, L11			# SW[4:3]=11，显示七段图形，L11，SW0=0
			addi $s2, $zero, 8			# $s2=8=00001000
			beq $t3, $s2, L01			# SW[4:3]=01,七段显示预置数字，L01，SW0=1
			sw $t1, ($a0)				# SW[4:3]=10，显示r9，SW0=1
			j loop	
L00:		beq $t2, $at, L4			# $10=ffffffff, 转移L4
			j L3	
L4:			nor $t2, $zero, $zero		# $10=ffffffff
			add $t2, $t2, $t2			# $10=fffffffe
L3:			sw $t2, ($a0)				# SW[4:3]=00,7段显示点移位后显示
			j loop	
L11:		lw $t1, 0x2A0($s1)
			sw $t1, ($a0)				# SW[4:3]=11，显示七段图形
			j loop
L01:		lw $t1, 0x260($s1)
			sw $t1, ($a0)				# SW[4:3]=01,七段显示预置数字
			j loop
Next:		lui $t5, 0xffff				# 计数结束，修改显示和计数重置
			add $t2, $t2, $t2			# $10=fffffffc，7段图形点左移
			or $t2, $t2, $v0			# r10末位置1，对应右上角不显示
			addi $s1, $s1, 4			# r17=00000004，LED图形访存地址+4
			and $s1, $s1, $s4			# r17=000000XX，屏蔽地址高位，只取6位
			addi $t1, $t1, 1			# r9+1
			beq $t1, $at, L6			# 若r9=ffffffff,重置r9=5
			j L7
L6:			addi $t1, $t1, 5			# $9=00000005
L7:			lw $a1, 0($v1)
			add $t3, $a1, $a1			# 对齐SW输入与LED输出
			add $t3, $t3, $t3			# 设置计数通道0，保持SW输入=LED输出
			sw $t3, 0($v1)				# 设置计数通道0
			sw $a2, 4($v1)				# 设置计数器初值
			j Disp