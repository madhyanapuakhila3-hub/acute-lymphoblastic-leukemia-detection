function Mreproduce = ENERGY(img)



          p1=double(img);
        
  
  meanout= sum(p1(:))/9;
  
  
  out1=double(img(1,1));
  out2=double(img(1,2));
  out3=double(img(1,3));
  out4=double(img(2,1));
  out5=double(img(2,3));
  out6=double(img(3,1));
  out7=double(img(3,2));
  out8=double(img(3,3));
  
  out=( (meanout - out1) + (meanout - out2) + (meanout - out3) + (meanout - out4) + (meanout - out5) + (meanout - out6) + (meanout - out7) + (meanout - out8) );
 
  for i=1:3,
        
       for j=1:3,
           Mreproduce (i,j)=out;
       end
 end