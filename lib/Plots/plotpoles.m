function plotpoles( STFT, T, F, Tz, Fz, f0 )
%plotpoles( STFT, T, F, Tz, Fz, f0 )
%   Plot poles over input STFT
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

    imagesc( T, F, STFT ); hold on
    colormap (1 - gray);
    line([Tz(1),Tz(end)],[f0, f0],'color','b');
    scatter(Tz(:),Fz(:),4,'m','x'); hold off
    title('Input STFT and non-zero AR model poles frequencies');
    ylabel('Frequency (Hz)');
%     ylim([0,f0*4]);
    axis xy; zoom xon; grid on;
    legend(sprintf('f_0 = %.2f Hz',f0),'AR Poles');

end

