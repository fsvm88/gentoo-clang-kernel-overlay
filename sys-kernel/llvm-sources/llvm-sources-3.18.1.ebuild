# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-3.18.1.ebuild,v 1.1 2014/12/16 20:04:03 mpagano Exp $

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="3"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

LLVMLINUX_PATCHES_NAME="kernel-patches.tar.bz2"
LLVMLINUX_PATCHES_URI="http://buildbot.llvm.linuxfoundation.org/configs/for-linus/${LLVMLINUX_PATCHES_NAME}"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"
IUSE="deblob experimental"

DESCRIPTION="Full sources including the Gentoo and Clang patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${LLVMLINUX_PATCHES_URI}"

UNIPATCH_LIST="
	${DISTDIR}/${LLVMLINUX_PATCHES_NAME}
	${FILESDIR}/3.18.1-disable-clang-integrated-as.patch
	${FILESDIR}/3.18.1-inline-asm-aarch64.patch"
UNIPATCH_STRICTORDER="yes"

# As of 2014/12/20, the patches at LLVMLINUX_PATCHES_URI excluded below are in the following status:

# -- APPLIED_UPSTREAM
# Move-the-section-attribute-in-front-of-the-variable-.patch
# ftrace.patch
# initconst.patch

# -- PORTED (see FILESDIR)
# disable-clang-integrated-as.patch
# inline-asm-aarch64.patch


UNIPATCH_EXCLUDE="
	Move-the-section-attribute-in-front-of-the-variable-.patch
	disable-clang-integrated-as.patch
	ftrace.patch
	initconst.patch
	inline-asm-aarch64.patch
	named_register-percpu-aarch64.patch
	named_register-return-address-aarch64.patch
	named_register-stacktrace-aarch64.patch
	named_register-thread_info-aarch64.patch
	named_register-traps-aarch64.patch
	ti-divider.patch
	vlais-btrfs.patch
	vlais-dm-crypt.patch
	vlais-hmac.patch
	vlais-libcrc32c.patch
	vlais-testmgr.patch
	${UNIPATCH_EXCLUDE}"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
