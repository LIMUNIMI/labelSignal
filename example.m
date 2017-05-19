
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION             %
% FOR MONOPHONIC MUSICAL INSTRUMENTS                   %
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti  %
% {haus,ludovico,presti}@unimi.it                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LABORATORIO DI INFORMATICA MUSICALE
% Dipartimento di Informatica "Giovanni Degli Antoni"
% Università degli Studi di Milano
% Via Comelico, 39 - 20135 Milano (Italy)

% EXAMPLE OF USE OF labelSignal() FUNCTION
% For more details see function help or
% take a look to inDepthExample.m

% examle.m: describes a signal through a time serie of labels
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

%% Setup

    % Clear environment
    clear;
    
    % Add lib folder to path
    addpath(genpath('lib'));

%% Parameters (defaults are commented)
    % General settings:
    % s.plot       = false;     % Process plots
      s.visualize  = true;      % Visualize results
    % s.videoFile  = '';        % Output video filename (optional)
    % s.videoRes   = [640,360]; % Video Resolution

    % Preprocessing:
    % s.targetFs   = 11025;     % Working sampling frequency (Hz)
    % s.windowSize = 0.02321;   % Frame size (Sec)
    % s.prefilter  = 1;         % Preemphasis (A.R. Coefficients)
    
    % Order finder:
      s.order      = 17;        % Order of AR model (automatic if 0)
    % s.maxorder   = 30;        % Maximum order to test (if s.order == 0)
    % s.fToExplain = 95;        % % of frames to model (if s.order == 0)
    % s.LPCfun     = @aryule;   % LPC function to use
      s.f0         = 57.96;     % Reference f0 for control plots (Hz)
    
    % Features extraction:
    % s.ccToKeep   = 11;        % Cepstral coefficients to consider
    
    % Clustering:
    % s.nOfCluster = 25;        % # of clusters (audio classes)

%% Example of use

    % Load file
    [x, Fs] = audioread( 'Khomus.wav' );
    % Get labels
    [ labels, clusters, centroids, T ] = labelSignal( x, Fs, s );


    
