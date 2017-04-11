function [ T ] = getFramesTiming( bufferSizes, overlap, Fs )
%[ T ] = getFramesTiming( bufferSizes, overlap, Fs )
% Returns timing coordinates for a buffered signal
%
% Copyright (C) 2017 - Laboratorio di Informatica Musicale
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>
%

    windowSize = bufferSizes(1);
    nFrames = bufferSizes(2);
    frameHop = windowSize-overlap;
    lastFrameIndex = (nFrames * frameHop) - overlap - 1;
    T = ((-overlap : frameHop : lastFrameIndex) + overlap) / Fs;

end

