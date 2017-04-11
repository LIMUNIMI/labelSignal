function [ Az, Fz, Tz, Mz ] = getpoles( ar, hop, Fs )
%[ Az, Fz, Tz, Mz ] = getpoles( a, hop, Fs )
%   Returns ar poles coordinates
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

    Az = zeros(size(ar,1)-1,size(ar,2));
    for n = 1:size(ar,2)
        Az(:,n) = roots(ar(:,n));
    end;
    Az(imag(Az)<eps) = nan;

    [Tz, ~] = meshgrid(1:size(Az,2),1:size(Az,1));
    Tz = Tz * (hop)/Fs;
    Fz = (angle(Az)/pi)*Fs/2;
    Mz = abs(Az);

end

