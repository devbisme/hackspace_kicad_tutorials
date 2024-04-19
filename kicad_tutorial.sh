#!/usr/bin/env bash
set -euo pipefail

# Create license page.
pandoc -f markdown -t pdf << EO_LICENSE > license.pdf
These articles from [HackSpace magazine](https://hackspace.raspberrypi.com/) and
[The MagPi Magazine](https://magpi.raspberrypi.com/)
along with this compilation
are licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)](https://creativecommons.org/licenses/by-nc-sa/3.0/us/).

![CC-BY-NC-SA 3.0](CC_BY-SA_3.0.png)
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
BookmarkTitle: Exploring PCB services 
BookmarkLevel: 2
BookmarkPageNumber: 51
BookmarkBegin
BookmarkTitle: KiCad: making a smart stepper motor 
BookmarkLevel: 2
BookmarkPageNumber: 57
BookmarkBegin
BookmarkTitle: KiCad: making an RP2040 game controller
BookmarkLevel: 2
BookmarkPageNumber: 63
BookmarkBegin
BookmarkTitle: MagPi Tutorials
BookmarkLevel: 1
BookmarkPageNumber: 68
BookmarkBegin
BookmarkTitle: Design a circuit with KiCad 
BookmarkLevel: 2
BookmarkPageNumber: 69
BookmarkBegin
BookmarkTitle: Create your own PCB 
BookmarkLevel: 2
BookmarkPageNumber: 74
EOBOOKMARKS

# Compile license and tutorials and then add bookmarks.
pdftk \
	LIC=license.pdf \
	HS=hackspace_title.pdf \
	AA=issues/HS_66_Digital.pdf \
	AB=issues/HS_67_DIGITAL.pdf \
	AC=issues/HS68_DIGITAL.pdf \
	AD=issues/HS_69_DIGITAL.pdf \
	AE=issues/HS70-DIGITAL.pdf \
	AF=issues/HS71_DIGITAL.pdf \
	AG=issues/HS73DIGITAL.pdf \
	AH=issues/HS74DIGITAL.pdf \
	AI=issues/HS75_DIGITAL.pdf \
	AJ=issues/HackSpace76.pdf \
	AK=issues/HS_77.pdf \
	MP=magpi_title.pdf \
	BA=issues/MagPi137.pdf \
	BB=issues/MagPi138_Digital.pdf \
	cat LIC1 HS AA54-59 AB54-59 AC52-57 AD50-55 AE52-57 AF48-53 AG78-83 AH60-65 AI74-79 AJ56-61 AK48-52 MP BA60-64 BB44-50\
	output - | \
	pdftk - update_info bookmarks.txt output kicad_tutorial.pdf

# Get rid of these as they're no longer needed.
rm -rf license.pdf hackspace_title.pdf magpi_title.pdf bookmarks.txt
