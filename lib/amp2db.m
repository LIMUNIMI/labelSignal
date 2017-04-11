function [ Y, f ] = amp2db( X, f )
%[ Y ] = amp2db( X, f )
%   Takes amp values to dBfs
%   f is the floor bound expressed in db
%   default f is the lowest non-infinite value present
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

 if any(X<=0), warning('Negative or zero elements in amp matrix'); end;
 Y = 20 * log10(X);
 if nargin < 2
    f = Y(isfinite(Y(:)));
    f = min(f(:));
 end;    
 if ~isempty(f), Y = max(Y,f); end;
end

