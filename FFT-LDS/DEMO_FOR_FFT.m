% DEMO FOR FFT GRAY
clear;clc;
% Parameters
texture_name = '4';
filepath = 'E:\2015�� ��������\2015�� Signal Processing ����\�����޸ĸ�\����ʵ��\FFT\';
name = [filepath,texture_name,'.avi'];

% ����demo������THR��n_fft_rgb_vec������һ������ʵ���Ͼ��Ƿֱ���Բ�ͬ������Ч������ͬ�����趨֮�����໥�����ģ�
% ��Ӱ��ġ���������£�ֻ��Ҫ�趨һ�������Ϳ�����
Thr = 90; 
n_fft_rgb_vec = 30; % ��ά��ά��

% ��ȡ��Ƶ�ļ�
input_video = VideoReader(name);
tau = 250;
vidHeight = input_video.Height;
vidWidth = input_video.Width;
mov(1:tau) = struct('cdata', zeros(vidHeight, vidWidth, 'uint8'));

for k = 1 : tau
    mov(k).cdata = imresize(rgb2gray(read(input_video, k)),[120 160]);
end

im = getfield(mov,{1,1},'cdata');
[a b c] = size(im); % reshapeʱ����õĲ���
%

for i = 1:tau  
    temp = double(getfield(mov,{1,i},'cdata'));    
    temp_gray = temp;
    fft_temp_gray = fft2(temp);    
    Y_fft(:,:,i) = fft_temp_gray(:);
    Y_gray(:,i) = temp(:);
end

Y_fft_gray = Y_fft(1:a*b,:);

%%
thr_gray = 0;     
pp = Thr;
Mask_gray = ones(size(Y_fft_gray(:,1)));    
while(   pp < nnz(Mask_gray)/numel(Mask_gray)*100 )

    thr_gray = thr_gray + 1;
    for j = 1:tau
        Mask_gray = Mask_gray & (abs(Y_fft_gray(:,j)) > thr_gray);
    end
end    
th_gray_vec = thr_gray;

%% Synthesis

thr_gray = th_gray_vec(1);
Mask_gray = ones(size(Y_fft_gray(:,1)));

for i = 1:tau    
    Mask_gray = Mask_gray & (abs(Y_fft_gray(:,i)) > thr_gray);
end
pos_gray = find(Mask_gray);
L_gray = length(pos_gray);


Y_fft_masked_gray = Y_fft_gray(pos_gray,:);
Y_SVD_gray(1:L_gray,:) = real(Y_fft_masked_gray);
Y_SVD_gray(L_gray+1:2*L_gray,:) = imag(Y_fft_masked_gray);

Y_SVD_Mean = mean(Y_SVD_gray,2);
[U,S,V] = svd(Y_SVD_gray-Y_SVD_Mean*ones(1,size(Y_SVD_gray,2)),0);
            
%%            
                
n_fft = n_fft_rgb_vec;     
nv_fft = round(n_fft/3*2);      % Order of the noise (Bhat)
first = 1:n_fft;
Chat = U(:,first); % ����LDS�ֵ�Chat
Xhat = S(first,first)*V(:,first)'; % ����LDS�ֵ�Xhat
Ahat = Xhat(:,2:tau)*pinv(Xhat(:,1:tau-1)); % ����LDS�ֵ�Ahat

Vhat = Xhat(:,2:tau)-Ahat*Xhat(:,1:(tau-1));
[Uv,Sv,Vv] = svd(Vhat,0);
Bhat = Uv(:,1:n_fft_rgb_vec)*Sv(1:n_fft_rgb_vec,1:n_fft_rgb_vec);


X = Xhat(:,1); % ��ʼֵ
j = sqrt(-1);

syn_length = 500;
synth_Result(1:syn_length) = struct('frame', zeros(vidHeight, vidWidth, 'uint8'));

X(:,1) = Xhat(:,250); % ���ɲ��ֵ���ʼ֡

for t = 1:syn_length

    X(:,t+1) = Ahat*X(:,t) + Bhat*randn(n_fft_rgb_vec,1); % LDS part
    Y_res = Chat*X(:,t) + Y_SVD_Mean;

    Y_real_gray = Y_res(1:L_gray);  % �ٰ����ɵĲ��ֲ�
    Y_imag_gray = Y_res(L_gray + 1:2*L_gray);    
	Y_fft_synth = zeros(a*b,1);
    temp_gray = Y_real_gray + j*Y_imag_gray;
    Y_fft_synth(pos_gray) = temp_gray;        
    Y_synth_gray = real(ifft2(reshape(Y_fft_synth,a,b)));    
    Y_gray_synth(:,:,1) = Y_synth_gray;
    
    Y_gray_synth1 = uint8(floor((Y_gray_synth - floor(min(Y_gray_synth(:))))./(ceil(max(Y_gray_synth(:)))-floor(min(Y_gray_synth(:))))*255));
    synth_Result(t).frame = Y_gray_synth1;
end

save(strcat(texture_name,'.mat'),'synth_Result')

