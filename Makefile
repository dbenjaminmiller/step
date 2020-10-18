NAME=STEP
VERSION=2.0.4

SRC=sources
WEB=webfonts
TOOLS=tools
DIST=$(NAME)-$(VERSION)
DIST_CTAN=$(DIST)-CTAN

PY=python3
MAKEFNT=$(TOOLS)/makefnt.py
MAKEWEB=$(TOOLS)/makeweb.py
NORMALIZE=$(TOOLS)/sfdnormalize.py

FONTS=$(NAME)-Regular $(NAME)-Bold $(NAME)-Italic $(NAME)-BoldItalic

SFD=$(FONTS:%=$(SRC)/%.sfd)
OTF=$(FONTS:%=%.otf)
WOF=$(FONTS:%=$(WEB)/%.woff)
NRM=$(FONTS:%=$(SRC)/%.nrm)
CHK=$(FONTS:%=$(SRC)/%.chk)
TTF=$(FONTS:%=%.ttf)

all: otf

otf: $(OTF)
ttf: $(TTF)
web: $(WOF)
normalize: $(NRM)
check: $(CHK)

%.otf: $(SRC)/%.sfd $(SRC)/%.fea
	@echo "Building $@"
	@$(PY) $(MAKEFNT) $< $@ --version=$(VERSION) --features=$(word 2,$+)

%.ttf: $(SRC)/%.sfd $(SRC)/%.fea
	@echo "Building TTF for $@"
	@$(PY) $(MAKEFNT) $< $@ --version=$(VERSION) --features=$(word 2,$+)

%.nrm: %.sfd $(NORMALIZE)
	@echo "Normalizing $(*F)"
	@$(PY) $(NORMALIZE) $< $@
	@if [ "`diff -u $< $@`" ]; then cp $@ $<; touch $@; fi

%.chk: %.sfd $(NORMALIZE)
	@echo "Normalizing $(*F)"
	@$(PY) $(NORMALIZE) $< $@
	@diff -u $< $@ || (rm -rf $@ && false)

$(WEB)/%.woff: %.otf
	@echo "Building $@"
	@mkdir -p $(WEB)
	@$(PY) $(MAKEWEB) $< $(WEB)

dist: $(OTF) $(WOF)
	@echo "Making dist tarball"
	@mkdir -p $(DIST)/$(WEB)
	@cp $(OTF) $(DIST)
	@cp $(WOF) $(DIST)/$(WEB)
	@cp -r OFL.txt FONTLOG.txt $(DIST)
	@cp README.md $(DIST)/README.txt
	@zip -r $(DIST).zip $(DIST)

dist-ctan: $(OTF)
	@echo "Making CTAN dist tarball"
	@mkdir -p $(DIST_CTAN)
	@cp $(OTF) $(DIST_CTAN)
	@cp -r OFL.txt FONTLOG.txt $(DIST_CTAN)
	@cp README.md $(DIST_CTAN)/README.txt
	@zip -r $(DIST_CTAN).zip $(DIST_CTAN)

clean:
	@rm -rf $(OTF) $(TTF) $(DIST) $(DIST).zip $(DIST_CTAN) $(DIST_CTAN).zip $(NRM)\
		$(CHK)
