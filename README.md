gentoo-clang-kernel-overlay
===========================

Provides an ebuild to compile a kernel with Clang the Gentoo way

This is where Gentoo Clang kernel development is done.

To add this overlay to a Gentoo system, run the following command:

layman -o https://raw.github.com/fsvm88/gentoo-clang-kernel-overlay/master/overlay.xml -f -a zfs

Note that you must have both dev-vcs/git and app-portage/layman installed on
your system for this to work.

**NOTE: this is highly experimental, please avoid using it unless you know what you're doing.**
