TARGET=firefox
VERSION=0.0.1

TDIR=build/${TARGET}
TBDIR=$(TDIR)/build
ZIPPER=$(TBDIR)/showbot-$(TARGET)-$(VERSION).zip
TDIRS=$(TDIR) $(TDIR)/build $(TDIR)/_locales $(TDIR)/_locales/en $(TDIR)/icons \
	$(TDIR)/content $(TDIR)/background_scripts

SOURCES=$(TDIR) $(TBDIR) $(TDIR)/_locales $(TDIR)/_locales/en $(TDIR)/icons  \
		$(TDIR)/_locales/en/messages.json \
		$(TDIR)/icons/showbot-install.png \
		$(TDIR)/icons/sb-128x128.png \
		$(TDIR)/icons/sb-32x32.png \
		$(TDIR)/icons/sb-48x48.png \
		$(TDIR)/icons/sb-96x96.png \
		$(TDIR)/LICENSE.txt  \
		$(TDIR)/README.md  \
		$(TDIR)/build.sh  \
		$(TDIR)/manifest.json  \
		$(TDIR)/background_scripts/watch_tabs.js \
		$(TDIR)/content/showBots.js \
		$(TDIR)/content/jquery-3.2.1.min.js \
		$(TDIR)/content/browser-polyfill.min.js

all: build all-firefox all-chrome

all-firefox:
	$(MAKE) -e TARGET=firefox do-firefox

all-chrome:
	$(MAKE) -e TARGET=chrome do-chrome

do-firefox: $(TDIRS) $(ZIPPER)

do-chrome: $(TDIRS) $(TDIR)/content/browser-polyfill.min.js $(ZIPPER) 

$(ZIPPER): $(SOURCES)
	cd $(TDIR) ; ./build.sh

build:
	mkdir -p $@

$(TDIR) $(TDIR)/build $(TDIR)/_locales $(TDIR)/_locales/en $(TDIR)/icons $(TDIR)/content $(TDIR)/background_scripts:
	mkdir -p $@

$(TDIR)/_locales/en/messages.json: _locales/en/messages.json
	cp $< $@

$(TDIR)/icons/showbot-install.png: icons/showbot-install.png
	cp $< $@

$(TDIR)/icons/sb-128x128.png: icons/sb-128x128.png
	cp $< $@

$(TDIR)/icons/sb-32x32.png: icons/sb-32x32.png
	cp $< $@

$(TDIR)/icons/sb-48x48.png: icons/sb-48x48.png
	cp $< $@

$(TDIR)/icons/sb-96x96.png: icons/sb-96x96.png
	cp $< $@

$(TDIR)/LICENSE.txt : LICENSE.txt
	cp $< $@

$(TDIR)/README.md : README.md
	cp $< $@

$(TDIR)/build.sh : build.sh.erb Makefile
	TARGET=${TARGET} VERSION=${VERSION} erb -T 2 $< > $@
	chmod +x $@

$(TDIR)/manifest.json : manifest.json.erb Makefile
	TARGET=${TARGET} VERSION=${VERSION} erb -T 2 $< > $@

$(TDIR)/content/browser-polyfill.min.js: content/browser-polyfill-0.2.1.min.js
	cp $< $@

$(TDIR)/content/jquery-3.2.1.min.js: content/jquery-3.2.1.min.js
	cp $< $@

$(TDIR)/content/showBots.js: content/showBots.js.erb
	TARGET=${TARGET} VERSION=${VERSION} erb -T 2 $< > $@
	node -c $@

$(TDIR)/background_scripts/watch_tabs.js: background_scripts/watch_tabs.js.erb
	TARGET=${TARGET} VERSION=${VERSION} erb -T 2 $< > $@
	node -c $@


