reset:       j start
            nop
exc_base:    mfc0 $26, $13 # c0_cause
            andi $27, $26, 0xc
            lw   $27, 0x33($27) #j_table is 0x33
            jr   $27
int_entry:   sw $a2, 4($v1) #�������˿�:F0000004���ͼ�������
            addi $s1, $s1, 4 #r17=r17+00000004��LEDͼ�ηô��ַ+4
L4:         lw $a1, 0($v1) #��GPIO�˿�F0000000״̬:{counter0_out,counter1_out,counter2_out,led_out[12:0], SW} 
            sll $t3, $a1, 2 #����2λ��SW��LED���룬ͬʱD1D0��00��ѡ�������ͨ��0
            sw $t3, 0($v1) #r5�����GPIO�˿�0xF0000000��������ͨ��counter_set=00�˿ڲ��䡢LED=SW�� {GPIOf0[13:0],LED,counter_set}
            lw $a1, 0($v1)
            and $t3, $a1, $t0
            beq $t3, $t0, L4 #���ж��ź�δ��ʧ�����ӳ��жϴ�������Ӻ�eret
            eret #Next ends
sys_entry:   lw $a3, 0($v1)#������״̬
            addi $s2, $zero, 0x0008	#r18=0x00000008
            add $s6, $s2, $s2 #r22=0x00000010
            add $s2, $s2, $s6 #r18=0x00000018(00011000b)
            and $t3, $a3, $s2 #ȡSW[4:3]
            beq $t3, $zero, L00 #SW[4:3]=00,����ƣ�L00��SW0=0
            addi $s2, $zero, 0x0008	#r18=8
            beq $t3, $s2, L01 #SW[4:3]=01,����任��L01��SW0=1
L00:        add $s0, $s1, $zero #r16=��ǰ���ʵ�ַ=r17+�����������ʼ��ַ(0x00000000)
            addi $s3, $zero, 0x1f #r19=��������ݸ�����31+1=32����
            j bound_check
L01:        addi $s0, $s1, 0x20 #r16=��ǰ���ʵ�ַ=r17+����任������ʼ��ַ(0x00000020)
            addi $s3, $zero, 0x12 #r19=����任���ݸ�����18+1=19����
bound_check: sub $t2, $s3, $s1 #$t2 should be non-negetive
            and $t2, $t2, $t0
            bne $t2, $t0, epc_plus4
            add $s1, $zero, $zero
            j sys_entry
epc_plus4:   mfc0  $26, $14 # c0_epc
            addi  $26, $26, 4   
            mtc0  $26, $14 # c0_epc   
            eret
uni_entry:   nop
ovf_entry:   j epc_plus4            
start:      lui $v1, 0xf000 #r3=0xF0000000 (GPIO) r3+4=0xF0000004 (Counter)
            lui $a0, 0xe000 #r4=0xE0000000 (Seg7)
            lui $a1, 0x0002 #r5=ͼ�����ݻ�ַ
            lui $a2, 0xfff7 #r6=0xFFF70000 (Counter count_time)
            lui $t0, 0x8000 #r8=0x80000000
            
            lw $a3, 0($v1) #��GPIO�˿�F0000000״̬:{counter0_out,counter1_out,counter2_out,led_out[12:0], SW} 
            sll $a3, $a3, 0x2 #����
            sw $a3, 0($v1) #r5�����GPIO�˿�0xF0000000�����ü�����ͨ��counter_set=00�˿ڡ�LED=SW�{{GPIOf0[13:0],LED,counter_set}
            sw $a2, 4($v1) #Save r6=0xFFF70000 to counter
            
loop:       lw $a3, 0($v1) #��GPIO�˿�F0000000״̬:{counter0_out,counter1_out,counter2_out,led_out[12:0], SW} 
            sll $a3, $a3, 0x2 #����
            sw $a3, 0($v1) #r5�����GPIO�˿�0xF0000000�����ü�����ͨ��counter_set=00�˿ڡ�LED=SW�{{GPIOf0[13:0],LED,counter_set}
            
disp:       syscall #��⿪��״̬��������ʾ����ͼ��
            lw $t1, 0($s0) #���ڴ�ȡԤ������
            sw $t1, 0($a0) #�߶���ʾԤ������
            j loop
