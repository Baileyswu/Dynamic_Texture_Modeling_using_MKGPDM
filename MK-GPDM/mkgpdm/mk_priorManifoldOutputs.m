function [xo, varxo] = mk_priorManifoldOutputs(xi, Xin, Xout, ~, invKx, kern)

% Xin, Xout, hyperpara_Kx, invKx
% xi ����Q��ά��ȫ����0
Q = size(Xout,2);

input = [xi(:,1:Q)]; % [X_pred(n-1,:) zeros(1,Q)], input = X_pred(n-1,:) ��n=2��ʱ��Ҳ����X(200),�������X 

N = size(Xout, 1); % Xin��ά��
M = size(input, 1); % ����ֻ��һ����Ҳ����x(t)

%��alpha = zeros(N, Q);
% ����Ҫ�޸ĳɶ�˵���ʽ
% kbold = lin_kernel(input, Xin, hyperpara_Kx(1))' + kernel(input, Xin, hyperpara_Kx(2:3))'; % ���Ժ˼��ϸ�˹��

[~, kbold] = mk_computeCompoundKernel(kern,input,Xin); % ����
kbold = kbold';

% ����\mu_x Ҳ���Ǿ�ֵ
A = Xout'*invKx; % Xout^T * Kx^-1
output = A*kbold; % Xout^T * Kx^-1 * Kx(X)

output = output'; % ��һ��������Ϊ�˵������ݵĸ�ʽ

% ����\sigma_x Ҳ���Ƿ���
output_var = zeros(M, 1);
% ���������ʲô��˼�أ�
for i = 1:M
    [~, kxx] = mk_computeCompoundKernel(kern,input(i,:),input(i,:));
    output_var(i) = kxx - kbold(:, i)'*invKx*kbold(:, i);
%    output_var(i) = lin_kernel(input(i,:), input(i,:), hyperpara_Kx(1)) + hyperpara_Kx(3) +1/hyperpara_Kx(end) - kbold(:, i)'*invKx*kbold(:, i); 
end

xo = output;
varxo = output_var;

