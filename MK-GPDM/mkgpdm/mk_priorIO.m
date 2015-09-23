function [Xin, Xout] = mk_priorIO(X, segments) 
% ����ʹ�õ���һ��Markovģ�ͣ�����Ǹ߽�ģ�ͣ���Ҫ���¶���

q = size(X,2);

% ��ȡ Xin��Ҳ����X{1:N-1}
Xin = [zeros(1,q); X(1:end-1,:)];
Xin(segments,:) = [];

% ��ȡ Xout��Ҳ����X{2:N}
Xout = X;
Xout(segments,:) = [];
