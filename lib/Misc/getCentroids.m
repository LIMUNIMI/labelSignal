function [ ARCentroids ] = getCentroids( AR, clusters )
%[ ARCentroids ] = getCentroids( AR, clusters )
%   Averages frequency response AR based on cluster index
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

    nBins    = size(AR,1);
    nOfclusters = numel(unique(clusters));

    ARCentroids = zeros(nOfclusters,nBins);
    for c = 1:nOfclusters
        ARCentroids(c,:) = mean( AR(:,clusters==c) , 2 ).';
    end;

end

