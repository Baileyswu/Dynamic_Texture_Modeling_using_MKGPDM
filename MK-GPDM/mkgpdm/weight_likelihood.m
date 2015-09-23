function L = weight_likelihood(params, X, kern)

% ������ params �������е�Ȩ����Ϣ�ˣ�Ҳ����params = [w1 w2 ... wn]
segments = 1; %���������һ��markovģ��
% ����1����ÿһ�μ���֮ǰ����Ȩ�ز�������Լ����
params = mk_weightsConstrain(params);

Q = size(X, 2); % �����ĳ���
[Xin, Xout] = mk_priorIO(X, segments); % ��Xin��Xout��X�м��ȡ���������������һ��Markovģ�͵����

% ���Ƚ�params�м�Ĳ������µ�kern�ṹ����
kern = mk_updateKernWeight(kern,params);

% �������Ȩ�صĺ˺���

[~, sum_kerns] = mk_computeCompoundKernel(kern,Xin);

invK = pdinv(sum_kerns);

L = Q/2 * logdet(sum_kerns) + 1/2 * trace(invK * (Xout * Xout')) + norm(params);