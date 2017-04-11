function [ selected ] = findOptimalOrder( buffered, maxorder, fToExplain, LPCfun, envel, Fs )
%[ selected ] = findOptimalOrder( buffered, maxorder, fToExplain, LPCfun, envel, Fs )
%
% INPUT
%    buffered: Input signal split into frames
%    maxorder: Maximum number of orders to test
%  fToExplain: Percent of frames to be explained (%)
%      LPCfun: LPC function (default = @aryule)
%       envel: RMS of each frame (plot results if present)
%          Fs: Sampling frequency (used for plot only)
%
% OUTPUT
%    selected: Ideal model order
%
% ------------------------------------------------------------------------
%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION
% FOR MONOPHONIC MUSICAL INSTRUMENTS
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti
% {haus,ludovico,presti}@unimi.it
%
% findOptimalOrder.m: Autmatically chooses order based on MDL
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

    if nargin < 3, LPCfun = @aryule; end;

    [ MDL, ~ ] = getMDL( buffered, maxorder, LPCfun );
    [ ~, idealOrders ] = min( MDL );
    selected = prctile(idealOrders, fToExplain);
    
    if nargin > 4,
        % Minimum Description Length
        figure, plotOvsT(MDL); 
        % Explained frames
        figure, plotmodeledframes(idealOrders, selected, maxorder, envel, Fs); 
    end

end

