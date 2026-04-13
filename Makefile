TARGET=none
CONFIG=./nes.cfg

SRCDIR=src
OBJDIR=obj

OUTFILE=./main.nes
DBGFILE=./main.dbg
MAPFILE=./main.map
LABELFILE=./main.lbl

ASMSOURCES=$(wildcard $(SRCDIR)/*.s)
OBJECTS=$(ASMSOURCES:$(SRCDIR)/%.s=$(OBJDIR)/%.o)

EMULATOR_PATH = fceux

.PHONY: build clean run env-emulator-path

build: $(OUTFILE)

$(OUTFILE): $(OBJECTS)
	ld65 -Ln $(LABELFILE) -m $(MAPFILE) -vm --dbgfile $(DBGFILE) \
	-o $(OUTFILE) -C $(CONFIG) $(OBJECTS) $(TARGET).lib

$(OBJDIR)/%.o: $(SRCDIR)/%.s | $(OBJDIR)
	ca65 -g -t $(TARGET) $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

run: env-emulator-path build
	$(EMULATOR_PATH) $(OUTFILE)

env-emulator-path:
ifndef EMULATOR_PATH
	$(error EMULATOR_PATH is not set)
endif

clean:
	rm -rf $(OBJDIR) $(OUTFILE) $(DBGFILE) $(MAPFILE) $(LABELFILE)
