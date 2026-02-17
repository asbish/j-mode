EMACS = emacs
PREFIX = /usr/local
BATCH = $(EMACS) --batch -Q -L . \
	--eval "(when (boundp 'load-prefer-newer) (setq load-prefer-newer t))"

EL_FILES := $(wildcard *.el)

build: $(patsubst %.el,%.elc,$(EL_FILES))

%.elc: %.el
	$(BATCH) --eval '(setq byte-compile-error-on-warn t)' \
	         -f batch-byte-compile $<

.PHONY: install
install: build
	mkdir -p $(PREFIX)/share/emacs/site-lisp/j-mode
	cp $(CURDIR)/*.el $(PREFIX)/share/emacs/site-lisp/j-mode/
	cp $(CURDIR)/*.elc $(PREFIX)/share/emacs/site-lisp/j-mode/

.PHONY: clean
clean:
	$(RM) $(CURDIR)/*.elc
