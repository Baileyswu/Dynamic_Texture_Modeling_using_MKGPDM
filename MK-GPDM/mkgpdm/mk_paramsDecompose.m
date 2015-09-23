function [X lnHyperpara_Kx lnHyperpara_Ky] = mk_paramsDecompose(params,N,Q,kern)


% �����Ȱ�params�е�X�����еĳ������������    
X = reshape(params(1:N*Q), N, Q); % �ѳ�ʼ������������params�г�ȡ����

% ��Kx�ĳ�������ȡ���������������������Ky��һֱ����ģ����Բ��ÿ���Ky�ĳ�����
num_kern = length(kern.comp);
num_hyperpara_Kx = 1; % �����ʼ��
for i = 1:num_kern
    num_hyperpara_Kx = num_hyperpara_Kx + kern.comp{i}.nParams;
end

lnHyperpara_Kx = params(end-(num_hyperpara_Kx-1):end); %
lnHyperpara_Ky = params(end-(num_hyperpara_Kx+2):end-num_hyperpara_Kx); % ��ȡK_y�ĳ�����������Ϊ3