function [ labels, clusters, centroids, T ] = labelSignal( x, Fs, s )
%[ labels, clusters, centroids, T ] = labelSignal( x, Fs, settings )
%
% INPUT
%           x: Input signal
%          Fs: Input sampling frequency (Hz)
%    settings: Record of settings (see below)
%
% OUTPUT
%      labels: 3D Labels over time
%    clusters: Cluster indexes over time
%   centroids: Centroids of each cluster
%           T: Time points sampled
%
% SETTINGS DEFAULTS
%
%     General settings:
%     s.plot       = false;     % Process plots
%     s.visualize  = false;     % Visualize results
%     s.videoFile  = '';        % Output video filename (optional)
%     s.videoRes   = [640,360]; % Video Resolution
% 
%     Preprocessing:
%     s.targetFs   = 11025;     % Working sampling frequency (Hz)
%     s.windowSize = 0.02321;   % Frame size (Sec)
%     s.prefilter  = 1;         % Preemphasis (A.R. Coefficients)
%     
%     Order finder:
%     s.order      = 0;         % Order of AR model (automatic if 0)
%     s.maxorder   = 30;        % Maximum order to test (if s.order == 0)
%     s.fToExplain = 95;        % % of frames to model (if s.order == 0)
%     s.LPCfun     = @aryule;   % LPC function to use
%     s.f0         = NaN;       % Reference f0 for control plots (Hz)
%     
%     Features extraction:
%     s.ccToKeep   = 11;        % Cepstral coefficients to consider
%     
%     Clustering:
%     s.nOfCluster = 25;        % # of clusters (audio classes)
%
% ------------------------------------------------------------------------
%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION
% FOR MONOPHONIC MUSICAL INSTRUMENTS
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti
% {haus,ludovico,presti}@unimi.it
%
% labelSignal.m: describes a signal through a time serie of labels
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

%% Parameters defaults

    % General settings
    if ~isfield(s, 'plot'),       s.plot       = false;     end;
    if ~isfield(s, 'visualize'),  s.visualize  = false;     end;
    if ~isfield(s, 'videoFile'),  s.videoFile  = '';        end;
    if ~isfield(s, 'videoRes'),   s.videoRes   = [640,360]; end;

    % Preprocessing
    if ~isfield(s, 'targetFs'),   s.targetFs   = 11025;     end;
    if ~isfield(s, 'windowSize'), s.windowSize = 0.02321;   end;
    if ~isfield(s, 'prefilter'),  s.prefilter  = 1;         end;
    
    % Order finder
    if ~isfield(s, 'order'),      s.order      = 0;         end; 
    if ~isfield(s, 'maxorder'),   s.maxorder   = 30;        end;
    if ~isfield(s, 'fToExplain'), s.fToExplain = 95;        end;
    if ~isfield(s, 'LPCfun'),     s.LPCfun     = @aryule;   end;
    if ~isfield(s, 'f0'),         s.f0         = NaN;       end;
    
    % Features extraction
    if ~isfield(s, 'ccToKeep'),   s.ccToKeep   = 11;        end;
    
    % Clustering
    if ~isfield(s, 'nOfCluster'), s.nOfCluster = 25;        end;

%% Compute features and labels

    [buffered, envel, Fs] = preprocessing( x, Fs, s.targetFs, s.windowSize, s.prefilter );
    if (s.order == 0),
        if (s.plot),
            s.order = findOptimalOrder( buffered, s.maxorder, s.fToExplain, s.LPCfun, envel, Fs );
        else
            s.order = findOptimalOrder( buffered, s.maxorder, s.fToExplain, s.LPCfun );
        end;
    end;
    ar = s.LPCfun(buffered, s.order).';
    if (s.plot), checkModel( buffered, ar, Fs, s.f0 ); end;
    nBins  = 1 + size(buffered,1)/2;
    [ cc, AR ] = extractFeature( ar, s.ccToKeep, nBins, Fs );
    clusters = clusterFrames( cc, s.nOfCluster );
    [ labels, centroids ] = centroidBasedLabelling( AR, clusters );
    if (s.visualize),
        renderLabels( buffered, Fs, envel, labels, clusters, s.videoFile, s.videoRes );
    end;
    T = getFramesTiming( size(buffered), size(buffered,1)/2, Fs );
    
end

