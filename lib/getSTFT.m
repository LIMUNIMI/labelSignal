function [STFT, F, T] = getSTFT(buffered,overlap,Fs)
%[STFT, F, T] = getSTFT(buffered,overlap,Fs)
%   Compute STFT of buffered signal and corresponding axes
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

    windowSize = size(buffered,1);
    nFrames = size(buffered,2);

    T = getFramesTiming( [windowSize, nFrames], overlap, Fs );
    F = linspace(0,Fs/2,1+windowSize/2)';
    
    STFT = fft(buffered);
    STFT = STFT(1:end/2+1,:);
    STFT = abs(STFT)/windowSize;
    STFT(2:end-1,:) = STFT(2:end-1,:) * 2; 
        
end