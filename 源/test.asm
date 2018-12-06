;加载程序
;加载用户程序放在1扇区，即dbr后面
format PE
section 'code_1' code readable


start:
dd 12345678H
dd 0xFFFFFF