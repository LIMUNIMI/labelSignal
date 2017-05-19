function plotOvsT( T,p )
%plotOvsT( T,p )
%   Plots Minimum Description Length results for a bunch of frames
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

N = size(T,2);

Tm = mean(T,1,'omitnan');
[~,To] = sort(Tm);

T = T(:,To);

% subplot(2,1,1)

hold on

for pr = [1:floor(N/2) N:-1:floor(N/2)+1]
    val = abs((pr/N)-0.5)*2;
    color = ([1,1,1].*val^0.5)*0.66+0.3;
    plot(T(:,pr),'color',color,'linewidth',1.0);
end;

for pr = [1:floor(N/2) N:-1:floor(N/2)+1]
    val = 1-abs((pr/N)-0.5)*2;
    color = [0.2,0.3,0.5].*val^0.5+0.4;
    [iv,ip] = min(T(:,pr));
    jitter = ((rand-0.5)*val)/3;
    scatter(ip+jitter,iv,32,color,'.');
end;

if nargin >1, plot([p p],[0 max(T(:))],':m','linewidth',1.2); end;

hold off
xlim([1,size(T,1)]);
xlabel('Order'), ylabel('Score');
grid on, box on
set(gca,'layer','top');
title('Minimum description length')

end

