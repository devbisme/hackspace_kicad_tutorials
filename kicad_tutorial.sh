#!/usr/bin/env bash
set -euo pipefail

# Create license page.
pandoc -f markdown -t pdf << EO_LICENSE > license.pdf
These articles from [HackSpace magazine](https://hackspace.raspberrypi.com/) and
[The MagPi Magazine](https://magpi.raspberrypi.com/)
along with this compilation
are licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)](https://creativecommons.org/licenses/by-nc-sa/3.0/us/).

![CC-BY-NC-SA 3.0](https://pressbooks.bccampus.ca/posetest/wp-content/uploads/sites/1367/2021/04/by-nc-sa.png)
EO_LICENSE

pandoc -f markdown -t pdf << EO_HACKSPACE_TITLE > hackspace_title.pdf
# Tutorials from [HackSpace magazine](https://hackspace.raspberrypi.com/)
EO_HACKSPACE_TITLE

pandoc -f markdown -t pdf << EO_MAGPI_TITLE > magpi_title.pdf
# Tutorials from [The MagPi Magazine](https://magpi.raspberrypi.com/)
EO_MAGPI_TITLE

# Create bookmark for each tutorial in the compilation.
cat << EOBOOKMARKS > bookmarks.txt
BookmarkBegin
BookmarkTitle: License
BookmarkLevel: 1
BookmarkPageNumber: 1
BookmarkBegin
BookmarkTitle: HackSpace Tutorials
BookmarkLevel: 1
BookmarkPageNumber: 2
BookmarkBegin
BookmarkTitle: Getting started with KiCad, schematics
BookmarkLevel: 2
BookmarkPageNumber: 3
BookmarkBegin
BookmarkTitle: Getting started with KiCad, PCB layout
BookmarkLevel: 2
BookmarkPageNumber: 9
BookmarkBegin
BookmarkTitle: KiCad libraries, symbols, and footprints
BookmarkLevel: 2
BookmarkPageNumber: 15
BookmarkBegin
BookmarkTitle: KiCad: using a PCB assembly service
BookmarkLevel: 2
BookmarkPageNumber: 21
BookmarkBegin
BookmarkTitle: Designing an RP2040 board using KiCad
BookmarkLevel: 2
BookmarkPageNumber: 27
BookmarkBegin
BookmarkTitle: KiCad: schematic organisation and hierarchical sheets 
BookmarkLevel: 2
BookmarkPageNumber: 33
BookmarkBegin
BookmarkTitle: KiCad, mechanical accuracy, and silkscreen features 
BookmarkLevel: 2
BookmarkPageNumber: 39
BookmarkBegin
BookmarkTitle: KiCad, different PCB substrates 
BookmarkLevel: 2
BookmarkPageNumber: 45
BookmarkBegin
BookmarkTitle: MagPi Tutorials
BookmarkLevel: 1
BookmarkPageNumber: 51
BookmarkBegin
BookmarkTitle: Design a circuit with KiCad 
BookmarkLevel: 2
BookmarkPageNumber: 52
EOBOOKMARKS

# Compile license and tutorials and then add bookmarks.
pdftk \
	LIC=license.pdf \
	HS=hackspace_title.pdf \
	A=issues/HS_66_Digital.pdf \
	B=issues/HS_67_DIGITAL.pdf \
	C=issues/HS68_DIGITAL.pdf \
	D=issues/HS_69_DIGITAL.pdf \
	E=issues/HS70-DIGITAL.pdf \
	F=issues/HS71_DIGITAL.pdf \
	G=issues/HS73DIGITAL.pdf \
	H=issues/HS74DIGITAL.pdf \
	MP=magpi_title.pdf \
	I=issues/MagPi137.pdf \
	cat LIC1 HS A54-59 B54-59 C52-57 D50-55 E52-57 F48-53 G78-83 H60-65 MP I60-64\
	output - | \
	pdftk - update_info bookmarks.txt output kicad_tutorial.pdf

# Get rid of these as they're no longer needed.
rm -rf license.pdf hackspace_title.pdf magpi_title.pdf bookmarks.txt
