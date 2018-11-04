function [labels, Mu, Mu_init, iter] =  my_kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'random','uniform'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N 
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auxiliary Variable
[N, M] = size(X);
d_i    = zeros(K,M);
k_i    = zeros(1,M);
r_i    = zeros(K,M);
if plot_iter == [];plot_iter = 0;end

% Auxiliary Variable
[N, M] = size(X);
if plot_iter == [];plot_iter = 0;end

% Output Variables
labels  = zeros(1,M);
Mu      = zeros(N, K);
Mu_init = zeros(N, K);
Mu_previous = zeros(N, K);

iter      = 0;

% Step 1. Mu Initialization
Mu_init =  kmeans_init(X, K, init);


%%%%%%%%%%%%%%%%%         TEMPLATE CODE      %%%%%%%%%%%%%%%%
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (N==2 && plot_iter)
    options.title       = sprintf('Initial Mu with <%s> method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroid(Mu_init',colors);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iter = 0;
Mu=Mu_init;
while (iter <= MaxIter) && (norm(Mu-Mu_previous)>=0.01)

     %%%%% Implement K-Means Algorithm HERE %%%%
     Mu_previous=Mu;
     % Step 2. Distances from X to Mu
     if (K==1)
         r_i=ones(K,M);
         labels=ones(1,M);
     else
         d_i = my_distX2Mu(X, Mu, type);
         %Step 3. Assignment Step: Mu Responsability  
         %Equation 5
         [~,labels] = min(d_i);
         %Equatin 6
         for i=1:K
             for j=1:M
                if (i==labels(j))
                    r_i(i,j)=1; 
                else
                    r_i(i,j)=0;
                end
             end
         end

        for i = 1:K
            if(sum(r_i(i,:))==0)
                Mu_init = kmeans_init(X, K, init);
                Mu=Mu_init;
                r_i = zeros(K,M);
                labels = zeros(1,M);                
                iter=0;
            end
        end

        %Step 4. Update Step: Recompute Mu % Equation 7  
        for j=1:K
            Multiplication_Matrix = zeros(N, K);
            Sum = 0;
            for i=1:M
                Multiplication_Matrix(:,j)=Multiplication_Matrix(:,j)+r_i(j,i).* X(:,i);
            end
            Sum=Sum+sum(r_i(j,:));
            Mu(:,j)=Multiplication_Matrix(:,j)/Sum;
        end
        nanNumber = sum(isnan(Mu(:,:)));
        isemp = any(nanNumber(:));
        if isemp && MaxIter ~= 25
            iter=0;
            Mu_init =  kmeans_init(X, K, init);
            labels  = zeros(1,M);
            r_i    = zeros(K,M);
            Mu=Mu_init;
        end
    end
    %%%%%%%%%%%%%%%%%         TEMPLATE CODE      %%%%%%%%%%%%%%%%       
    if (N==2 && iter == 1 && plot_iter)
        options.labels      = labels;
        options.title       = sprintf('Mu and labels after 1st iter');
        ml_plot_data(X',options); hold on;
        ml_plot_centroid(Mu',colors);
    end    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    iter = iter+1;
end


%%%%%%%%%%%   TEMPLATE CODE %%%%%%%%%%%%%%%
if (N==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;    
    ml_plot_centroid(Mu',colors);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

