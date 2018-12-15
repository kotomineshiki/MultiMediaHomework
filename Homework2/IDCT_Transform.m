function Y=IDCT_Transform(X)
A=zeros(8);
 for i=0:7
     for j=0:7

        sum=0;
        for u=0:7
            for v=0:7
               if u==0
                    CU=0.5^0.5;
               else
                    CU=1;
               end   
        if v==0
            CV=sqrt(1/2);
         else
            CV=sqrt(1);
        end 
                
                sum=sum+(CU*CV/4)*(cos((2*i+1)*u*pi/16)*cos((2*j+1)*v*pi/16)*X(u+1,v+1));
            end
        end
        A(i+1,j+1)=sum;
    end
 end
Y=A;

end