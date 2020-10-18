function [signal,FS] = preprocess(num)
name = sprintf('data/%d/%d.wav',num,num);
[X,FS]=audioread(name);

peak = max(abs(X));

X = X./peak.*0.5;

signal = endpoint_detection(X,256,0.05);

end