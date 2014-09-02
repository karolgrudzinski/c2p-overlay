Yeah, this is yet another gentoo overlay.
It includes only ebuilds for software I'm using:
- ebuilds modified by me,
- patches - fixes and/or modifications done by me or someone else,
- new versions, which doesn't have official ebuild

To add this overlay to a Gentoo system, run the following command:

    layman -o https://raw.github.com/karolgrudzinski/c2p-overlay/master/c2p-overlay.xml -f -a c2p-overlay

You must have both dev-vcs/git and app-portage/layman installed on your system 
for this to work.

Please file bug reports for ebuilds in the portage tree in the Gentoo bug 
tracker and bug reports for ebuilds in this overlay on github.
