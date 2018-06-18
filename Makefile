#!/usr/bin/env make -f

# reactive-firewall/YMMV Repo Template
# ..................................
# Copyright (c) 2017-2018, Kendrick Walls
# ..................................
# Licensed under MIT (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# ..........................................
# https://www.github.com/reactive-firewall/ymmv/LICENSE.md
# ..........................................
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


ifeq "$(ECHO)" ""
	ECHO=echo
endif

ifeq "$(LINK)" ""
	LINK=ln -sf
endif

ifeq "$(MAKE)" ""
	MAKE=make
endif

ifeq "$(WAIT)" ""
	WAIT=wait
endif

ifeq "$(RM)" ""
	RM=rm -f
endif

ifeq "$(RMDIR)" ""
	RMDIR=$(RM)R
endif

ifeq "$(INSTALL)" ""
	INSTALL=`which install`
	ifeq "$(INST_OWN)" ""
		INST_OWN=-C -o root -g staff
	endif
	ifeq "$(INST_USER_OWN)" ""
		INST_USER_OWN=-C -o ${USER:-${LOGNAME}} -g staff
	endif
	ifeq "$(INST_OPTS)" ""
		INST_OPTS=-m 751
	endif
	ifeq "$(INST_FILE_OPTS)" ""
		INST_FILE_OPS=-m 640
	endif
	ifeq "$(INST_DIR_OPTS)" ""
		INST_DIR_OPTS=-m 751 -d
	endif
endif

ifeq "$(LOG)" ""
	LOG=no
endif

ifeq "$(LOG)" "no"
	QUIET=@
endif

.SUFFIXES: .zip .php .css .html .bash .sh .py .pyc .txt .js

PHONY: must_be_root cleanup

build:
	$(QUIET)$(ECHO) "No need to build. Try make -f Makefile install"

init:
	$(QUIET)$(ECHO) "$@: Done."

install: must_be_root ./dot_gitconfig ~/.bashrc ~/.bash_aliases /etc/
	$(QUIET)$(INSTALL) ./dot_gitconfig /etc/gitconfig
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

~/.%: ./dot_%
	$(QUITE)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_USER_OWN) $(INST_FILE_OPTS) $< $@ 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/usr/local/bin/%: ./tools/% must_be_root /usr/local/bin/
	$(QUITE)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) $< $@
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/usr/local/bin/: must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /usr/local/bin/

# uninstalls

uninstall-tools:
	$(QUITE)$(QUIET)rm -vf /etc/gitconfig 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

uninstall:
	$(QUITE)$(QUIET)rm -vf /etc/gitconfig 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

purge: clean uninstall
	$(QUIET)$(ECHO) "$@: Done."

test: cleanup
	$(QUIET)bash ./tests/test_*sh
	$(QUIET)$(ECHO) "$@: Done."

test-tox: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

test-style: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

cleanup:
	$(QUIET)rm -f tests/*~ 2>/dev/null || true
	$(QUIET)rm -f *.DS_Store 2>/dev/null || true
	$(QUIET)rm -f ./*/*~ 2>/dev/null || true
	$(QUIET)rm -f ./*~ 2>/dev/null || true
	$(QUIET)rm -f ./.*~ 2>/dev/null || true
	$(QUIET)rm -Rf ./.tox/ 2>/dev/null || true

clean: cleanup
	$(QUIET)$(ECHO) "$@: Done."

must_be_root:
	$(QUIET)runner=`whoami` ; \
	if test $$runner != "root" ; then echo "You are not root." ; exit 1 ; fi

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" ; $(WAIT) ;

