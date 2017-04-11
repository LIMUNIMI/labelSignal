function [ x ] = MDLtest( err, p )
%[ x ] = MDLtest( err, p )
%   Computes Rissanen's Minimum Description Length
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

N = size(err,1);  % number of data points fitted
V = mean(err.^2);     % loss function;
x = V*(1+p*log(N)/N); % Rissanen's Minimum Description Length

end

