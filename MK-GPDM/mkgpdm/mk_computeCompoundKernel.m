function [K, sum_kerns] = mk_computeCompoundKernel(kern,X1,X2)

% ������������������˺����Ľ��
% kern�ṹ�壬ʹ�õ���GP-MAT�����еĽṹ�壬����û��ʹ�ø��Ͻṹ�壬��Ҫ�ǶԸ��Ͻṹ���е�Ƕ�׽ṹ���Ǻ����
% X�����ݱ���
% sum_kerns ��Ȩ�صĶ�˺����ĺ�
% K ����Ȩ�ص�ÿ���˺��������������ڶ��ѧϰ�Ĺ�����

% kernelType = {'rbfKern','linKern'};

num_kerns = length(kern.comp);
K  = cell(num_kerns,1);

if (nargin == 2) % ��������غ˺���

    sum_kerns = zeros(size(X1,1),size(X1,1));

    for i = 1:num_kerns    
        fhandle = str2func([kern.comp{i}.type 'KernCompute']);    
        K{i} = fhandle(kern.comp{i}, X1, X1);
        sum_kerns = sum_kerns + kern.weight(i) * K{i};
    end
elseif (nargin == 3) % ��������غ˺���

    sum_kerns = zeros(size(X1,1),size(X2,1));
    for i = 1:num_kerns    
        fhandle = str2func([kern.comp{i}.type 'KernCompute']);    
        K{i} = fhandle(kern.comp{i}, X1, X2);
        sum_kerns = sum_kerns + kern.weight(i) * K{i};
    end
    
end