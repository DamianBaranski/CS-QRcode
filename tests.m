function [ output_args ] = tests( image,shutter, basis )
%TESTS Summary of this function goes here
%   Detailed explanation goes here
image=double(image);
x=reshape(image,[],1);

%calculate length
originalN=length(x);
%algin to 2^n
N=ceil(log(originalN)/log(2));
N=2^N;

newX = zeros(N,1);
newX(1:originalN)=x;
x=newX;

disp(N)
switch basis
    case 'standard'
        basisMatrix=eye(N);
    case 'haar'
        basisMatrix=haargen(N);
    case 'welsh'
        basisMatrix=hadamard(N);
end

%signal in new basis
xb = basisMatrix*x;
disp(sprintf('%.0i %%',round(nnz(xb)/N*100)))

for p=1:99
    rng(0);                                      % set RNG seed
    K = round(N*p);                           % number of measurements to take (N < L)
    
    % Obtain K measurements
    A = randn(K, N);
    y = A*xb;
    
    % Perform Compressed Sensing recovery
    x0 = A.'*y;
    try
    xpb = l1eq_pd(x0, A, [], y);
    xp = basisMatrix'*xpb;
    imagep=reshape(xp(1:originalN),size(image));
    
    %figure, subplot(2,1,1),imshow(image), subplot(2,1,2), imshow(imagep)
    save(sprintf('%s/%d.mat',basis,p),'imagep','p');
    catch ME
    end
end
end

