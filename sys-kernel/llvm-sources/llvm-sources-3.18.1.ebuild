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
	${FILESDIR}/3.18.1-inline-asm-aarch64.patch
	${FILESDIR}/3.18.1-add-CONFIG_BROKEN_WITH_CLANG.patch
	${FILESDIR}/3.18.1-CRYPTO_AES_NI_INTEL-depends-on-BROKEN_WITH_CLANG.patch
	${FILESDIR}/3.18.1-XEN-depends-on-BROKEN_WITH_CLANG.patch
	${FILESDIR}/3.18.1-RANDOMIZE_BASE-depends-on-BROKEN_WITH_CLANG.patch
	${FILESDIR}/3.18.1-BUILD_DOCSRC-depends-on-BROKEN_WITH_CLANG.patch"
UNIPATCH_STRICTORDER="yes"

# As of 2014/12/20, the patches at LLVMLINUX_PATCHES_URI excluded below are in the following status:

# -- APPLIED_UPSTREAM
# Move-the-section-attribute-in-front-of-the-variable-.patch
# ftrace.patch
# initconst.patch
# named_register-percpu-aarch64.patch
# named_register-return-address-aarch64.patch
# named_register-stacktrace-aarch64.patch
# named_register-thread_info-aarch64.patch
# named_register-traps-aarch64.patch
# ti-divider.patch
# vlais-btrfs.patch
# vlais-dm-crypt.patch
# vlais-hmac.patch
# vlais-libcrc32.patch
# vlais-testmgr.patch

# -- PORTED (see FILESDIR)
# disable-clang-integrated-as.patch
# inline-asm-aarch64.patch

# The first two patches from the FILESDIR are the ports of the above,
# the other patches introduce CONFIG_BROKEN_WITH_CLANG and make the following
# depend on that option:
# CONFIG_RANDOMIZE_BASE
# CONFIG_AES_NI_INTEL
# CONFIG_BUILD_DOCSRC
# CONFIG_XEN

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

	ewarn "Please be aware that this ebuild is highly experimental."
	ewarn ""
	ewarn "It is based off sys-kernel/gentoo-sources but incorporates"
	ewarn "LLVMLinux patches to make the kernel compile with clang."
	ewarn ""
	ewarn "Further, it ports some non-applying patches from upstream,"
	ewarn "and adds a patchset to introduce CONFIG_BROKEN_WITH_CLANG"
	ewarn "which disables compilation for clang-known-broken features."
	ewarn ""
	ewarn "If you are going to use \"make allyesconfig\" or using"
	ewarn "some custom configuration, be sure to load it at least once"
	ewarn "so that the following options may be disabled:"
	ewarn "- CONFIG_AES_NI_INTEL"
	ewarn "- CONFIG_RANDOMIZE_BASE"
	ewarn "- CONFIG_BUILD_DOCSRC"
	ewarn "- CONFIG_XEN"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
