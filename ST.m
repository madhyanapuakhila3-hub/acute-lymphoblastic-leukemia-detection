function MEDGE = ST(img)


 f=[-1 1 -1;0 0 0;-1 1 -1];  %%%%%%Haarcoefficients
fT=f';
edgeout=[];
n=1;

          p1=double(img);
        
              px1=sum( p1.*f );
              py1=sum( p1.*fT );
              
              mag=px1+ py1 ;

  
  edgeout= sum(mag)/9;
 
  for i=1:3,
        
       for j=1:3,
           MEDGE (i,j)=edgeout;
       end
 end