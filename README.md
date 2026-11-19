Rudimentary Demo HSM on FPGA

# Overview
- Artix-7
- AES-128
- At least 5 submodules, an accumulator, and an FSM
- Possible control:
	- Generate key on init
	- Read plain or ciphertext (how?)
	- encrypt/decrypt via button enable
	- Output text (how?)
- Hopefully IRL use, maybe via computer interface?


# Main FSM Control
States: Idle, Keygen, Load?, Encrypt, Decrypt, Out?


#I/O
UART via USB?


# AES


# UART


# Keygen
Just use a predefined seed for now.


# Modules
KeyExpansion
AddRoundKey
SubBytes
ShiftRows
MixColumns

Which ones can be combinational?
Matrix ops in Verilog? Uh-oh...


aes128_accelerator
- aes_top.v
- aes_controller.v
- aes_round.v
- aes_subbytes.v
- aes_shiftrows.v
- aes_mixcolumns.v
- aes_addroundkey.v
- aes_key_expansion.v
- aes_sbox.v


