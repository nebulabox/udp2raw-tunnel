# Getting Started
### Desktop Linux

For 64bit system, use udp2raw_amd64

For 32bit system, use udp2raw_x86

### Android,Raspberry Pi,Linux-based Router with ARM CPU(armv6 and above)

use udp2raw_arm

### Linux-based Router with MIPS CPU (mips24kc and above)

For big-endian system,use udp2raw_mips24kc_be

For little-endian system,use udp2raw_mips24kc_le

### Windows/MacOS

Make sure you have installed a virtual machine software(such as VMware or VirtualBox).

Download and import [lede-17.01.2-x86_virtual_machine_image.zip](https://github.com/wangyu-/udp2raw-tunnel/releases/download/20171108.0/lede-17.01.2-x86_virtual_machine_image.zip) ,Its less than 10MB. 

Run udp2raw_x86_asm_aes inside the virtual machine(make sure network adapter of this virtual machine runs at bridged mode).

NOTE: you can copy udp2raw into the virtual machine by using scp.

##### update

there is a native client-only version of udp2raw on windows and mac now:

https://github.com/wangyu-/udp2raw-multiplatform

### Other Linux-based Device
You have to build by yourself. Check:

https://github.com/wangyu-/udp2raw-tunnel/blob/master/doc/build_guide.md


# Advanced
After you make sure udp2raw works on your device with the binary you choosed in `Getting Started` section,you can try a version with AES acceleration for better performance.

### Desktop Linux

For 64bit system, try udp2raw_amd64_hw_aes

For 32bit system, try udp2raw_x86_asm_aes

### Android,Raspberry Pi,Linux-based Router with ARM CPU (armv6 and above)

try udp2raw_arm_asm_aes

### Linux-based Router with MIPS CPU (mips24kc and above)

For big-endian system,try udp2raw_mips24kc_be_asm_aes

For little-endian system,try udp2raw_mips24kc_le_asm_aes