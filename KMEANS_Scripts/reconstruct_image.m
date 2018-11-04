function [rimg] = reconstruct_image(labels,centroids,imgSize)
%RECONSTRUCT_IMAGE Reconstruct the image given the labels and the centroids
%
%   input -----------------------------------------------------------------
%   
%       o labels: The labels of the corresponding centroid for each pixel
%       o centroids: All the centroids and their RGB color value
%       o imgSize: Size of the original image for reconstruction
%
%   output ----------------------------------------------------------------
%
%       o rimg : The reconstructed image

% ADD CODE HERE: Reconstruct the image based on the labels on the centroids
% HINT: Apply the two steps you have used to reshape in the opposite order 
% if necessary

[~,M] = size(labels);
[D,K] = size(centroids);
rimg = zeros(M,D);
for i=1:K
    for j=1:M
        if labels(j)==i
            rimg(j,:)=centroids(:,i)';
        end
    end
end

rimg = reshape(rimg,imgSize(1),imgSize(2),imgSize(3));

% END CODE
end
