The STEP font project
======================

STEP is a Times-like type typeface for publishing. It is based on the [STIX](https://www.stixfonts.org) and [XITS](https://github.com/alif-type/xits) fonts, and includes support for OpenType mathematical typesetting, usable with LuaTeX, XeTeX and Microsoft Office.

The STEP fonts were forked from XITS and include all the same features. The metrics of STEP were changed in order to align with the version of Times most commonly used in publishing. Superior and inferior figures, small caps (for the regular font only) and old-style figures are all included and accessible via OpenType features.

Contributing
------------

A patch may be created by editing the SFD files under the `sources` directory in the [source repository](https://github.com/dbenjaminmiller/step) using [FontForge](https://fontforge.github.io). When submitting patches, please run `make normalize` before committing and avoid any unrelated or unnecessary changes.

To build the fonts from source you need GNU Make, the FontForge Python module, and [FontTools](https://github.com/fonttools/fonttools).
