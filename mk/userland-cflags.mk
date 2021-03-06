# Userland CFLAG configuration, for libreswan
#
# Copyright (C) 2001, 2002  Henry Spencer.
# Copyright (C) 2003-2006   Xelerance Corporation
# Copyright (C) 2012 Paul Wouters <paul@libreswan.org>
# Copyright (C) 2015 Andrew Cagney <cagney@gnu.org>
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.

# -D... goes in here
USERLAND_CFLAGS=

ifeq ($(origin GCCM),undefined)
ifeq ($(ARCH),i686)
GCCM=-m32
endif
ifeq ($(ARCH),x86_64)
GCCM=-m64
endif
endif
USERLAND_CFLAGS+=$(GCCM)

ifeq ($(origin DEBUG_CFLAGS),undefined)
DEBUG_CFLAGS=-g
endif
USERLAND_CFLAGS+=$(DEBUG_CFLAGS)

ifeq ($(origin OPTIMIZE_CFLAGS),undefined)
# _FORTIFY_SOURCE requires at least -O.  Gentoo, pre-defines
# _FORTIFY_SOURCE (to what? who knows!); force it to our prefered
# value.
OPTIMIZE_CFLAGS=-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
endif
USERLAND_CFLAGS+=$(OPTIMIZE_CFLAGS)

# Dumping ground for an arbitrary set of flags.  Should probably be
# separated out.
ifeq ($(origin USERCOMPILE),undefined)
USERCOMPILE= -fexceptions -fstack-protector-all -fno-strict-aliasing -fPIE -DPIE -DFORCE_PR_ASSERT
endif
USERLAND_CFLAGS+=$(USERCOMPILE)

ifeq ($(USE_DNSSEC),true)
USERLAND_CFLAGS+=-DDNSSEC
endif

ifeq ($(USE_ADNS),true)
USERLAND_CFLAGS+=-DUSE_ADNS
endif

ifeq ($(USE_FIPSCHECK),true)
USERLAND_CFLAGS+=-DFIPS_CHECK
USERLAND_CFLAGS+=-DFIPSPRODUCTCHECK=\"${FIPSPRODUCTCHECK}\"
endif

ifeq ($(USE_KLIPS),true)
USERLAND_CFLAGS+=-DKLIPS
endif

ifeq ($(USE_LABELED_IPSEC),true)
USERLAND_CFLAGS+=-DHAVE_LABELED_IPSEC
endif

ifeq ($(USE_LIBCURL),true)
USERLAND_CFLAGS+=-DLIBCURL
endif

ifeq ($(USE_LINUX_AUDIT),true)
USERLAND_CFLAGS+=-DUSE_LINUX_AUDIT
endif

ifeq ($(USE_LDAP),true)
USERLAND_CFLAGS+=-DLDAP_VER=3
endif

USERLAND_CFLAGS+=-DUSE_MD5

ifeq ($(USE_NM),true)
USERLAND_CFLAGS+=-DHAVE_NM
endif

ifeq ($(USE_SAREF_KERNEL),true)
USERLAND_CFLAGS+=-DSAREF_SUPPORTED
endif

USERLAND_CFLAGS+=-DUSE_SHA2
USERLAND_CFLAGS+=-DUSE_SHA1

ifeq ($(USE_SINGLE_CONF_DIR),true)
USERLAND_CFLAGS+=-DSINGLE_CONF_DIR=1
endif

USERLAND_CFLAGS+=-DFIPSPRODUCTCHECK=\"${FIPSPRODUCTCHECK}\"
USERLAND_CFLAGS+=-DIPSEC_CONF=\"$(FINALCONFFILE)\"
USERLAND_CFLAGS+=-DIPSEC_CONFDDIR=\"$(FINALCONFDDIR)\"
USERLAND_CFLAGS+=-DIPSEC_NSSDIR=\"$(FINALNSSDIR)\"
USERLAND_CFLAGS+=-DIPSEC_CONFDIR=\"$(FINALCONFDIR)\"
USERLAND_CFLAGS+=-DIPSEC_EXECDIR=\"$(FINALLIBEXECDIR)\"
USERLAND_CFLAGS+=-DIPSEC_SBINDIR=\"${FINALSBINDIR}\"
USERLAND_CFLAGS+=-DIPSEC_VARDIR=\"$(FINALVARDIR)\"
USERLAND_CFLAGS+=-DPOLICYGROUPSDIR=\"${FINALCONFDDIR}/policies\"
USERLAND_CFLAGS+=-DSHARED_SECRETS_FILE=\"${FINALCONFDIR}/ipsec.secrets\"

ifeq ($(origin RETRANSMIT_INTERVAL_DEFAULT),undefined)
USERLAND_CFLAGS+=-DRETRANSMIT_INTERVAL_DEFAULT="500"
else
USERLAND_CFLAGS+=-DRETRANSMIT_INTERVAL_DEFAULT="$(RETRANSMIT_INTERVAL_DEFAULT)"
endif

ifeq ($(HAVE_BROKEN_POPEN),true)
USERLAND_CFLAGS+=-DHAVE_BROKEN_POPEN
endif

ifeq ($(HAVE_NO_FORK),true)
USERLAND_CFLAGS+=-DHAVE_NO_FORK
endif

ifeq ($(origin GCC_LINT),undefined)
GCC_LINT=-DGCC_LINT
endif
USERLAND_CFLAGS+=$(GCC_LINT)

# Enable ALLOW_MICROSOFT_BAD_PROPOSAL
USERLAND_CFLAGS+=-DALLOW_MICROSOFT_BAD_PROPOSAL

# eventually: -Wshadow -pedantic
ifeq ($(origin WERROR_CFLAGS),undefined)
WERROR_CFLAGS = -Werror
endif
ifeq ($(origin WARNING_CFLAG),undefined)
WARNING_CFLAGS = -Wall -Wextra -Wformat -Wformat-nonliteral -Wformat-security -Wundef -Wmissing-declarations -Wredundant-decls -Wnested-externs
endif
USERLAND_CFLAGS+= $(WERROR_CFLAGS)
USERLAND_CFLAGS+= $(WARNING_CFLAGS)
