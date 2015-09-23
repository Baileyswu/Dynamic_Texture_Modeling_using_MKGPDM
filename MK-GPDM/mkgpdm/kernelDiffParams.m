function [K1, K2] = kernelDiffParams(arg1, arg2, arg3, arg4);

% KERNELDIFFPARAMS Get gradients of kernel wrt its parameters.

if nargin < 3
  X1 = arg1;
  X2 = arg1;
  theta = arg2;
else
  X1 = arg1;
  X2 = arg2;
  theta = arg3; % ���Ǻ˺�������������
end

theta = thetaConstrain(theta);

if nargin < 4
    K = kernel(X1, X2, theta);
else
    K = arg4; % �˺�������������ĺ˺����Խ����ϵ�Ԫ�ض���1
end
K2 = K/theta(2); % �����ģ�����棬theta(2)�������������beta1��theta(1)����beta2, dK_y/d \beta_1
K1 = -0.5*dist2(X1, X2).*K; % �����Ӧ�ľ�����������dK_y/d \beta_2

