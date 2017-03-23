% Used code from:
% https://www.codeproject.com/Articles/852910/Compressed-Sensing-Intro-Tutorial-w-Matlab
% Initialize constants and variables
rng(0);                                      % set RNG seed
image=double(imread('qr_code1.png'));        %read image
N = size(image,1)*size(image,2);             % length of signal
K = uint32(N*0.65);                          % number of measurements to take (N < L)
x = reshape(image,[],1);                     % original signal

amp = 1.2*max(abs(x));
figure; subplot(3,1,1); plot(x); title('Original signal'); xlim([1 N]); ylim([-amp amp]);

% Obtain K measurements
A = randn(K, N);
y = A*x;
subplot(3,1,2); plot(y); title('K measured values'); xlim([1 K]);

% Perform Compressed Sensing recovery
x0 = A.'*y;
xp = l1eq_pd(x0, A, [], y);
subplot(3,1,3); plot(real(xp)); title('Recovered signal'); xlim([1 N]); ylim([-amp amp]);
imagep=reshape(xp,size(image));
figure, subplot(2,1,1),imshow(image), subplot(2,1,2), imshow(imagep)