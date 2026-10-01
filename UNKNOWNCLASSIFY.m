


 [filename, pathname] = uigetfile('*.bmp;*.tif;*.jpg;*.pgm','Pick an M-file');
inputimage = imread(filename);
 
inputimage = imresize((inputimage),[256 256]);%% image resizing any size into 250x250
 
imshow(inputimage), title('INPUT CELL IMAGE');
an=1;
a_component=[];       % initialize a component

bn=1;
b_component=[];       % initialize b component

R = inputimage(:,:,1);  % R  component
G = inputimage(:,:,2);  % G  component
B = inputimage(:,:,3);  % B  component

if max(max(R)) > 1.0 || max(max(G)) > 1.0 || max(max(B)) > 1.0
  R = double(R) / 255; 
  G = double(G) / 255;
  B = double(B) / 255;
end

% Set a threshold
T = 0.008856;

[M, N] = size(R);   %%%% rows & column 
s = M * N;           %%%% total number of pixels
RGB = [reshape(R,1,s); reshape(G,1,s); reshape(B,1,s)]; %%%% RGB image in vector form

% RGB to XYZ
MAT = [0.412453 0.357580 0.180423;
       0.212671 0.715160 0.072169;
       0.019334 0.119193 0.950227];%%%% L a b coefficients values
XYZ = MAT * RGB;

X = XYZ(1,:) / 0.950456;  %%%% X norm values
Y = XYZ(2,:);              %%%% Y norm values
Z = XYZ(3,:) / 1.088754;  %%%% Z  norm values
 
XT = X > T;   %%%% X thresholding value
YT = Y > T;   %%%% Y thresholding value
ZT = Z > T;    %%%% Z thresholding value

Y3 = Y.^(1/3); 

fX = XT .* X.^(1/3) + (~XT) .* (7.787 .* X + 16/116);
fY = YT .* Y3 + (~YT) .* (7.787 .* Y + 16/116);
fZ = ZT .* Z.^(1/3) + (~ZT) .* (7.787 .* Z + 16/116);

a=[];
b=[];

L = reshape(YT .* (116 * Y3 - 16.0) + (~YT) .* (903.3 * Y), M, N);  %%%% L vector --> matrix form
a = reshape(500 * (fX - fY), M, N);                                  %%%% a vector --> matrix form
b = reshape(200 * (fY - fZ), M, N);                                  %%%% b vector --> matrix form
SAMPLE(inputimage);
for i=1:256,
        
       for j=1:256,
             
             a_component(an,1)=a(i,j);                              %%%% a vector decomposition
             an=an+1;
             
         end
end
    


for i=1:256,
        
       for j=1:256,
             
             b_component(bn,1)=b(i,j);                           %%%% b vector decomposition
             bn=bn+1;
             
         end
    end
ab= [a_component b_component];  %%%% ab  vector concatenation


nCNNs = 3;
[nrows ncols cc] =size(inputimage);
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nCNNs,'distance','sqEuclidean', ...
                                      'Replicates',3);            %%%% Kmeans clustering
                                  pixel_labels = reshape(cluster_idx,nrows,ncols); %%%% clustering group index

segmented_images = cell(1,3); %%%%  segemented clusters
rgb_label = repmat(pixel_labels,[1 1 3]);%%%%  segemented regions into RGB image

for k = 1:nCNNs%%%% possible CNNs in  segemented RGB image
    CNN = inputimage;
    CNN(rgb_label ~= k) = 0;%%%% removal unintented  CNNs in  segemented RGB image
    segmented_images{k} = CNN;%%%% selection of intented  CNNs in  segemented RGB image
end

% %%%%%%%%%%%%%%%%
mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value); %%sorted out cluster groups
blue_cluster_num = idx(1);  %% seperate blue region from cluster groups

L = inputimage(:,:,3);
blue_idx = find(pixel_labels == blue_cluster_num); %%seperation blue labels from input pixel lables,
L_blue = L(blue_idx);
is_light_blue = im2bw(L_blue,graythresh(L_blue)); %%seperation blue labels with thresholding,
blood_cell_labels = repmat(uint8(0),[nrows ncols]);
blood_cell_labels(blue_idx(is_light_blue==false)) = 1;%%condition check
blood_cell_labels = repmat(blood_cell_labels,[1 1 3]);
SEGMENTED_CELL_IMAGE = inputimage;
SEGMENTED_CELL_IMAGE(blood_cell_labels ~= 1) = 0;
 
 
img = imresize((SEGMENTED_CELL_IMAGE),[250 250]);
[ row col p ] =size(img);

%%%%%%%%%%%%%%%%%%%%%%%%BOX COUNTING%%%%%%%%%%%%%%%%%%
  
if p == 3
    img = rgb2gray(img);
end

UNKNOWNBOXCOUNT =  BOXCOUNTING(img);

UNKNOWNM   =SHAPEEXTRACTION (img);

 
oneblk=[]; 
modified_input_image=zeros(size(img)+2);  %%%% zero padding in boundries
LBP_image_rotational_inv=[];               %%%% MATRIX initialization
LTP_upper_image=[];
LTP_lower_image=[];
Uniform_LBP =[];
LBP_image = [];
        for x=1:size(img,1)
            for y=1:size(img,2)
                modified_input_image(x+1,y+1)=img(x,y); %%%% MATRIX modification for LBP
            end
        end
for i= 1:size(modified_input_image,1)-2     %%%% MACRO BLOCK boundry seperation
    for j=1:size(modified_input_image,2)-2  %%%% MACRO BLOCK boundry seperation
          for x=1:3
            for y=1:3
                oneblock(x,y)=modified_input_image(i+x-1,j+y-1);   %%%% MACRO BLOCK CONVERSION             
            end
          end
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%%  LBP boundry comparison with centre pixel%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          centre_pixel= oneblock(2,2);  %% centre pixel (2,2)    % * (1,1) (1,2) (1,3) 
          pixel0=oneblock(1,1) > centre_pixel;                   % * (2,1) (2,2) (2,3)     
          pixel1=oneblock(1,2) > centre_pixel;                   % * (3,1) (3,2) (3,3) 
          pixel2=oneblock(1,3) > centre_pixel;
          pixel3=oneblock(2,3) > centre_pixel;
          pixel4=oneblock(3,3) > centre_pixel;
          pixel5=oneblock(3,2) > centre_pixel;              
          pixel6=oneblock(3,1) > centre_pixel;
          pixel7=oneblock(2,1) > centre_pixel;
          
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%%  pattern generation with pixel weightages%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
          pixel_out = pixel0 * 128 + pixel1 * 64 + pixel2 * 32 + pixel3 * 16 + pixel4 * 8 + pixel5 * 4 + pixel6 * 2 + pixel7 * 1;
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%%  LBB image%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          LBP_image(i,j)=pixel_out;
          
          
          %%%%%%%%%%%%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%%  all possible pattren from LBP%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          P0=[pixel0 pixel1 pixel2 pixel3 pixel4 pixel5 pixel6 pixel7];%%%%%% 0 degree
          P1=[pixel7 pixel0 pixel1 pixel2 pixel3 pixel4 pixel5 pixel6];%%%%%% 45 degree
          P2=[pixel6 pixel7 pixel0 pixel1 pixel2 pixel3 pixel4 pixel5];%%%%%% 90 degree
          P3=[pixel5 pixel6 pixel7 pixel0 pixel1 pixel2 pixel3 pixel4];%%%%%% 135 degree
          P4=[pixel4 pixel5 pixel6 pixel7 pixel0 pixel1 pixel2 pixel3];%%%%%% 180 degree
          P5=[pixel3 pixel4 pixel5 pixel6 pixel7 pixel0 pixel1 pixel2];%%%%%% 225 degree
          P6=[pixel2 pixel3 pixel4 pixel5 pixel6 pixel7 pixel0 pixel1];%%%%%% 270 degree
          P7=[pixel1 pixel2 pixel3 pixel4 pixel5 pixel6 pixel7 pixel0];%%%%%% 315 degree
          
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%% cocatenation of all * possible pattern with various angles%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          P = [P0, P1, P2, P3, P4, P5, P6, P7];
          LBP_image_rotational_inv(i,j)=min(P);  %%%%minimum va;ue of possible pattern with various angles%%%%%%%%%%%
          
          %%%%%%%%%%%%%%%%%%%%%%%
          
          databinary_value(1,1:8)=de2bi(pixel_out,8,'left-msb')'; %%%%decimal into binary conversions%%%%%%%%%%%
          
        %%%% bit level transistion%%%%%%%%%%%
          xor1 = bitxor(databinary_value(1,1),databinary_value(1,2));
          xor2 = bitxor(databinary_value(1,2),databinary_value(1,3));
          xor3 = bitxor(databinary_value(1,3),databinary_value(1,4));
          xor4 = bitxor(databinary_value(1,4),databinary_value(1,5));
          xor5 = bitxor(databinary_value(1,5),databinary_value(1,6));
          xor6 = bitxor(databinary_value(1,6),databinary_value(1,7));
          xor7 = bitxor(databinary_value(1,7),databinary_value(1,8));
          xor8 = bitxor(databinary_value(1,8),databinary_value(1,1));
          xorout  =[xor1 xor2 xor3 xor4 xor5 xor6 xor7 xor8];
          
          n=0;
          for m=1:8,
              if xorout(1,m) == 1,  %%%% bit level transistion occurance %%%%%%%%%%%
                  n=n+1;            %%%% bit level transistion count %%%%%%%%%%%
              else
                  n=n;
              end
          end
          
          if n <= 2  %%%% bit level transistion count lesser than two  %%%%%%%%%%%
              Uniform_LBP(i,j)=pixel_out;
          else
              Uniform_LBP(i,j)=0; %%%% bit level transistion count greater  than two  %%%%%%%%%%%
          end
               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
          %%%%%%%%% UPPER & LOWER  LTP with threshold value 5   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          if oneblock(1,1) - centre_pixel >= 5   
              pixel_u1 = 1;
              pixel_l1 = 1;
          elseif abs(oneblock(1,1) - centre_pixel) < 5
              pixel_u1 = 0;
              pixel_l1 = 0;
          else
              pixel_u1 = 0;
              pixel_l1 = 1;
          end
          if oneblock(1,2) - centre_pixel >= 5
              pixel_u2 = 1;
              pixel_l2 = 1;
          elseif abs(oneblock(1,2) - centre_pixel) < 5
              pixel_u2 = 0;
              pixel_l2 = 0;
          else
              pixel_u2 = 0;
              pixel_l2 = 1;
          end
          
          if oneblock(1,3) - centre_pixel >= 5
              pixel_u3 = 1;
              pixel_l3 = 1;
          elseif abs(oneblock(1,3) - centre_pixel) < 5
              pixel_u3 = 0;
              pixel_l3 = 0;
          else
              pixel_u3 = 0;
              pixel_l3 = 1;
          end
          
          if oneblock(2,3) - centre_pixel >= 5
              pixel_u4 = 1;
              pixel_l4 = 1;
          elseif abs(oneblock(2,3) - centre_pixel) < 5
              pixel_u4 = 0;
              pixel_l4 = 0;
          else
              pixel_u4 = 0;
              pixel_l4 = 1;
          end
          
          if oneblock(3,3) - centre_pixel >= 5
              pixel_u5 = 1;
              pixel_l5 = 1;
          elseif abs(oneblock(3,3) - centre_pixel) < 5
              pixel_u5 = 0;
              pixel_l5 = 0;
          else
              pixel_u5 = 0;
              pixel_l5 = 1;
          end
          
          if oneblock(3,2) - centre_pixel >= 5
              pixel_u6 = 1;
              pixel_l6 = 1;
          elseif abs(oneblock(3,2) - centre_pixel) < 5
              pixel_u6 = 0;
              pixel_l6 = 0;
          else
              pixel_u6 = 0;
              pixel_l6 = 1;
          end
          
          if oneblock(3,1) - centre_pixel >= 5
              pixel_u7 = 1;
              pixel_l7 = 1;
          elseif abs(oneblock(3,1) - centre_pixel) < 5
              pixel_u7 = 0;
              pixel_l7 = 0;
          else
              pixel_u7 = 0;
              pixel_l7 = 1;
          end
          
          if oneblock(2,1) - centre_pixel >= 5
              pixel_u8 = 1;
              pixel_l8 = 1;
          elseif abs(oneblock(2,1) - centre_pixel) < 5
              pixel_u8 = 0;
              pixel_l8 = 0;
          else
              pixel_u8 = 0;
              pixel_l8 = 1;
          end
          
          pixel_upper_out = pixel_u1 * 128 + pixel_u2 * 64 + pixel_u3 * 32 + pixel_u4 * 16 + pixel_u5 * 8 + pixel_u6 * 4 + pixel_u7 * 2 + pixel_u8 * 1;
          LTP_upper_image(i,j)=pixel_upper_out;
          
          pixel_lower_out = pixel_l1 * 128 + pixel_l2 * 64 + pixel_l3 * 32 + pixel_l4 * 16 + pixel_l5 * 8 + pixel_l6 * 4 + pixel_l7 * 2 + pixel_l8 * 1;
          LTP_lower_image(i,j)=pixel_lower_out;
          
       
    end
end

SEGMENTED_CELL_IMAGE = imresize((SEGMENTED_CELL_IMAGE),[256 256]);
R=SEGMENTED_CELL_IMAGE(:,:,1);
G=SEGMENTED_CELL_IMAGE(:,:,2);
B=SEGMENTED_CELL_IMAGE(:,:,3);
oneblk=[];

n=1;

RJ=[];
GJ=[];
BJ=[];
PLOT_OUT=[];

RMEAN_OUT=[];
GMEAN_OUT=[];
BMEAN_OUT=[];
 for k=1:1024, % number of blocks
    
   for i=1:8,
        
       for j=1:8,
             
             oneblk1(i,j)=R(n); 
             oneblk2(i,j)=G(n); 
             oneblk3(i,j)=B(n); 
             n=n+1;
             
         end
   end
    RJ = entropy(oneblk1);
     GJ = entropy(oneblk2);
      BJ = entropy(oneblk3);
 end

UNKNOWNCNN.ENTROPHY=sum(BJ(:));
fun = @(block_struct) MEAN(block_struct.data);

RMEAN_OUT = blockproc(R,[8 8],fun);
GMEAN_OUT = blockproc(G,[8 8],fun);
BMEAN_OUT = blockproc(B,[8 8],fun);
 
PLOT_OUT=cat(3,RMEAN_OUT,RMEAN_OUT,RMEAN_OUT);

 

UNKNOWNCNN.MEAN=sum(BMEAN_OUT(:));
 
 

ein = imresize((SEGMENTED_CELL_IMAGE),[270 270]);

R=ein(:,:,1);
G=ein(:,:,2);
B=ein(:,:,3);

fun = @(block_struct) ST(block_struct.data);

RST_OUT = blockproc(R,[3 3],fun);
GST_OUT = blockproc(G,[3 3],fun);
BST_OUT = blockproc(B,[3 3],fun);
 
PLOT_OUT=cat(3,RST_OUT,RST_OUT,RST_OUT);
UNKNOWNCNN.STANDARDDEVIATION=sum(BST_OUT(:));
  
%%%%%%%%%%%%%%%%%%%%%%%%
ein = imresize((SEGMENTED_CELL_IMAGE),[270 270]);

R=ein(:,:,1);
G=ein(:,:,2);
B=ein(:,:,3);

fun = @(block_struct) ENERGY(block_struct.data);

RENERGY_OUT = blockproc(R,[3 3],fun);
GENERGY_OUT = blockproc(G,[3 3],fun);
BENERGY_OUT = blockproc(B,[3 3],fun);
 
PLOT_OUT=cat(3,RENERGY_OUT,RENERGY_OUT,RENERGY_OUT);

  
offsets = [0 1;-1 1;-1 0;-1 -1];
value = graycomatrix(LBP_image,'numlevels', 8, 'G',[],'Offset',[0 1]);
value1 = graycomatrix(LBP_image,'numlevels', 8, 'G',[],'Offset',[-1 1]);
value2 = graycomatrix(LBP_image,'numlevels', 8, 'G',[],'Offset',[-1 0]);
value3 = graycomatrix(LBP_image,'numlevels', 8, 'G',[],'Offset',[-1 -1]);
value = (value+transpose(value)) ;
value1 = (value1+transpose(value1));
value2 = (value2+transpose(value2));
value3 = (value3+transpose(value3));
 abc = round((value + value1 + value2+ value3)/4);
 UNKNOWNcontrast =struct2array( graycoprops(abc,{'contrast'}));
 UNKNOWNhomogeneity =struct2array(  graycoprops(abc,{'homogeneity'}));
 UNKNOWNenergy  = struct2array( graycoprops(abc,{'energy'}));
 UNKNOWNhomogeneity =struct2array(  graycoprops(abc,{'Correlation'})); 
 
datafeatures1=[UNKNOWNCNN.ENTROPHY; UNKNOWNBOXCOUNT];
datafeatures2=[UNKNOWNcontrast; UNKNOWNhomogeneity; UNKNOWNenergy; UNKNOWNhomogeneity];

tarinset1=[CNN.MEAN; BOXCOUNT];
tarinset2=[IN.contrast; IN.homogeneity; IN.energy; IN.homogeneity];

CELL.group='AML DETECTION';
  dataclass(1:4)=-1; dataclass(5:8)=1;
itt=50;
 
svmStruct = svmtrain(tarinset1(:),datafeatures1(:),'showplot',true);
disp(svmStruct.ScaleData)
C = svmclassify(svmStruct,datafeatures1(:),'showplot',true);
errRate = sum(Y(datafeatures1(:)~= C));  %mis-classification rate
conMat = confusionmat(datafeatures1(:),C) ;% the confusion matrix
if datafeatures1(1,1) == 0
    disp(CELL.group)
else
    disp('DECTECTION FAILED')
end