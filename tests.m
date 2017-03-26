function [ output_args ] = tests( filename,scanning, basis )
%TESTS Summary of this function goes here
%   Detailed explanation goes here
image=imread(filename);
image=double(image);

switch scanning
    case 'standard'
        x=reshape(image,[],1);
    case 'zigzag'
        x=zigzag(image);
    otherwise
        disp('Wrong sampling method')
        return
end


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
    otherwise
            disp('Wrong basis')
            return
end

%signal in new basis
xb = basisMatrix*x;
ratio=round(nnz(xb)/N*100);
disp(sprintf('%.0i %%',ratio));
[~,name,~]=fileparts(filename)
mkdir(sprintf('%s/%s/%s/',basis,scanning,name))
save(sprintf('%s/%s/%s/settings.mat',basis,scanning,name),'ratio','scanning','basis','filename');
for p=1:99
    rng(0);                                      % set RNG seed
    K = round(N*p/100);                           % number of measurements to take (N < L)
    
    % Obtain K measurements
    A = randn(K, N);
    y = A*xb;
    
    % Perform Compressed Sensing recovery
    x0 = A.'*y;
    try
    xpb = l1eq_pd(x0, A, [], y);
    xp = basisMatrix'*xpb;
    
    switch scanning
        case 'standard'
            imagep=reshape(xp(1:originalN),size(image));
        case 'zigzag'
            imagep=izigzag(xp(1:originalN),size(image,1),size(image,2));
    end
    
    %figure, subplot(2,1,1),imshow(image), subplot(2,1,2), imshow(imagep)
    save(sprintf('%s/%s/%s/%d.mat',basis,scanning,name,p),'imagep','p');
    catch ME
    end
end
end

