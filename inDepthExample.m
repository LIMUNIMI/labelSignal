
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION             %
% FOR MONOPHONIC MUSICAL INSTRUMENTS                   %
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti  %
% {goffredo.haus,luca.ludovico,giorgio.presti}@unimi.it%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% inDepthExample.m: step-by-step description of a signal through labels
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

%% Procedure as described in the paper
%
%     1. Preprocess input to uniform the dataset
%        - Discard stereophonic information
%        - Sample rate conversion
%        - Pre-emphasis filter
%        - Split input in frames
%        - L2 Normalization of each frame
%
%     2. Labelling small frames by timbral properties
%        - Choose order so as to explain a percentile of the input
%        - Extract LPC coefficients of each frame
%        - Extract features from LPC coefficients
%        - Cluster frames based on extracted features
%        - Label clusters based on centroid features
%
%     3. Visualization
%        - Normalize
%        - Create video
%
% (for details see functions help and source code)

%% Parameters

    % Add lib folder to path
    addpath(genpath('lib'));

    % Global parameters
    inputFile  = 'khomus.wav';
    
    % Preprocessing
    targetFs   = 11025;    % Hz
    windowSize = 0.02321;  % Sec
    prefilter  = 1;        % A.R. Coefficients
    
    % Order finder
    maxorder   = 30;       % Maximum order to test
    fToExplain = 95;       % % of frames to model
    LPCfun     = @aryule;  % LPC function to use
    
    % Features extraction
    ccToKeep   = 11;       % Cepstral coefficients to consider
    
    % Clustering
    nOfCluster = 25;       % # of cluster (audio classes)
    cDistance  = 'ward';   % Hierarchical cluster distance method
    
%% 1. Preprocess input to uniform the dataset
    
    % Load file
    [x, Fs] = audioread( inputFile );

    % Preprocess file
    [buffered, envel, Fs] = preprocessing( x, Fs, targetFs, windowSize, prefilter );
    

%% 2. Labelling small frames by timbral propertiesSelect order
    
    % Choose order so as to explain a percentile of the input
    % (produces plots if "envel" and "Fs" are given)
    order = findOptimalOrder( buffered, maxorder, fToExplain, LPCfun, envel, Fs );
    
    % Extract LPC coefficients of each frame
    ar = LPCfun(buffered, order).';
    
    % Check if modeling is correct
    checkModel( buffered, ar, Fs, 57.96 );
    
    % Extract features from LPC coefficients
    nBins      = 1 + size(buffered,1)/2;
    [ cc, AR ] = extractFeature( ar, ccToKeep, nBins, Fs );
    
    % Cluster frames based on extracted features
    % [from now on you can put together features from multiple files 
    % to make them share the same subspace (i.e compatible labels)]
    clusters = clusterFrames( cc, nOfCluster, cDistance );
    
    % Tag clusters based on centroid features
    [ labels, ~ ] = centroidBasedLabelling( AR, clusters );
    
%% 3. Visualization
    
    % Plot labels as colored frames
    renderLabels( buffered, Fs, envel, labels, clusters )
    
    % It can also save videos!
    % renderLabels( buffered, Fs, envel, labels, clusters, 'Output_file', [640, 360] )
    
