#!/usr/bin/env make -f

# reactive-firewall/YMMV Repo Template
# ..................................
# Copyright (c) 2017-2023, Kendrick Walls
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


# THANKS to the user https://stackoverflow.com/users/999943/phyatt
# For the solid answer to https://stackoverflow.com/a/35320895

ifneq ($(words $(MAKECMDGOALS)),1) # if no argument was given to make...
.DEFAULT_GOAL = all # set the default goal to all

ifeq "$(ECHO)" ""
	ECHO=command -p echo
endif

%:		# define a last resort default rule
	@$(MAKE) $@ --no-print-directory -rRf $(firstword $(MAKEFILE_LIST)) # recursive make call,

else

ifeq "$(SHELL)" ""
	SHELL=command -pv bash
endif

ifeq "$(MAKE)" ""
	MAKE=command -pv make
endif

ifndef ECHO
T := $(shell $(MAKE) $(MAKECMDGOALS) --no-print-directory \
      -nrRf $(firstword $(MAKEFILE_LIST)) \
      ECHO="COUNTTHIS" | grep -c "COUNTTHIS" 2>/dev/null)
N := x
C = $(words $N)$(eval N := x $N)
ECHO = echo -ne "\r [`expr $C '*' 100 / $T`%]"
endif


ifeq "$(ALFW)" ""
	ALFW=/usr/libexec/ApplicationFirewall/socketfilterfw
endif

ifeq "$(LINK)" ""
	LINK=command -pv ln -sf
endif

ifeq "$(WAIT)" ""
	WAIT=wait
endif

ifeq "$(RM)" ""
	RM=command -pv rm -f
endif

ifeq "$(CHMOD)" ""
	CHMOD=xcrun chmod -v
endif

ifeq "$(CHOWN)" ""
	CHOWN=xcrun chown -v
endif

ifeq "$(CP)" ""
	CP=command -pv cp -n
endif

ifeq "$(MKDIR)" ""
	MKDIR=xcrun mkdir -m 0755
endif

ifeq "$(RMDIR)" ""
	RMDIR=$(RM)dR
endif

ifeq "$(INSTALL)" ""
	INSTALL=xcrun install -M
	ifeq "$(INST_OWN)" ""
		USER=`id -u`
	endif
	ifeq "$(INST_OWN)" ""
		INST_OWN=-g `id -g` -o 0
	endif
	ifeq "$(INST_USER_OWN)" ""
		INST_USER_OWN=-g `id -g` -o $(USER)
	endif
	ifeq "$(INST_TOOL_OWN)" ""
		INST_USER_OWN=-o 0 -g 80
	endif
	ifeq "$(INST_OPTS)" ""
		INST_OPTS=-m 0751
	endif
	ifeq "$(INST_TOOL_OPTS)" ""
		INST_TOOL_OPTS=-m 0755
	endif
	ifeq "$(INST_FILE_OPTS)" ""
		INST_FILE_OPTS=-m 0640
	endif
	ifeq "$(INST_CONFIG_OPTS)" ""
		INST_CONFIG_OPTS=-m 0644
	endif
	ifeq "$(INST_DIR_OPTS)" ""
		INST_DIR_OPTS=-d
	endif
endif

ifeq "$(LOG)" ""
	LOG=no
endif

ifeq "$(LOG)" "no"
	QUIET=@
endif

.SUFFIXES: .zip .php .css .html .bash .sh .py .pyc .txt .js .plist .dmg rc

PHONY: must_be_root install-tools-mac install-pf cleanup install-tools install-etc install-home uninstall build all

all: install test
	$(QUIET)$(WAIT)

build:
	$(QUIET)$(ECHO) "No need to build. Try make -f Makefile install"

init:
	$(QUIET)$(ECHO) "$@: Done."

install: install-etc install-tools install-home
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

install-etc: must_be_root /etc/ /etc/gitconfig /etc/environment /etc/bashrc
	$(QUIET)$(WAIT)
	$(QUIET)source /etc/environment ;
	$(QUIET)$(ECHO) "$@: Done."

install-pf: must_be_root /etc/ /etc/pf.conf /etc/pf.extras /etc/pf.anchors/local.user
	$(QUIET)$(ALFW) --setglobalstate on || exit 126 ;
	$(QUIET)$(ALFW) --setloggingmode on || true
	$(QUIET)$(ALFW) --setstealthmode on || true
	$(QUIET)$(ALFW) --setallowsigned on || true
	$(QUIET)$(ALFW) --setallowsignedapp off || exit 126 ;
	$(QUIET)pkill -HUP socketfilterfw || true ;
	$(QUIET)pfctl -mef /etc/pf.conf || true ;
	$(QUIET)pfctl -mF states || true ;
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Restart Required."

install-tools: must_be_root /usr/local/bin/ /usr/local/bin/grepip /usr/local/bin/grepCIDR /usr/local/bin/grepdns /usr/local/bin/Tar_it
	$(QUIET)$(ECHO) "$@: Done."

install-tools-mac: must_be_root /usr/local/bin/ /usr/local/bin/sud /usr/local/bin/auditALFW /usr/local/bin/auditGK install-pf
	$(QUIET)$(ECHO) "$@: Done."

install-home: ~/.bashrc ~/.profile ~/.bash_profile ~/.bash_aliases ~/.bash_history ~/.tcshrc ~/.cshrc
	$(QUIET)$(ECHO) "$@: Configured."

install-better-home: install-home ~/.nofinger ~/.plan nano-config git-config
	$(QUIET)$(ECHO) "$@: Configured."

nano-config: ~/.config/nano/nanorc ~/.config/nano/nano_syntax
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "User nano env: Configured."

git-config: ~/.config/git/attributes
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "User Git: Configured."

~/.config/: ./payload/config/
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)

~/.config/git/%: ./payload/config/git/% ~/.config/git/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.config/nano/%: ./payload/config/nano/% ~/.config/nano/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.config/lxterminal/%: ./payload/config/lxterminal/% ~/.config/lxterminal/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.config/lxsession/LXDE-pi/%: ./payload/config/lxsession/% ~/.config/lxsession/LXDE-pi/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.config/pcmanfm/LXDE-pi/%: ./payload/config/pcmanfm/% ~/.config/pcmanfm/LXDE-pi/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.config/lxpanel/%: ./payload/config/lxpanel/% ~/.config/lxpanel
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.config/lxpanel/LXDE-pi/%: ./payload/config/lxpanel/LXDE-pi/% ~/.config/lxpanel/LXDE-pi
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.config/lxpanel/LXDE-pi/panels/%: ./payload/config/lxpanel/LXDE-pi/panels/% ~/.config/lxpanel/LXDE-pi/panels
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_CONFIG_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed"

~/.config/git: ./payload/config/git/ ~/.config/
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.config/nano: ./payload/config/nano/ ~/.config/
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.config/completions: ./payload/config/completions/ ~/.config/
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.config/lxpanel/LXDE-pi/panels: ./payload/config/lxpanel/LXDE-pi/panels ~/.config/lxpanel/LXDE-pi
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.config/lxpanel/LXDE-pi: ./payload/config/lxpanel/LXDE-pi/ ~/.config/lxpanel
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.config/lxpanel: ./payload/config/lxpanel ~/.config/lxpanel
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.config/lxterminal: ./payload/config/lxterminal ~/.config/lxpanel
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.config/lxsession/LXDE-pi: ./payload/config/lxsession/ ~/.config/
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) ~/.config/lxsession/ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) ~/.config/lxsession 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) ~/.config/lxsession 2>/dev/null || true
	$(QUIET)$(MKDIR) ~/.config/lxsession/LXDE-pi 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) ~/.config/lxsession/LXDE-pi 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) ~/.config/lxsession/LXDE-pi 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.config/pcmanfm/LXDE-pi: ./payload/config/pcmanfm/ ~/.config/
	$(QUIET)$(WAIT)
	$(QUIET)$(MKDIR) ~/.config/pcmanfm/ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) ~/.config/pcmanfm 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) ~/.config/pcmanfm 2>/dev/null || true
	$(QUIET)$(MKDIR) ~/.config/pcmanfm/LXDE-pi 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) ~/.config/pcmanfm/LXDE-pi 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) ~/.config/pcmanfm/LXDE-pi 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Created."

~/.%rc: ./dot_%rc
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_TOOL_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

~/.bash_aliases: ./dot_bash_aliases
	$(QUIET)$(WAIT)
	$(QUIET)$(CP) $@ $@.previous 2>/dev/null || true
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_FILE_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

~/.%: ./dot_%
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $< $@ 2>/dev/null || true
	$(QUIET)$(CHOWN) $(INST_USER_OWN) $@ 2>/dev/null || true
	$(QUIET)$(CHMOD) $(INST_FILE_OPTS) $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/etc/%.previous: must_be_root /etc/ /etc/%
	$(QUIET)$(CP) $@ $@.previous 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: backed up."

/etc/bashrc: ./payload/etc/bashrc must_be_root /etc/ /etc/bashrc.previous
	$(QUIET)$(WAIT)
	$(QUIET)$(MAKE) -C ./ -f ./Makefile $@.previous 2>/dev/null || true
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_TOOL_OPTS) $< $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: configured."

/etc/environment: ./payload/etc/environment must_be_root /etc/ /etc/environment.previous
	$(QUIET)$(WAIT)
	$(QUIET)$(MAKE) -C ./ -f ./Makefile $@.previous 2>/dev/null || true
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_TOOL_OPTS) $< $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: configured."

/etc/%: ./payload/etc/% must_be_root /etc/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_CONFIG_OPTS) $< $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/etc/pf.anchors/%: ./payload/etc/pf.anchors/% must_be_root /etc/ /etc/pf.anchors/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_TOOL_OWN) $(INST_FILE_OPTS) $< $@ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/usr/local/bin/%: ./payload/bin/% must_be_root /usr/local/bin/
	$(QUIET)$(WAIT)
	$(QUIET)$(INSTALL) $(INST_TOOL_OWN) $(INST_TOOL_OPTS) $< $@
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: installed."

/usr/local/bin/: must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /usr/local/bin/

# uninstalls

uninstall-etc: /etc/bashrc.previous
	$(QUIET)$(RM) /etc/gitconfig 2>/dev/null || true
	$(QUIET)$(RM) /etc/environment 2>/dev/null && $(QUIET)$(CP) /etc/environment.previous /etc/environment 2>/dev/null || true
	$(QUIET)$(RM) /etc/bashrc 2>/dev/null && $(QUIET)$(CP) /etc/bashrc.previous /etc/bashrc 2>/dev/null || true
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: Done."

uninstall-home: uninstall-dot-bash_aliases uninstall-dot-bash_profile uninstall-dot-bash_history uninstall-dot-macrc uninstall-dot-cshrc uninstall-dot-tcshrc uninstall-dot-plan
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

uninstall-better-home: uninstall-dot-nofinger uninstall-dot-plan uninstall-dot-config uninstall-home
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

uninstall-tools: uninstall-tools-grepip uninstall-tools-grepCIDR uninstall-tools-grepdns uninstall-tools-Tar_it uninstall-tools-sud
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

uninstall-tools-%: /usr/local/bin/% must_be_root /usr/local/bin/
	$(QUIET)$(QUIET)$(RM) $< 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$<: Removed. ( $@ )"

uninstall-dot-config-%: ~/.config/%
	$(QUIET)$(RMDIR) $< 2>/dev/null || true
	$(QUIET)$(RM) $< 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$<: Removed. ( $@ )"

uninstall-dot-config: ~/.config/ uninstall-dot-config-nano uninstall-dot-config-completions uninstall-dot-config-nano uninstall-config-git
	$(QUIET)$(RMDIR) $< 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$<: Removed. ( $@ )"

uninstall-dot-%: ~/.%
	$(QUIET)$(RM) $< 2>/dev/null || true
	$(QUIET)$(RM) $<~ 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$<: Removed. ( $@ )"

uninstall: uninstall-etc uninstall-tools
	$(QUIET)$(RM) /etc/gitconfig 2>/dev/null || true
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

purge: clean uninstall-better-home uninstall
	$(QUIET)$(ECHO) "$@: Done."

test: cleanup
	$(QUIET)$(ECHO) "$@: START."
	$(QUIET)ls -1 ./tests/test_*sh 2>/dev/null | xargs -L1 -I{} $(SHELL) -c "{} && echo '{}: OK' || echo '{}: FAILED' >&2 ; " ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "$@: END."

test-tox: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

test-style: cleanup
	$(QUIET)$(ECHO) "$@: N/A."

cleanup:
	$(QUIET)$(RM) tests/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./.git/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./*/*/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./**/*.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) ./payload/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./payload/**/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./payload/bin/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./payload/config/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./payload/etc/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./**/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*/*/*/*~ 2>/dev/null || true
	$(QUIET)$(RM) ./*~ 2>/dev/null || true
	$(QUIET)$(RM) ./.*~ 2>/dev/null || true
	$(QUIET)$(RM) ./**/.*~ 2>/dev/null || true
	$(QUIET)$(RMDIR) ./.tox/ 2>/dev/null || true

clean: cleanup
	$(QUIET)$(ECHO) "$@: Done."

must_be_root:
	$(QUIET)runner=`whoami` ; \
	if test $$runner != "root" ; then echo "You are not root." ; exit 126 ; fi

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" ;
	$(QUIET)$(WAIT) ;

endif
