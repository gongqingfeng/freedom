// See LICENSE for license details.
// Execute in place
// Jump directly to XIP_TARGET_ADDR

  .section .text.init
  .option norvc
  .globl _start
_start:
  csrr a0, mhartid
  la a1, dtb
1:
  li x1, 0xF     //0x7:0111->GPIO0  GPIO1  GPIO2  0xF:1111->GPIO0  GPIO1  GPIO2 GPIO3
  li x2,0x10012008   // make GPIO0  GPIO1  GPIO2 out port
  sw x1,0(x2)

  li x3, 0
  li x5,1 
 
2:

// light LED3
  li x1, 0x08
  li x2,0x1001200C
  sw x1,0(x2)

  li x4,0xa240
3:
  sub x4,x4,x5
  bne x4,x3,3b  //wait few seconds
 
// light LED2
  li x1, 0x04
  li x2,0x1001200C
  sw x1,0(x2)

  li x4,0xa240
4:
  sub x4,x4,x5
  bne x4,x3,4b  //wait few seconds
 
// light LED1
  li x1, 0x02
  li x2,0x1001200C
  sw x1,0(x2)
 
  li x4,0xa240
5:
  sub x4,x4,x5
  bne x4,x3,5b  //wait few seconds

// light LED0
  li x1, 0x01
  li x2,0x1001200C
  sw x1,0(x2)

  li x4,0xa240
6:
  sub x4,x4,x5
  bne x4,x3,6b  //wait few seconds
 
  j 2b
  nop

  .section .rodata
dtb:
  .incbin DEVICE_TREE
