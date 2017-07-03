# labelSignal

`labelSignal`: Automatic annotation of timbre variation for monophonic musical instruments and other sound sources.

## Examples

You can find some output examples [here](http://lim.di.unimi.it/demo/labelSignal.php).

## Requirements

It has been tested on Matlab R2015a + DSP Toolbox, but it should work even with older versions of Matlab. If it doesn't, please let us know.

## Repo content

`lib` contains routines used by the main function.

`labelSignal.m` is the main function. This does all the work.

`example.m` script is a good starting point to learn how to use `labelSignal.m`.

`inDepthExample.m` script is a good starting point to learn how `labelSignal.m` works.

`Khomus.wav` is some audio used by the sample scripts.

`README.md` is this file.

## How to reference this work

This work has been accepted at the 13th International Symposium on Computer Music Multidisciplinary Research (CMMR 2017)

## License

AUTOMATIC ANNOTATION OF TIMBRE VARIATION FOR MONOPHONIC MUSICAL INSTRUMENTS
Goffredo Haus, Luca A. Ludovico, and Giorgio Presti
{haus,ludovico,presti}@unimi.it

labelSignal.m: describes a signal through a time serie of labels
Copyright (C) 2017 - Laboratorio di Informatica Musicale

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>
