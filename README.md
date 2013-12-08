# Notepad

Draw a piano on a paper pad, and start playing it!

Notepad uses your webcam to detect the piano you just drew and your fingers,
and starts playing notes when you press keys on your paper piano.

This is my hack for London Music Hack Day 2013. This is still
in progress, but the complete code will make it here entirely,
eventually.

## Screenshots

Early prototype, using a sharpie with some red tape to play the keys.
![Playing piano with a sharpie](https://raw.github.com/VivienBarousse/notepad/master/screenshots/playing_piano.png)

Working version, using two fingers to play at separate ends of the piano.
![Playing the piano with two fingers](https://raw.github.com/VivienBarousse/notepad/master/screenshots/two_fingers_playing.png)

Black and white image, used to increase contract before detecting the black
contours of the piano keyboard.
![Black and white pre-processing](https://raw.github.com/VivienBarousse/notepad/master/screenshots/black_color_detection.png)

Image showing the red-hue detection taking place before running the contour
detection for fingers.
![Red hue image pre-processing](https://raw.github.com/VivienBarousse/notepad/master/screenshots/red_color_detection.png)

## Technical details

This small software is build on top of OpenCV to detect where the keyboard and
your fingers are, and mplayer to play the sound of a working piano.

### Computer vision

The algorithm used to detect the keyboard and the fingers is based on contour
detection to detect regions of similar color.
* Keys are detected as regions of white paper enclosed in black sharpie marker
* Fingers are detected as regions of contiguous bright red color (requires red
  tape on fingernails)

The software is by default configured to dark black sharpie lines to delimit
the keys and bright red regions representing fingers. However, it is possible
to change the configuration to change those colors (for example, red sharpie
for keys and green tape for fingers).

The actual contour detection is done in two steps:
* Filter the image to improve the contrast between areas of the color we're
  looking for, and areas of another color
* Detect contours in the high-contrast image, trying to find large objects

The color screenshots above highlight the contours that have been detected by
the conputer vision algorithm. The black and white algorithms show what the
image looks like after being process to imcrease contrast between similar
regions.

Some heuristics are added on this to help reduce noise and improve the feature
detection:
* A key is only detected if its size is bigger than 20x20 pixels, and its
  height to width ratio is above three.
* The keyboard itself is detected as being the longest series of contiguous,
  aligned, and adjacent keys. A keyboard also has to be at least 10 keys long,
  or won't be detected.
* Fingers are detected as regions of bright red colour, being at least 20x20
  pixels in size.

### Playing piano notes

The piano notes are stored as WAV files in the `sounds/` folder.

Everytime a finger is detected inside an area of the keyboard, mplayer
plays the WAV file in the background, while the rest of the ruby program
continues to run. This allows multiple notes to be played at the same time.

## License

The present source code is distributed under the terms of the MIT License.
Feel free to reuse any or all parts of the software, if you find them useful.

The audio files in `sounds/piano/` come with separate Licensing terms. Please
read the details on how those files are licensed in the
`sounds/piano/LICENSE` file

### The MIT License (MIT)

Copyright (c) 2013 Vivien Barousse <barousse.vivien@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
