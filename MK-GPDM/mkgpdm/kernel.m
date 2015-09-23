function kx = kernel(x, xKern, theta)

% KERNEL Compute the rbf kernel

n2 = dist2(x, xKern);  % ��������X������xKern֮���ƽ��ŷʽ���룬���������M*N�ģ���ô�������M*M�ģ��ֱ����ÿһ��Ԫ�صľ���
wi2 = theta(1)/2;      
kx = theta(2)*exp(-n2*wi2);
   