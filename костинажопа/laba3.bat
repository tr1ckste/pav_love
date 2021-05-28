set asmfile=lab3_xor

ml /c /coff %asmfile%.asm
link /subsystem:console %asmfile%.obj
%asmfile%.exe