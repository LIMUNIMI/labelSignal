function [ xc, lags ] = plotAC( x, span, scale )
%[ xc, lags ] = plotAC( x, span, scale )
%   Plot autocorrelation function of a bunch of frames
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

[rows,N] = size(x);
xc = zeros(2*span+1,N);
cntr = floor(size(xc,1)/2)+1;

for c = 1:N
    [xc(:,c),lags] = xcorr(x(:,c),span,'unbiased');
    if scale, xc(:,c) = xc(:,c) / xc(cntr,c); end;
end;

% Tm = mean(abs(xc(cntr-60:cntr-1,:)),1,'omitnan');
% [~,To] = sort(Tm);
% xc = xc(:,To);

hold on
for pr = [1:50 100:-1:51]
    color = ([1,1,1]*(abs(pr-50)/50)^0.5)*0.66+0.3;
    plot(lags,prctile(xc,pr,2),'color',color,'linewidth',1.5);
end;
% for pr = [1:floor(N/2) N:-1:floor(N/2)+1]
%     val = abs((pr/N)-0.5)*2;
% %     val = 1-(pr/N);
%     color = ([1,1,1].*val^0.5)*0.66+0.3;
%     plot(lags,xc(:,pr),'color',color,'linewidth',1.0);
% end;
c = parula;
% plot(lags,xc(:,floor(N/2)),':','color',c(16,:),'linewidth',1.5);
plot(lags,prctile(xc,95,2),':','color',c(16,:),'linewidth',1.5);
plot(lags,prctile(xc,05,2),':','color',c(16,:),'linewidth',1.5);
hold off
xlabel('Lag'), ylabel('ACF');
grid on
set(gca,'layer','top');

    uconf = 1.96/sqrt(rows);
    lconf = -uconf;
    hold on
    plot([lags(1),lags(end)],[1 1]'*[lconf uconf],':r','linewidth',1.2)
    hold off

axis([lags(1)/2,lags(end)/2,-1,1])
title('Sample Autocorrelation Sequence')
zoom xon
end

