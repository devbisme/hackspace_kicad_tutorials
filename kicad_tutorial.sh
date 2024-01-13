#!/usr/bin/env bash
set -euo pipefail

# Create license page.
pandoc -f markdown -t pdf << EOLICENSE > license.pdf
These articles from [HackSpace magazine](https://hackspace.raspberrypi.com/)
along with this compilation
are licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)](https://creativecommons.org/licenses/by-nc-sa/3.0/us/).

![CC-BY-NC-SA 3.0](https://pressbooks.bccampus.ca/posetest/wp-content/uploads/sites/1367/2021/04/by-nc-sa.png)
EOLICENSE

# Create bookmark for each tutorial in the compilation.
cat << EOBOOKMARKS > bookmarks.txt
BookmarkBegin
BookmarkTitle: License
BookmarkLevel: 1
BookmarkPageNumber: 1
BookmarkBegin
BookmarkTitle: Getting started with KiCad, schematics
BookmarkLevel: 1
BookmarkPageNumber: 2
BookmarkBegin
BookmarkTitle: Getting started with KiCad, PCB layout
BookmarkLevel: 1
BookmarkPageNumber: 8
BookmarkBegin
BookmarkTitle: KiCad libraries, symbols, and footprints
BookmarkLevel: 1
BookmarkPageNumber: 14
BookmarkBegin
BookmarkTitle: KiCad: using a PCB assembly service
BookmarkLevel: 1
BookmarkPageNumber: 20
BookmarkBegin
BookmarkTitle: Designing an RP2040 board using KiCad
BookmarkLevel: 1
BookmarkPageNumber: 26
BookmarkBegin
BookmarkTitle: KiCad: schematic organisation and hierarchical sheets 
BookmarkLevel: 1
BookmarkPageNumber: 32
BookmarkBegin
BookmarkTitle: KiCad, mechanical accuracy, and silkscreen features 
BookmarkLevel: 1
BookmarkPageNumber: 38
BookmarkBegin
BookmarkTitle: KiCad, different PCB substrates 
BookmarkLevel: 1
BookmarkPageNumber: 44
EOBOOKMARKS

# Compile license and tutorials and then add bookmarks.
pdftk \
	LIC=license.pdf \
	A=issues/HS_66_Digital.pdf \
	B=issues/HS_67_DIGITAL.pdf \
	C=issues/HS68_DIGITAL.pdf \
	D=issues/HS_69_DIGITAL.pdf \
	E=issues/HS70-DIGITAL.pdf \
	F=issues/HS71_DIGITAL.pdf \
	G=issues/HS73DIGITAL.pdf \
	H=issues/HS74DIGITAL.pdf \
	cat LIC1 A54-59 B54-59 C52-57 D50-55 E52-57 F48-53 G78-83 H60-65 \
	output - | \
	pdftk - update_info bookmarks.txt output kicad_tutorial.pdf

# Get rid of these as they're no longer needed.
rm -rf license.pdf bookmarks.txt
