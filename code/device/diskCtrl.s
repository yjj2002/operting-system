.text
.globl _diskRead
_diskRead:
    #设定磁盘为运行状态
    movw    $0x1f7,%dx
    in      %dx,%al
    or      $2,%al
    out     %al,%dx
    #写读取扇区数
    movw    $0x1f2,%dx
    movb    %cl,%al
    out     %al,%dx
    #向端口写入读取扇区号
    inc     %dx             #0x1f3
    mov     %bl,%al
    out     %al,%dx

    inc     %dx             #0x1f4
    mov     %bh,%al
    out     %al,%dx

    inc     %dx             #0x1f5
    shr     $16,%ebx
    mov     %bl,%al
    out     %al,%dx

    inc     %dx             #0x1f3
    shl     $4,%bh
    mov     $0x70,%al  
    and     %bh,%al
    out     %al,%dx

    inc     %dx             #0x1f7
    mov     $0x20,%al
    out     %al,%dx

    #检查0x1f7端口的bit7是否为0且bit3是否为1，是则说明磁盘读取完成
a1:
    in      %dx,%al
    and     $0x88,%al
    cmp     $0x08,%al
    jnz     a1

    mov     $0x1f0,%dx
    and     $0xff,%ecx
    imul    $256,%ecx
a2:
    in  %dx,%ax
    mov %ax,(%edi)
    loop    a2

    ret
