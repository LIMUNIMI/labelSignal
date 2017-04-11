function plotLabelledFrames( env,STFT,cluster,col,F,T )
%plotLabelledFrames( env, STFT, cluster, col, F, T )
%   plot Color-coded frames and input sonogram with linked axes
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

ax1 = subplot(2,1,1);
    imagesc( T, F, STFT );
    title('Input STFT');
    ylabel('Frequency (Hz)');
    axis xy; zoom xon; grid on;
ax2 = subplot(2,1,2);
    yl = max(env);
    image(T,(-yl:yl),cluster.'); hold on
    plot(T,env,'color',[1 1 1]*0.15);
    plot(T,-env,'color',[1 1 1]*0.15); hold off
    title('Clustered frames');
    ylabel('Envelope');
    axis xy; grid on; zoom xon
    ylim([-yl, yl]);
    colormap(ax2,col);
linkaxes([ax1 ax2],'x');

end

