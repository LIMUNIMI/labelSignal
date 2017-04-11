function [ ] = renderLabels( buffered, Fs, envel, labels, clusters, outputVideo, videoSize )
%[ ] = renderLabels( buffered, Fs, labels, clusters, outputVideo, videoSize )
%
% INPUT
%    buffered: Input signal split into frames
%          Fs: Sample frequency
%       envel: Input envelope
%      labels: Triplet of numbers for each frame
%    clusters: Cluster index of each frame
% outputVideo: Filename of output mp4 (optional)
%   videoSize: Video resolution [width, height]
% 
% OUTPUT: Plot color-coded frames and input spectrogram.
%         Can also produce a video file
%
% ------------------------------------------------------------------------
%
% AUTOMATIC ANNOTATION OF TIMBRE VARIATION
% FOR MONOPHONIC MUSICAL INSTRUMENTS
% Goffredo Haus, Luca A. Ludovico, and Giorgio Presti
% {haus,ludovico,presti}@unimi.it
%
% renderLabels.m: visualize labels as colours
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
    
    if nargin < 6, outputVideo = ''; end;
    envel = envel/max(envel);

    % Input STFT
    wSize      = size(buffered,1);
    overlap    = 1/2 * wSize;
    [ STFT, F,  T    ] = getSTFT( buffered, overlap, Fs );

    % Normalize labels to match RGB space
    col = (labels-min(labels(:)))/range(labels(:));
    
    % Plot centroids in RGB (sub)space
    figure
    scatter3(col(:,1),col(:,2),col(:,3),30,col,'filled');
    xlabel('R'), ylabel('G'), zlabel('B');
    title('MDS over centroids LSD');
        
    % Create video
    figure
    if ~strcmp(outputVideo,''), set(gcf, 'Position', [100, 250, videoSize]); end;
    plotLabelledFrames(envel,STFT,clusters,col,F,T);
    if ~strcmp(outputVideo,''), renderVideo( gca, gcf, T(end), outputVideo ); end;

end

