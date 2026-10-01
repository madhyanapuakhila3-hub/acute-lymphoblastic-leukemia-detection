function BOXCOUNT = BOXCOUNTING(img)

 
BOXCOUNT=1;
 n=1;
 for k=1:2500, % number of blocks
    
   for i=1:5,
        
       for j=1:5,
             
             oneblk(i,j)=img(n); 
             n=n+1;
             
         end
   end
   for i=1:5,
        
       for j=1:5,
             
            if oneblk(i,j) ==0
              
                BOXCOUNT = BOXCOUNT;
            else
                
                BOXCOUNT = BOXCOUNT +1;
            end
              
         end
   end
    
    
end
