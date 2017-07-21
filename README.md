#### About repository

Yeah, this is yet another gentoo overlay.
It includes only ebuilds for software I'm using:
* ebuilds modified by me,
* patches - fixes and/or modifications done by me or someone else,
* new versions, which doesn't have official ebuild

#### Packages in repository

* app-office/libreoffice-bin - Official RPMs from LO's server
* app-office/libreoffice-l10n - Language pack with matching version
* app-officeext/languagetool - Style and Grammar Checker for LibreOffice
* media-fonts/croscorefonts - Arimo, Cousine, Timos fonts metrically compatible with MS corefonts
* media-fonts/crosextrafonts - Caladea font
* media-fonts/crosextrafonts-carlito - Carlito font
* media-fonts/source-pro - Adobe's open source typeface family (Serif, Sans and Code variants)
* media-gfx/XnViewMP - powerful media browser, viewer and converter
* media-gfx/yEd - Graph editor
* net-misc/r8101 - Driver for Realtek 810x/840x based PCI-E/PCI Ethernet Cards (PCI_ID 10ec:8136)
* net-print/brother-dcp-j315w-drivers - DCP-J315W LPR+cupswrapper drivers
* sys-power/pm-utils - official ebuild + patch for TuxOnIce power method
* www-client/firefox - ebuilds for beta versions, mostly the same as in Mozilla Overlay, but with linguas support
* x11-drivers/nvidia-drivers - nVidia Legacy Drivers with patches for newer kernels
* x11-themes/natural-gentoo - nice Fbcondecor theme

#### Adding the Overlay

To add this overlay to a Gentoo system, run the following command:

    layman -a c2p-overlay

You must have both dev-vcs/git and app-portage/layman installed on your system 
for this to work.

#### Bug reporting

Please file bug reports for ebuilds in the portage tree in the Gentoo bug 
tracker and bug reports for ebuilds in this overlay on github.
