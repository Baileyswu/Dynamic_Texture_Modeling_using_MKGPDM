function mk_ouputVideo(filename,videoSize,Ysample,predFrames)

Y = real(Ysample);
resultsPath = 'E:\2015�� ��������\2015�� �����о� Dynamic Texture\Dynamic_Texture_Modeling\src\multi-kernel\testResults\';
videoFileName = strcat(resultsPath,'Video-',filename,'-',date,'.avi');

writerVID = VideoWriter(videoFileName);
open(writerVID);

for i = 1:predFrames
    I1 = Y(i,:);
    I = reshape(I1,videoSize);
    I = (I - floor(min(I(:))))./(ceil(max(I(:)))-floor(min(I(:))));
    writeVideo(writerVID,I);
end

close(writerVID);