function xf_db = do_db(xf)
for i = 1:size(xf)
    if xf(i) < 1
        xf(i) = 1;
    end
end
xf_db = 10*log10(xf);
end
