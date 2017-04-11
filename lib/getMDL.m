function [ MDL, err ] = getMDL( buffered, maxorder, LPCfun )
%[ MDL, err ] = getMDL( buffered, maxorder, LPCfun )
%   Computes minimum description length
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

    nFrames    = size(buffered,2);
    err = zeros(size(buffered));
    MDL = zeros(maxorder,nFrames);
    for order = 1:maxorder
        a = LPCfun(buffered, order);
        for c = 1:nFrames-1
            err(:,c) = filter(a(c,:),1,buffered(:,c));
        end;
        MDL(order,:) = MDLtest(err,order);
    end;

end

