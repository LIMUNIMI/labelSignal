function plotmodeledframes( ip, p, xl, env, Fs)
%plotmodeledframes( ip, p, xl, env, Fs)
%   Plots a couple of graphs showing correctly modeled frames
%   Green frames are probably overfitted, but it's not relevant for our
%   purpose
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

if nargin < 3, xl = max(ip(:)); end;

easy = 1 + round(Fs / 1000);

if nargin > 2, subplot(3,1,[1;2]); end;
    exp = histcounts(ip(:),1:xl,'Normalization','probability'); 
    exp = cumsum(exp)*100;
    exp = [exp exp(end)];
    h = area(exp);
    h.FaceColor = [1.0 0.8 0.8];
    h.EdgeColor = 'none';
    hold on
    if nargin >1
        exp2=exp;
        exp2(p:end)= exp(p);
        h = area(exp2);
        h.FaceColor = [0.9 0.9 1.0];
        h.EdgeColor = 'none';
        
        exp2=exp;
        exp2(easy:end)= exp(easy);
        h = area(exp2);
        h.FaceColor = [0.9 1.0 0.9];
        h.EdgeColor = 'none';
    end;
    plot(exp,'k');
    hold off
    grid on
    set(gca,'layer','top')
    xlim([1,xl]);
    ylim([0,105]);
    xlabel('Order'), ylabel('% of frames');
    title('Percentage of frames modeled correctly for each order value')

if nargin > 2
    env = amp2db(env);
    bv = min(env);
    subplot(3,1,3); 
        h = area(env,bv); hold on;
        h.FaceColor = [0.9 0.9 1.0];
        h.EdgeColor = 'none';
        
        env2=env;
        env2(ip<p) = nan;
        h = area(env2,bv);
        h.FaceColor = [1.0 0.8 0.8];
        h.EdgeColor = 'none';
        
        env2=env;
        env2(ip>easy) = nan;
        h = area(env2,bv);
        h.FaceColor = [0.9 1.0 0.9];
        h.EdgeColor = 'none';
        
        plot(env,'k');
        title('Frames not explained');
        hold off
        grid on
        set(gca,'layer','top')
        ylim([bv,max(env)*0.85]);
        xlim([1,size(env,2)]);
        ylabel('Amp (dB)'), xlabel('Time (#frame)');
end;
end

