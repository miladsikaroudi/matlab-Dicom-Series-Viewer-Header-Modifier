function fileSorted=dicomreaddir(dirName)

% if you want a gui for asking which directory
% uncomment line below
% dirName=uigetdir();

if dirName==0
    fileSorted=[];
    disp(' Empty directory ');
else
    D=dir(dirName);
    [nooffilesf garb]=size(D);
    
    fileX = [];
    for i=3:nooffilesf  % this assumes that the first and second are . and ..
        % uncomment the if statement below if you want to select only
        % filenames starting with some characters say 'im' in this example
        % similarly we can have a condition to check if the files end in
        % say .dcm
        %if (strfind(D(i).name, 'im')==1)
        fileX(i-2).name = D(i).name;
        %end
    end
    
    [garb nooffiles]=size(fileX);
    
    InstanceN =[];
    h = waitbar(0,'Reading directory...');
    for i=1:nooffiles
        waitbar(i / nooffiles)
        fullfilename = strcat(dirName,'/',fileX(i).name);
        cnt=1;
        if(isfile(fullfilename))
            if(isdicom(fullfilename))
                fileinfo=dicominfo(fullfilename);
                InstanceN= [InstanceN; fileinfo.InstanceNumber];
                cnt=cnt+1;
            end
        end
    end
    close(h);
    [XTemp, Ind]=sort(InstanceN);
    fileSorted=[];
    k = waitbar(0,'Sorting files...');
    cnt=1;
    for i=1:nooffiles
        waitbar(i / nooffiles)
        isFile = isfile(strcat(dirName,'/',fileX(i).name));
        if(isFile)
            isDICOM = isdicom(strcat(dirName,'/',fileX(i).name));
            if(isDICOM)
                fileSorted(cnt).name = strcat(dirName,'/',fileX(i).name);
                cnt=cnt+1;
            end
        end
    end
    close(k)
end


