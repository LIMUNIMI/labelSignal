function plotDendrogram( tree, nOfCluster )
%plotDendrogram( tree, nOfCluster )
%   Plots a dendrogram based on 'tree' and respective number of clusters
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

    cID = sort(tree(:,3));
    thres = cID(size(tree,1)+2-nOfCluster);
    P = max(30,nOfCluster);
    H = dendrogram(tree,P,'colorthreshold', thres);
    set(H,'LineWidth',1.2)
    title('Clusters Dendrogram')
    grid on
    
%     lineColours = cell2mat(get(H,'Color'));
%     colourList = unique(lineColours, 'rows');
%     
%     for colour = 2:size(colourList,1)
%         idx = ismember(lineColours, colourList(colour,:), 'rows');
%         lineColours(idx, :) = repmat(clusterColors(colour-1,:),sum(idx),1);
%     end
%     
%     for h = 1:size(H,1)
%         set( H(h), 'Color', lineColours(h,:) );
%     end;

end

