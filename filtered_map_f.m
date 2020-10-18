clear all
clc

st = cputime

%indicate model
for num = 2:2
    model = num;
    %1: LIF
    %2: HH
    
    if model == 1
        normalized_multiple = 19;
        threshold = 0.6;
        time_scaling_constant = 1;
        delta_t = 0.0000001;
    else
        normalized_multiple = 3e+5;
        threshold = 40;
        time_scaling_constant = 0.5*1e+6;
        delta_t = 0.5;
    end
    
    
    for count = 1:10
        
        [x,fs] = preprocess(count-1);
        
        t=(0:length(x)-1)/fs;
        t0=round(length(t)/100);
        time = (length(x(:,1))/fs)/100;
        
        for k=1:16
            for i = 1:100
                X1=x((round(length(x)*(i-1)/100)+1):round(length(x)*(i)/100));
                t1=t((round(length(t)*(i-1)/100)+1):round(length(t)*(i)/100));
                t1=t1';
                
                y = filtering(X1,fs,k);
                signal=y.^2;
                E=trapz(t1,signal);
                aveE=E/t0;
                A(k,i)=aveE;
            end
        end
        
        A1=A.*normalized_multiple;
        B=ones(16,100);
        for i=1:1:100
            for k=1:1:16
                time1 = time.*time_scaling_constant;
                if model == 1
                    B(k,i)=LIF(i,k,time1,threshold,A1,delta_t);
                else
                    B(k,i)=HH(i,k,time1,threshold,A1,delta_t);
                end
            end
        end
        
        if num == 1
            figure(count)
            image(B)
            name = sprintf('LIF FOR DIGIT %d',count-1);
            title(name);
        else
            fig_no = count+10;
            figure(fig_no)
            image(B)
            name = sprintf('HH FOR DIGIT %d',count-1);
            title(name);
        end
        %%
%         if num == 2
%         name1 = sprintf('base/%d/image4.png',count-1);
%         imwrite(B,name1);
%         end
    end
end
et = cputime-st

%imshow(B,[0 30])
