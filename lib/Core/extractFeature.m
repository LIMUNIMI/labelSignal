function [ cc, AR ] = extractFeature( ar, ccToKeep, nBins, Fs )
%[ cc, AR ] = extractFeature( ar, ccToKeep, nBins, Fs )
%
% INPUT
%          ar: Autoregressive coefficients for each frame
%    ccToKeep: # of cepstral coefficients to keep
%        nBin: Resolution of ar Fourier transform
%          Fs: Sampling frequency
% 
% OUTPUT
%          cc: Cepstral coefficients of each frame
%          AR: Autoregressive frequency response for each frame
%
% ------------------------------------------------------------------------
%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION
% FOR MONOPHONIC MUSICAL INSTRUMENTS
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti
% {goffredo.haus,luca.ludovico,giorgio.presti}@unimi.it
%
% extractFeature.m: cepstral coeff. and frequency response of ar models
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

    nFrames = size(ar,2);

    cc = lpcar2cc(ar.');
    cc = cc(:,2:min(ccToKeep+1,size(cc,2)));
    AR = zeros(nBins,nFrames);
    for n=1:nFrames
        AR(:,n)=abs(freqz(1,ar(:,n),nBins,Fs));
    end;
    
end

