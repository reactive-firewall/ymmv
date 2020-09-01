#!/usr/bin/env make -f

# reactive-firewall/YMMV Repo Template
# ..................................
# Copyright (c) 2017-2020, Kendrick Walls
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
		INST_DIR_OPTS=-m 755 -d
	endif
endif

ifeq "$(LOG)" ""
	LOG=no
endif

ifeq "$(LOG)" "no"
	QUIET=@
endif

.SUFFIXES: .zip .php .css .html .bash .sh .py .pyc .txt .js

PHONY: must_be_root install-tools-mac cleanup install-home uninstall

build:
	$(QUIET)$(ECHO) "No need to build. Try make -f Makefile install"

init:
	$(QUIET)$(ECHO) "$@: Done."

install: install-etc install-tools install-home
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

install-etc: must_be_root /etc/ /etc/gitconfig /etc/environment
	$(QUITE)$(WAIT)
	$(QUITE)source /etc/environment ;
	$(QUIET)$(ECHO) "$@: Done."

install-pf: must_be_root /etc/ /etc/pf.conf /etc/pf.anchors/local.user
	$(QUITE)/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
	$(QUITE)/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
	$(QUITE)/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
	$(QUITE)/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
	$(QUITE)/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off || true
	$(QUITE)pkill -HUP socketfilterfw || true ;
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Restart Required."

install-tools: must_be_root /usr/local/bin/ /usr/local/bin/grepip /usr/local/bin/grepCIDR /usr/local/bin/grepdns
	$(QUIET)$(ECHO) "$@: Done."

install-tools-mac: must_be_root /usr/local/bin/ /usr/local/bin/auditALFW install-pf
	$(QUIET)$(ECHO) "$@: Done."

install-home: ~/.bashrc ~/.profile ~/.bash_profile ~/.bash_aliases ~/.bash_history
	$(QUIET)$(ECHO) "$@: Configured."

~/.%: ./dot_%
	$(QUITE)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_USER_OWN) $(INST_FILE_OPTS) $< $@ 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/etc/%: ./payload/etc/% must_be_root /etc/
	$(QUITE)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) $< $@ 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/etc/pf.anchors/%: ./payload/etc/pf.anchors/% must_be_root /etc/ /etc/pf.anchors/
	$(QUITE)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) $< $@ 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/usr/local/bin/%: ./payload/bin/% must_be_root /usr/local/bin/
	$(QUITE)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) $< $@
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/etc/pf.anchors/%: ./payload/etc/pf.anchors/% must_be_root /etc/
	$(QUITE)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) $< $@
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/usr/local/bin/: must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /usr/local/bin/

# uninstalls

uninstall-etc:
	$(QUITE)$(QUIET)$(RM) /etc/gitconfig 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

uninstall-home: uninstall-dot-bash_aliases
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."


uninstall-tools: uninstall-tools-grepip uninstall-tools-grepCIDR uninstall-tools-grepdns
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

uninstall-tools-%: /usr/local/bin/% must_be_root /usr/local/bin/
	$(QUITE)$(QUIET)$(RM) $< 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$<: Removed. ( $@ )"

uninstall-dot-%: ~/.% must_be_root
	$(QUITE)$(QUIET)$(RM) $< 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$<: Removed. ( $@ )"

uninstall: uninstall-etc uninstall-tools
	$(QUITE)$(QUIET)$(RM) /etc/gitconfig 2>/dev/null || true
	$(QUITE)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

purge: clean uninstall
	$(QUIET)$(ECHO) "$@: Done."

test: cleanup
	$(QUIET)bash -c ./tests/test_*sh
	$(QUIET)$(ECHO) "$@: Done."

test-tox: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

test-style: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

cleanup:
	$(QUIET)$(RM) tests/*~ 2>/dev/null || true
	$(QUIET)$(RM) *.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./*/*.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./**/*.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./*/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*~ 2>/dev/null || true
	$(QUIET)$(RM) ./.*~ 2>/dev/null || true
	$(QUIET)$(RMDIR) ./.tox/ 2>/dev/null || true

clean: cleanup
	$(QUIET)$(ECHO) "$@: Done."

must_be_root:
	$(QUIET)runner=`whoami` ; \
	if test $$runner != "root" ; then echo "You are not root." ; exit 1 ; fi

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" ; $(WAIT) ;

