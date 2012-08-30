# Installation

From the `subtitle-shifter` directory:

    cabal install

# Usage

To delay the display of all subtitles five seconds:

    subtitle-shifter 5 my-video.srt > my-video.2.srt

To display subtitles one second earlier:

    subtitle-shifter -1 my-video.srt > my-video.2.srt
