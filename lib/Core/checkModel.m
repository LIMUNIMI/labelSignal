function [ ] = checkModel( buffered, ar, Fs, refF0 )
%[ ] = checkModel( buffered, ar )
%
% INPUT
%    buffered: Input signal split into frames
%          ar: Autoregressive coefficients for each frame
%          Fs: Sample frequency
%       refF0: Reference F0 (Hz)
%
% OUTPUT: Plots Residuals autocorrelation and Z poles over sonogram
%
% ------------------------------------------------------------------------
%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION
% FOR MONOPHONIC MUSICAL INSTRUMENTS
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti
% {goffredo.haus,luca.ludovico,giorgio.presti}@unimi.it
%
% checkModel.m: Plots to visually check if data is modeled correctly
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

    wSize      = size(buffered,1);
    nFrames    = size(buffered,2);
    overlap    = 1/2 * wSize;
    
    order      = size(ar,1) - 1;

    % Calc residuals
    err = zeros(size(buffered));
    for c = 1:nFrames-1
        err(:,c) = filter(ar(:,c),1,buffered(:,c));
    end;
    
    % Residual autocorrelation
    figure, plotAC(err,250,1);
    title(sprintf('Residual autocorrelation for p = %i',order))
    
    % Visual ispection no poles are wasted by tracking f0 = 57.96 Hz
    ar(isnan(ar)) = 0;
    [ STFT, F,  T    ] = getSTFT( buffered, overlap, Fs );
    [  ~,   Fz, Tz, ~] = getpoles( ar, wSize-overlap, Fs );
    figure;
    plotpoles(STFT, T, F, Tz, Fz, refF0);

end

