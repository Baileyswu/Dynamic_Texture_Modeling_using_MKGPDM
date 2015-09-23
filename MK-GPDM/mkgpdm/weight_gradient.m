function g = weight_gradient(params, X, kern)

% ������ params �������е�Ȩ����Ϣ�ˣ�Ҳ����params = [w1 w2 ... wn]

segments = 1; %���������һ��markovģ��
% ����1����ÿһ�μ���֮ǰ����Ȩ�ز�������Լ����
params = mk_weightsConstrain(params);

[Xin, Xout] = mk_priorIO(X, segments); % ��Xin��Xout��X�м��ȡ���������������һ��Markovģ�͵����
Q = size(Xout, 2); % �����ĳ���

% ���Ƚ�params�м�Ĳ������µ�kern�ṹ����
kern = mk_updateKernWeight(kern,params);

[Kx, sum_Kx] = mk_computeCompoundKernel(kern,Xin);

invKx = pdinv(sum_Kx);

% ���ڿ�ʼ�����ݶ���ݶ������������ֹ��ɣ��ֱ���Q/2 * ln det(K), 1/2 * tr(K^-1 * Xout *
% Xout^T)���Լ�������,ע�⣬���������ݶ�Ӧ����һ�����󣬶���ÿһ����Ҫ���ݶȵı�����Ӧ����һ���ݶ�ֵ��֮��Ӧ

% �ȼ���dL/dKx

dL_dKx = -Q/2*invKx + 0.5*invKx*(Xout*Xout')*invKx;

% dKx/dw ��ʵ����ÿһ��Kx������
g = zeros(length(kern.comp),1);

for i = 1:length(kern.comp)
    g(i) = sum(sum(dL_dKx .* Kx{i}));
end

% ���������ÿһ��Ȩ�ز������ݶ�

norm2 = 1/norm(params,2); % ����(w1^2+w2^2+...+wn^2)^{-0.5}

for i = 1:length(kern.comp)
    g(i) = g(i) + norm2 * params(i);
end

% Ϊ�˱����ݶ�̫�����ﱣ���ݶȵķ��򲻱䣬���ݶȵĳ��Ƚ��й�һ����Ҳ���Ǽ�ӵļ�С�Ż�����
g = g/norm(g);

g = -g';