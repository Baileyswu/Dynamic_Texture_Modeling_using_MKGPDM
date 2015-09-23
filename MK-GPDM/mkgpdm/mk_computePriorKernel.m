function [K, invK, rbfK] = mk_computePriorKernel(X, theta)

% �����GPDM����ģ�ͣ����������K_X�ĺ˺���

rbfK = kernel(X, X, theta(2:3));
K = lin_kernel(X, X, theta(1)) + rbfK + eye(size(X, 1))*1/theta(end);
invK = pdinv(K);
