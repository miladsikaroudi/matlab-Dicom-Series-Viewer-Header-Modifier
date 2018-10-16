function write_dicoms(dicomInfo, image, directory_output, name)
sizeImage = size(image,2);
for i= 1: sizeImage 
    dicomwrite(image{i}, [directory_output,'/Dicom_',num2str(i),name], dicomInfo{i});
    %dicomwrite(image{i}, ['Dicom_',num2str(2*halfImage+1-i),'modified','.dcm'], dicomInfo{2*halfImage+1-i});
end

