function [ labels, ARCentroids ] = centroidBasedLabelling( AR, clusters )
%[ labels ] = centroidBasedLabelling( AR, clusters )
%
% INPUT
%          AR: Autoregressive frequency response for each frame
%    clusters: Cluster index for each frame
% 
% OUTPUT
%      labels: Triplet of numbers for each frame
% ARCentroids: Centroid of each cluster
%
% ------------------------------------------------------------------------
%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION
% FOR MONOPHONIC MUSICAL INSTRUMENTS
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti
% {goffredo.haus,luca.ludovico,giorgio.presti}@unimi.it
%
% centroidBasedLabelling.m: calculates centroids and turns them into labels
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

    ARCentroids = getCentroids(AR,clusters);
    D   = pdist(ARCentroids,@lsdpdist);
    labels = mdscale(D,3,'start','random');

end

