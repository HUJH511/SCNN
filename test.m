clear all
clc

load('1.mat');
B1 = B;
% figure(1)
% image(B1)

load('1_1.mat');
B2 = B;
% figure(2)
% image(B2)

dim = 5;
kernel = rand(dim)-0.5;

label = zeros(1,10);

out1=zeros(12,96);
label1 = zeros(12,96);

for i = 1:(16-dim+1)
    for j = 1:(100-dim+1)
        temp = B1(i:i+dim-1,j:j+dim-1);
        %if i*j<=9
        %subplot(3,3,i*j)
        %imshow(temp,[0 1])
        %end
        out1(i,j) = conv2(temp,kernel,'valid');
        label = B2(i:i+dim-1,j:j+dim-1);
        label1(i,j) = conv2(label,kernel,'valid');
        error = 0.01*(label1(i,j)-out1(i,j))^2;
        if label1(i,j)>out1(i,j)
            edit = error;
        else 
            edit = -error;
        end
        weight_change = edit/25;
        kernel = kernel+weight_change;
        
        out2 = out1;
        
    end
end
