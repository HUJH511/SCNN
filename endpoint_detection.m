function yEdited  = endpoint_detection(y,size,th)
%y: input signal
%size: envelope squeeze size
%th: threshold for endpoint
%FS: sampling frequency
%others: file name

format long g;
format compact;
fontSize = 20;

% Find the envelope by taking a moving max operation, imdilate.
envelope = imdilate(abs(y), true(size, 1));

% Find the quiet parts.
quietParts = envelope < th; % Or whatever value you want.
% Cut out quiet parts.
yEdited = y; % Initialize
yEdited(quietParts) = [];

% name = sprintf('%d_re.wav',others);
% audiowrite(name,yEdited,FS);

end
