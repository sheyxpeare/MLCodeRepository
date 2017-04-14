bestcv = 0;
orgXtrain = Xtrain;
for d = 28:32,
    Xtrain = orgXtrain;
    Distance = zeros(length(Xtrain(1,:)),length(Xtrain(1,:)));
    for i = 1:length(Xtrain(1,:))
        for j = 1:length(Xtrain(1,:))
          Distance(i,j) = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2 + (z(i)-z(j))^2);
         if Distance(i,j) < (1.03^d)
               Distance(i,j)= 1;
         else
              Distance(i,j)= 0;
         end
        end
    end

    Thresh = sum(Distance);
    summ = repmat(Thresh,501,1);
    Xsmooth = Xtrain*Distance; 
    Xrealsmooth = Xsmooth./summ;
    Xtrain = Xrealsmooth;
 
        coeff = pca(Xtrain);
        Xtrain = Xtrain*coeff(:,1:450);
        
        neventsTrain = eventsTrain;
            for i=1:501
                 if(neventsTrain(i) <351)
                    eventsTrain(i) = 1;
                 else
                    eventsTrain(i) = 2;
                 end
            end
 
Xtrain = [subjectsTrain eventsTrain Xtrain];

        for c = 20:30,
            for g = -33:-25,
                cmd = ['-v 5 -c ', num2str(1.2^c), ' -g ', num2str(1.5^g)];
                cv = svmtrain(Ytrain, Xtrain, cmd);
            if (cv >= bestcv),
             bestcv = cv; bestc = 1.2^c; bestg = 1.5^g; bestd = 1.03^d;
            end
            fprintf('c=%g g=%g d=%g rate=%g (best c=%g, g=%g, d=%d, rate=%g)\n', c, g, d, cv, bestc, bestg, bestd, bestcv);
            end
        end
end