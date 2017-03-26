for i=1:99
    load(sprintf('haarR/%d.mat',i))
    diff=(double(image)-imagep)/255;
    error(i)=sum(sum((diff.^2))) 
end

plot(error)

xlabel('K/N*100%')
ylabel('Error')
legend(sprintf('%d%% of non zero elements',47))
title('Basis: Haar')