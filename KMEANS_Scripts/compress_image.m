function [labels, centroids] = compress_image(img,K,init,type,MaxIter)
%COMPRESS_IMAGE Compress the image using k-means
%
%   input -----------------------------------------------------------------
%   
%       o img      : (height x width x 3), the image to cluster
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'random','uniform'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations

%
%   output ----------------------------------------------------------------
%
%       o labels    : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o centroids : (3 x k), centroid of the clusters (corresponds to Mu
%                     returned by k-means


% ADD CODE HERE
% HINT: reshape the img data to get 3x(width*height) array prior to call 
% k-means. Be carefull about the way reshaping works
imgSize = size(img);
width = size(img,2);
height = size(img,1);
img_flat = reshape(img,width*height,3)';
[labels, centroids, ~, ~] =  my_kmeans(img_flat,K,init,type,MaxIter,false);



% END CODE
end

