function [dLp_dx] = mk_priorDiffX(dLp_dxin, dLp_dxout, N, Q, segments, ~)

% dLp_dxin = 
% dLp_dxout = -invKx*Xout

dLp_dx = zeros(N, Q); % ��ʼ��Ϊ����ΪN������

S = setdiff(1:N,mod(segments-1,N)); % ����һ��Markovģ�ͣ�S = 1:N
S(S==N) = []; % �����һ��Ԫ�ظ�ȥ����,S = 1:N-1
dLp_dx(S,:) = dLp_dxin; % ��dLp_dxin��ֵ��dLp_dx�е�1:N-1��λ��

S = setdiff(1:N,mod(segments,N)); % S���index����ΪXout��index��Ҳ����2:N

dLp_dx(S,:) = dLp_dx(S,:) + dLp_dxout; % ��dLp_dx�е�2:Nλ�õ�ֵ������dLp_dxout

