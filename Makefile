AS=asl
P2BIN=p2bin
SRC=src/patch.s
BSPLIT=bsplit
MAME=mame
ROMDIR=/home/moffitt/.mame/roms/

ASFLAGS:=-i . -n -U

.PHONY: prg.bin

all: fantzn2x

prg.o:
	$(AS) $(SRC) $(ASFLAGS) -o prg.o

prg.bin: prg.o
	mkdir -p out
	$(P2BIN) $< $@ -r \$$-0x7FFFF | grep -v -x -F " warning: overlapping memory allocation!"
	split -b 262144 prg.bin
	$(BSPLIT) s xaa out/fz2.a7 out/fz2.a5
	$(BSPLIT) s xab out/fz2.a8 out/fz2.a6
	rm prg.o
	rm prg.bin
	rm xaa
	rm xab

test: fantzn2x
	$(MAME) -debug fantzn2x -r 640x480

fantzn2x: prg.bin
	mkdir -p $(ROMDIR)/fantzn2x/
	cp data/* $(ROMDIR)/fantzn2x/
	cp out/* $(ROMDIR)/fantzn2x/

clean:
	rm -rf out/
