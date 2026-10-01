function varargout = MAINGUI(varargin)
% MAINGUI MATLAB code for MAINGUI.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MAINGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MAINGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MAINGUI

% Last Modified by GUIDE v2.5 03-Mar-2026 12:56:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MAINGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MAINGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MAINGUI is made visible.
function MAINGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MAINGUI (see VARARGIN)

% Choose default command line output for MAINGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MAINGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MAINGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputimage = imread('normal3.jpg');  %% image read operation
inputimage = imresize((inputimage),[256 256]);%% image resizing any size into 250x250
imwrite(inputimage,'C:\A\input.jpg');

imshow(inputimage), title('INPUT CELL IMAGE');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%function cmyk = rgb2cmyk(rgb)
    % Convert RGB (0-255) to CMYK (0-1)
rgb = imread('C:\A\input.jpg');
chobound(rgb);
    rgb = double(rgb) / 255;   % Normalize to [0,1]

    R = rgb(:,:,1);
    G = rgb(:,:,2);
    B = rgb(:,:,3);

    K = 1 - max(max(R, G), B);

    C = (1 - R - K) ./ (1 - K);
    M = (1 - G - K) ./ (1 - K);
    Y = (1 - B - K) ./ (1 - K);

    % Handle division by zero (when K = 1)
    C(K == 1) = 0;
    M(K == 1) = 0;
    Y(K == 1) = 0;

    cmyk = cat(3, C, M, Y, K);

imshow(C,[]), title('C component image');

 

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb = imread('C:\A\input.jpg');

    rgb = double(rgb) / 255;   % Normalize to [0,1]

    R = rgb(:,:,1);
    G = rgb(:,:,2);
    B = rgb(:,:,3);

    K = 1 - max(max(R, G), B);

    C = (1 - R - K) ./ (1 - K);
    M = (1 - G - K) ./ (1 - K);
    Y = (1 - B - K) ./ (1 - K);

    % Handle division by zero (when K = 1)
    C(K == 1) = 0;
    M(K == 1) = 0;
    Y(K == 1) = 0;

    cmyk = cat(3, C, M, Y, K);

imshow(M,[]), title('M component image');

 
 

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb = imread('C:\A\input.jpg');

    rgb = double(rgb) / 255;   % Normalize to [0,1]

    R = rgb(:,:,1);
    G = rgb(:,:,2);
    B = rgb(:,:,3);

    K = 1 - max(max(R, G), B);

    C = (1 - R - K) ./ (1 - K);
    M = (1 - G - K) ./ (1 - K);
    Y = (1 - B - K) ./ (1 - K);

    % Handle division by zero (when K = 1)
    C(K == 1) = 0;
    M(K == 1) = 0;
    Y(K == 1) = 0;

    cmyk = cat(3, C, M, Y, K);

imshow(Y,[]), title('Y component image');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb = imread('C:\A\input.jpg');

    rgb = double(rgb) / 255;   % Normalize to [0,1]

    R = rgb(:,:,1);
    G = rgb(:,:,2);
    B = rgb(:,:,3);

    K = 1 - max(max(R, G), B);

    C = (1 - R - K) ./ (1 - K);
    M = (1 - G - K) ./ (1 - K);
    Y = (1 - B - K) ./ (1 - K);

    % Handle division by zero (when K = 1)
    C(K == 1) = 0;
    M(K == 1) = 0;
    Y(K == 1) = 0;

    cmyk = cat(3, C, M, Y, K);

 imshow(C,[]), title('C component Extraction');
 
 imwrite(C,'C:\A\Cout.jpg');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputimage = imread('image.jpg');  %% image read operation
inputimage = imresize((inputimage),[256 256]);%% image resizing any size into 250x250
 
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


nColors = 3;
[nrows ncols cc] =size(inputimage);
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);            %%%% Kmeans clustering
                                  pixel_labels = reshape(cluster_idx,nrows,ncols); %%%% clustering group index

segmented_images = cell(1,3); %%%%  segemented clusters
rgb_label = repmat(pixel_labels,[1 1 3]);%%%%  segemented regions into RGB image

for k = 1:nColors%%%% possible colors in  segemented RGB image
    color = inputimage;
    color(rgb_label ~= k) = 0;%%%% removal unintented  colors in  segemented RGB image
    segmented_images{k} = color;%%%% selection of intented  colors in  segemented RGB image
end

% %%%%%%%%%%%%%%%%
mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value); %%sorted out cluster groups
blue_cluster_num = idx(1);  %% seperate blue region from cluster groups

L = inputimage(:,:,1);
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

 


BOXCOUNT =  BOXCOUNTING(img);
  
M   =SHAPEEXTRACTION (img);


 
 
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
imshow (LTP_upper_image,[]);
title('LTP upper image output image')
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputimage = imread('image.jpg');  %% image read operation
inputimage = imresize((inputimage),[256 256]);%% image resizing any size into 250x250
 
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


nColors = 3;
[nrows ncols cc] =size(inputimage);
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);            %%%% Kmeans clustering
                                  pixel_labels = reshape(cluster_idx,nrows,ncols); %%%% clustering group index

segmented_images = cell(1,3); %%%%  segemented clusters
rgb_label = repmat(pixel_labels,[1 1 3]);%%%%  segemented regions into RGB image

for k = 1:nColors%%%% possible colors in  segemented RGB image
    color = inputimage;
    color(rgb_label ~= k) = 0;%%%% removal unintented  colors in  segemented RGB image
    segmented_images{k} = color;%%%% selection of intented  colors in  segemented RGB image
end

% %%%%%%%%%%%%%%%%
mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value); %%sorted out cluster groups
blue_cluster_num = idx(1);  %% seperate blue region from cluster groups

L = inputimage(:,:,1);
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

 


BOXCOUNT =  BOXCOUNTING(img);
  
M   =SHAPEEXTRACTION (img);


 
 
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
imshow (LTP_lower_image,[]);
title('LTP lower image output image')

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I=imread('C:\A\ROI.jpg');
Igray=rgb2gray(I);


offsets = [0 1;-1 1;-1 0;-1 -1];
value = graycomatrix(Igray,'numlevels', 8, 'G',[],'Offset',[0 1]);
value1 = graycomatrix(Igray,'numlevels', 8, 'G',[],'Offset',[-1 1]);
value2 = graycomatrix(Igray,'numlevels', 8, 'G',[],'Offset',[-1 0]);
value3 = graycomatrix(Igray,'numlevels', 8, 'G',[],'Offset',[-1 -1]);
value = (value+transpose(value)) ;
value1 = (value1+transpose(value1));
value2 = (value2+transpose(value2));
value3 = (value3+transpose(value3));
abc = round((value + value1 + value2+ value3)/4);

 IN.contrast =struct2array( graycoprops(abc,{'contrast'}));
 IN.homogeneity =struct2array(  graycoprops(abc,{'homogeneity'}));
 IN.energy  = struct2array( graycoprops(abc,{'energy'}));
 IN.homogeneity =struct2array(  graycoprops(abc,{'Correlation'})); 
save ('C:\A\GLCM.mat','IN');
disp('GLCM textual features are successfully loaded in the library for classifications')
disp(IN)
 
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=imread('C:\A\ROI.jpg');
Igray=rgb2gray(I);

level = graythresh(Igray);
BW = imbinarize(Igray, level);
[y, x] = find(BW);   % Get row (y) and column (x) of foreground pixels
numPoints = length(x);

% Optional: Combine into Nx2 array
points = [x, y];

intensity = Igray(sub2ind(size(Igray), y, x));

% Combine coordinates + intensity
features = [x, y, intensity];
[Gx, Gy] = imgradientxy(Igray);
[Gmag, Gdir] = imgradient(Gx, Gy);

% Gradient magnitude & direction for foreground pixels
gradMag = Gmag(sub2ind(size(Igray), y, x));
gradDir = Gdir(sub2ind(size(Igray), y, x));

% Combine all features
features = [x, y, intensity, gradMag, gradDir];

 

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputimage = imread('image.jpg');  %% image read operation
inputimage = imresize((inputimage),[256 256]);%% image resizing any size into 250x250
 
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


nColors = 3;
[nrows ncols cc] =size(inputimage);
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);            %%%% Kmeans clustering
                                  pixel_labels = reshape(cluster_idx,nrows,ncols); %%%% clustering group index

segmented_images = cell(1,3); %%%%  segemented clusters
rgb_label = repmat(pixel_labels,[1 1 3]);%%%%  segemented regions into RGB image

for k = 1:nColors%%%% possible colors in  segemented RGB image
    color = inputimage;
    color(rgb_label ~= k) = 0;%%%% removal unintented  colors in  segemented RGB image
    segmented_images{k} = color;%%%% selection of intented  colors in  segemented RGB image
end

% %%%%%%%%%%%%%%%%
mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value); %%sorted out cluster groups
blue_cluster_num = idx(1);  %% seperate blue region from cluster groups

L = inputimage(:,:,1);
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

 


BOXCOUNT =  BOXCOUNTING(img);
 
save ('C:\TEMP\BOXCOUNT.mat','BOXCOUNT');
disp('BOXCOUNTs are successfully loaded in the library for classifications')
disp(BOXCOUNT)
M   =SHAPEEXTRACTION (img);


 
 
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

COLOR.ENTROPHY=( max(R(:)) );
fun = @(block_struct) MEAN(block_struct.data);

RMEAN_OUT = blockproc(R,[8 8],fun);
GMEAN_OUT = blockproc(G,[8 8],fun);
BMEAN_OUT = blockproc(B,[8 8],fun);
 
PLOT_OUT=cat(3,RMEAN_OUT,RMEAN_OUT,RMEAN_OUT);

 

COLOR.MEAN=sum(BMEAN_OUT(:));
 
% 

ein = imresize((SEGMENTED_CELL_IMAGE),[270 270]);

R=ein(:,:,1);
G=ein(:,:,2);
B=ein(:,:,3);

fun = @(block_struct) ST(block_struct.data);

RST_OUT = blockproc(R,[3 3],fun);
GST_OUT = blockproc(G,[3 3],fun);
BST_OUT = blockproc(B,[3 3],fun);
 
PLOT_OUT=cat(3,RST_OUT,RST_OUT,RST_OUT);
COLOR.STANDARDDEVIATION=sum(BST_OUT(:));

 
 

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

 IN.contrast =struct2array( graycoprops(abc,{'contrast'}));
 IN.homogeneity =struct2array(  graycoprops(abc,{'homogeneity'}));
 IN.energy  = struct2array( graycoprops(abc,{'energy'}));
 IN.homogeneity =struct2array(  graycoprops(abc,{'Correlation'})); 

imshow (LTP_upper_image,[]);
title('LTP upper image output image')


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=imread('C:\A\ROI.jpg');
Igray=rgb2gray(I);
 

M   =SHAPEEXTRACTION (Igray);


save ('C:\A\SHAPE.mat','M');
disp('SHAPE features are successfully loaded in the library for classifications')

 
% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UNKNOWNCLASSIFY


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb = imread('C:\A\input.jpg');

    rgb = double(rgb) / 255;   % Normalize to [0,1]

    R = rgb(:,:,1);
    G = rgb(:,:,2);
    B = rgb(:,:,3);

    K = 1 - max(max(R, G), B);

    C = (1 - R - K) ./ (1 - K);
    M = (1 - G - K) ./ (1 - K);
    Y = (1 - B - K) ./ (1 - K);

    % Handle division by zero (when K = 1)
    C(K == 1) = 0;
    M(K == 1) = 0;
    Y(K == 1) = 0;

    cmyk = cat(3, C, M, Y, K);

imshow(K,[]), title('K component image');


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Compute Otsu threshold (normalized 0–1)

I=imread('C:\A\Cout.jpg');
level = graythresh(I);

% Apply threshold
BW = imbinarize(I, level);

imshow(BW);
title('Otsu Thresholding Result');
imwrite(BW,'C:\A\BW.jpg');


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BW=imread('C:\A\BW.jpg');

% Create structuring element
se = strel('disk', 5);   % radius = 5

% Apply morphological opening
BW_open = imopen(BW, se);

imwrite(BW,'C:\A\pmeasure.jpg');

imshowpair(BW, BW_open, 'montage');
title('Original (Left) vs Opened (Right)');


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Ensure logical
BW=imread('C:\A\BW.jpg');
BW = logical(BW);

% Label connected components
CC = bwconncomp(BW);

% Measure component sizes
numPixels = cellfun(@numel, CC.PixelIdxList);

% Find largest component
[~, idx] = max(numPixels);

% Create output image
BW_clean = false(size(BW));
BW_clean(CC.PixelIdxList{idx}) = true;

% Display
imshowpair(BW, BW_clean, 'montage');
title('Original (Left) vs Largest Component (Right)');


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Remove small objects (optional cleanup)

I=imread('C:\A\input.jpg');

I1=imread('C:\A\BW.jpg');

BW = bwareaopen(I1, 50);

% Label connected components
CC = bwconncomp(BW);

% Measure properties
stats = regionprops(CC, 'Centroid', 'EquivDiameter');

% Extract diameters
diameters = [stats.EquivDiameter];

% Find maximum diameter
[~, idx] = max(diameters);

% Get centroid and radius
center = stats(idx).Centroid;
radius = stats(idx).EquivDiameter / 2;

% Display image
imshow(I);
hold on;

% Draw circle
viscircles(center, radius, 'EdgeColor', 'r', 'LineWidth', 2);

title('Maximum Diameter Cell');
hold off;


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I=imread('C:\A\input.jpg');

I1=imread('C:\A\BW.jpg');

BW = bwareaopen(I1, 50);

% Label connected components
CC = bwconncomp(BW);

% Measure properties
stats = regionprops(CC, 'Centroid', 'EquivDiameter','BoundingBox');

% Extract diameters
diameters = [stats.EquivDiameter];

% Find maximum diameter
[~, idx] = max(diameters);

% Get centroid and radius
center = stats(idx).Centroid;
radius = stats(idx).EquivDiameter / 2;
bbox = stats(idx).BoundingBox;


% Display image
imshow(I);
hold on;

% Draw circle
viscircles(center, radius, 'EdgeColor', 'r', 'LineWidth', 2);

title('Maximum Diameter Cell');
hold on;
% Draw bounding box
rectangle('Position', bbox, ...
    'EdgeColor', 'g', ...
    'LineWidth', 2);

title('Maximum Diameter Cell with Circle & Bounding Box');
hold off;


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I=imread('C:\A\input.jpg');

I1=imread('C:\A\BW.jpg');

BW = bwareaopen(I1, 50);

% Label connected components
CC = bwconncomp(BW);

% Measure properties
stats = regionprops(CC, 'Centroid', 'EquivDiameter','BoundingBox');

% Extract diameters
diameters = [stats.EquivDiameter];

% Find maximum diameter
[~, idx] = max(diameters);

% Get centroid and radius
center = stats(idx).Centroid;
radius = stats(idx).EquivDiameter / 2;
bbox = stats(idx).BoundingBox;


% Extract ROI
ROI = imcrop(I, bbox);


imshow(ROI);
imwrite(ROI,'C:\A\ROI.jpg');
title('Extracted ROI from Bounding Box');


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = imread('C:\A\ROI.jpg');

% Convert to grayscale if RGB
if size(I,3) == 3
    Igray = rgb2gray(I);
else
    Igray = I;
end

% Otsu threshold
level = graythresh(Igray);
BW = imbinarize(Igray, level);

% Remove small noise
BW = bwareaopen(BW, 50);

% Foreground = 1 (cell)
% Background = 0 (others)

imshow(BW);
title('Cell = Foreground (White), Background = Black');
imwrite(BW,'C:\A\FINALROI.jpg');


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [filename, pathname] = uigetfile('.bmp;*.tiff;*.jpg;*.pgm','Pick an M-file');
img = imread(filename);
%im1=imread('test/BAS___BAS_0001_0_8415_102.tiff');
% im2=imread('EBO___EBO_0003_0_7954_110.tiff');
% im3=imread('EOS___EOS_0012_110.tiff');
% im4=imread('KSC___KSC_0001_0_6048_102.tiff');
% im5=imread('LYA___LYA_0001_0_7728_108.tiff');
% im6=imread('LYT___LYT_0231_101.tiff');
% im7=imread('MMZ___MMZ_0001_0_625_107.tiff');
% im8=imread('NGS___NGS_0363_101.tiff');
% im9=imread('MOB___MOB_0002_0_2662_109.tiff');
% im10=imread('MON___MON_0030_103.tiff');
% im11=imread('MYB___MYB_0001_0_5339_104.tiff');
% im12=imread('MYO___MYO_0203_107.tiff');
% im13=imread('NGB___NGB_0003_0_6588_109.tiff');
% im14=imread('PMB___PMB_0001_0_96_109.tiff');
% im15=imread('PMO___PMO_0003_0_7954_103.tiff');
[M1,im1_out]=ANALYZES_DETECTION(img);
disp('WBC cell is detected successfully')

% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SEGMENTED_CELL_IMAGE=imread('C:\A\pmeasure.jpg');
d=imread('C:\A\Cout.jpg');  
 

% Otsu threshold
level = graythresh(d);
d = imbinarize(d, level);

% Remove small noise
d = bwareaopen(d, 50);

imshow(SEGMENTED_CELL_IMAGE)
l=2;

TP=0;
FP=0;
TN=0;
FN=0;
 for i=1:256,
        
       for j=1:256,
           
           if SEGMENTED_CELL_IMAGE(i,j,:)~=0 
               if d(i,j)~=0
                TP=TP+1;
               end
           end
           if SEGMENTED_CELL_IMAGE(i,j,:)==0 
               if   d(i,j)~=0
               FP=FP+1;
               end
           end
               
           if SEGMENTED_CELL_IMAGE(i,j,:)==0 
               if d(i,j)==0
               TN=TN+1;
               end
           end
           if  SEGMENTED_CELL_IMAGE(i,j,:)~=0  
               if d(i,j)==0
               FN=FN+1;
               end
           end
           end
 end
 

 sensitivity= l*TP/(TP+FN); 
 accuracy = (TP + TN) / (TP + FN + TN + FP); 
 precision  = TP/(TP+FP); 
 specifity= TN/(TN+FP); 
 
 F1_score=2* precision*sensitivity/(precision+sensitivity); 
 AUC= (precision+sensitivity)/2;
 IoU=l*TP/(TP + FN +  FP); 
  disp('sensitivity') 
  disp(sensitivity)
   disp('precision') 
 disp(precision) 
  disp('accuracy')
 disp(accuracy)
  disp('specifity')
 disp(specifity)
  disp('F1_score')
 disp(F1_score)
  disp('AUC')
 disp(AUC)
  disp('IoU')
 disp(IoU)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BOOST_CL
