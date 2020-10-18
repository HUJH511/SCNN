function w_filtered = filtering(w,fs,count)
%w: input signal
%fs: sampling frequency
%count: No. of filter

t = (0:length(w)-1)/fs;

wf = abs(fft(w));
wf = do_db(wf);
%seperate one track and specify length
w = w(:,1);
len = length(wf);

%%proceed eight different filters
%define all cut-off frequency parameters 
f_d = [[250 0];
    [250 500];
    [500 750];
    [750 1000];
    [1000 1250];
    [1250 1500];
    [1500 1750];
    [1750 2000];
    [2000 2250];
    [2250 2500];
    [2500 2750];
    [2750 3000];
    [3000 3250];
    [3250 3500];
    [3500 3750];
    [3750 0]];
   
%    f_d = [[500 0];
%        [500 1000];
%        [1000 1500];
%        [1000 2000];
%        [2000 2500];
%        [2500 3000];
%        [3000 3500];
%        [3500 0]];

%define convet function for frequency to normalised frequency
f_c = [];
for i=1:16
    for j=1:2
        f_c(i,j) = f_d(i,j)./(fs/2);
    end
end

i = count;

%first low pass filter with cut-off frequency 150Hz
if i==1
    [b a] = butter(2,f_c(1,1),'low');
    H = freqz(b,a,floor(len/2));
    
    %filting input signal
    w_filtered = filter(b,a,w);
    
    
    %filter 8 is high pass filter with pass frequency 3750Hz
elseif i==16
    [b a] = butter(2,f_c(16,1),'high');
    H = freqz(b,a,floor(len/2));
    
    %filting input signal
    w_filtered = filter(b,a,w);
       
else
    %filter 2 to 7 are bandpass filters
    [b a] = butter(2,[f_c(i,1) f_c(i,2)]);
    H = freqz(b,a,floor(len/2));
    
    %filting input signal
    w_filtered = filter(b,a,w);
      
end

end