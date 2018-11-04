function [d] =  my_distance(x_1, x_2, type)
%MY_DISTANCE Computes the distance between two datapoints (as column vectors)
%   depending on the choosen distance type={'L1','L2','LInf'}
%
%   input -----------------------------------------------------------------
%   
%       o x_1   : (N x 1),  N-dimensional datapoint
%       o x_2   : (N x 1),  N-dimensional datapoint
%       o type  : (string), type of distance {'L1','L2','LInf'}
%
%   output ----------------------------------------------------------------
%
%       o d      : distance between x_1 and x_2 depending on distance
%                  type {'L1','L2','LInf'}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d = 0;

% ADD CODE HERE
[N,M] = size(x_1);

if type == "L1"
    for i=1:N
        d=d+abs(x_1(i)-x_2(i));   
    end
elseif type == "L2"
    for i=1:N
        d=d+(abs(x_1(i)-x_2(i)))^2;
    end
    d=sqrt(d);
elseif type == "LInf" 
    absDiff = abs( x_1 - x_2 ) ;
    d = max( absDiff ) ;
end 

% END CODE

end