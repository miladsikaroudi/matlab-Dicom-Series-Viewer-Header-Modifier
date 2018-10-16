function flag = isdicom(fileName)
%ISDICOM True for dicom files
%
%   ISDICOM(FILENAME) returns logical true (1) if the file is a dicom file, 
%   and false (0) otherwise. 
%
%   FILENAME can be either a string or a cell array of strings. If the 
%   input is a cell array, the output is a logical matrix of the same size 
%   as the cell array.
%
%   Example:
%       flag = isnumeric('filename')
%       returns true if the file is a DICOM file.
%
%   Warning: 
%       ISDICOM detects if the four byte string starting at position 128 is
%       equal to 'DICM', which indicates that the file is a DICOM file.
%       This is not a very robust method, since other file types might
%       also accidentally contain the string DICM at position 128, and 
%       non-standard DICOM files might not contain this string. 
%       Please see the newsgroup discussion on <a href="matlab:web('http://newsreader.mathworks.com/WebX/.eef9353?50@474.0yR7b5yCHQl@', '-browser')">isDICOM() function</a>

%% AUTHOR    : Jøger Hansegård
%% $DATE     : 13-Jun-2006 14:16:35 $
%% $Revision : 1.00 $
%% DEVELOPED : 7.2.0.232 (R2006a)
%% fileName  : isdicom.m

error(nargchk(1,1,nargin, 'struct'));

if ~ischar(fileName) && ~iscell(fileName)
  error('Only string and cell inputs are valid');
end

if ischar(fileName)
  fileName = {fileName};
end

% Allocate return values
flag = false(size(fileName));

% Loop through each file and decide if the file contains the 'DICM' tag.
for i = 1:numel(fileName)
  if exist(fileName{i}, 'file') ~= 2
    error('Input argument ''%s'' is not a valid filename', fileName{i});
  end
  [fid, message] = fopen(fileName{i});
  if fid==-1
    error(message);
  end
  status = fseek(fid, 128, 'bof');
  if status~=-1
    tag = fscanf(fid, '%c', 4);
    if isequal(tag, 'DICM')
      flag(i) = true;
    end
  end
  fclose(fid);
end

% Created by: Jøger Hansegård
% Contact...: jogerh@ifi.uio.no
% ===== EOF ====== [isdicom.m] ======
