function [ ] = renderVideo( ax1, fig, maxt, filename )
%[ ] = renderVideo( ax1, fig, maxt, filename )
%   Render a mp4 video from the current plot
%   You can manually paste audio under the output file, it will be
%   sinchronized with what is shown in the center of the window
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

vz = 5;   % Zoom-in to show "vz" seconds
mint = 0; % Start time
fps = 24; % Frames per second
nfotogrammi = floor(maxt * fps);

v = VideoWriter(filename,'MPEG-4');
v.FrameRate = fps;
open(v);
for tt = linspace(mint-vz/2,maxt-vz/2,nfotogrammi)
    xlim(ax1,[tt,tt+vz]);
    frame = getframe(fig);
    writeVideo(v,frame);
end;
close(v);

end

