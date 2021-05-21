set asmfile=lab3

ml /c /coff %asmfile%.asm
link /subsystem:windows %asmfile%.obj
%asmfile%.exe