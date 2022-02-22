function [ buffered, envel, Fs ] = preprocessing( x, Fs, targetFs, windowSize, prefilter )
%[ buffered, envel, Fs ] = preprocessing( x, Fs, targetFs, windowSize, prefilter )
%
% INPUT
%           x: Input signal
%          Fs: Input sample frequency (Hz)
%    targetFs: Target sample frequency (Hz)
%  windowSize: Frame size (Sec)
%   prefilter: Preemphasis a.r. coefficients (default is [1])
%
% OUTPUT
%    buffered: Output signal split into frames
%       envel: RMS of each frame
%          Fs: Output sample frequency (Hz)
%
% Comments:
%   Overlap is fixed at 50%
%
% ------------------------------------------------------------------------
%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION
% FOR MONOPHONIC MUSICAL INSTRUMENTS
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti
% {goffredo.haus,luca.ludovico,giorgio.presti}@unimi.it
%
% preprocessing.m: preprocessing routine
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

    if nargin < 5, prefilter = 1; end

    % Discard stereophonic information
    x = mean( x, 2 );

    % Sample rate conversion
    %[p, q]   = rat( targetFs / Fs, 0.1 );
    p  = targetFs;  
    q  = Fs;
    x  = resample( x, p, q );
    Fs = targetFs; % Fs * p/q;
    clear targetFs p q 
    
    % Pre-emphasis filter
    x = filter(1,prefilter,x);
    
    % Split input in frames
    wSize = round( windowSize * Fs);
    overlap    = round(1/2 * wSize);
    buffered   = buffer( x, wSize, overlap );

    % L2 Normalization of each frame
    average  = mean(buffered,1,'omitnan'); 
    buffered = bsxfun(@minus,buffered,average);
    envel    = rms(buffered)+eps;
    buffered = bsxfun(@times,buffered,1./envel); 

end

