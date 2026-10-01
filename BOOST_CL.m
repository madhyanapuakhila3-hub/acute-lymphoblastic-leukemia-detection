clc
clear all
load ('C:\A\GLCM.mat');
load ('C:\A\COLOR.mat');
load ('C:\A\SHAPE.mat');
load ('C:\A\BOXCOUNT.mat');

datafeatures=[COLOR.MEAN; COLOR.STANDARDDEVIATION; COLOR.ENTROPHY; BOXCOUNT];
 
  angle=rand(4,1)*2*pi; l=rand(4,1)*40+30; blue=[sin(angle).*l cos(angle).*l];
  angle=rand(4,1)*2*pi; l=rand(4,1)*40;    red=[sin(angle).*l cos(angle).*l];
size(blue)
size(red)
 % All the training data
  datafeatures=[blue;red];
  size(datafeatures)
  dataclass(1:4)=-1; dataclass(5:8)=1;
 size(dataclass)
 figure, subplot(2,2,1), hold on; axis equal;
  plot(blue(:,1),blue(:,2),'b.'); plot(red(:,1),red(:,2),'r.');
  title('Training Data');
  
 % Use Adaboost to make a classifier
  [classestimate,model]=adaboost('train',datafeatures,dataclass,50);

 % Training results
 % Show results
  blue=datafeatures(classestimate==-1,:); red=datafeatures(classestimate==1,:);
  I=zeros(161,161);
  for i=1:length(model)
      if(model(i).dimension==1)
          if(model(i).direction==1), rec=[-80 -80 80+model(i).threshold 160];
          else rec=[model(i).threshold -80 80-model(i).threshold 160 ];
          end
      else
          if(model(i).direction==1), rec=[-80 -80 160 80+model(i).threshold];
          else rec=[-80 model(i).threshold 160 80-model(i).threshold];
          end
      end
      rec=round(rec);
      y=rec(1)+81:rec(1)+81+rec(3); x=rec(2)+81:rec(2)+81+rec(4);
      I=I-model(i).alpha; I(x,y)=I(x,y)+2*model(i).alpha;    
  end
 subplot(2,2,2), imshow(I,[]); colorbar; axis xy;
 colormap('jet'), hold on
 plot(blue(:,1)+81,blue(:,2)+81,'bo');
 plot(red(:,1)+81,red(:,2)+81,'ro');
 title('Training Data classified with adaboost model');

 % Show the error verus number of weak classifiers
 error=zeros(1,length(model)); for i=1:length(model), error(i)=model(i).error; end 
 subplot(2,2,3), plot(error); title('Classification error versus number of weak classifiers');

 % Make some test data
  angle=rand(200,1)*2*pi; l=rand(200,1)*70; testdata=[sin(angle).*l cos(angle).*l];

 % Classify the testdata with the trained model
  testclass=adaboost('apply',testdata,model);

 % Show result
  blue=testdata(testclass==-1,:); red=testdata(testclass==1,:);

 % Show the data
  subplot(2,2,4), hold on
  plot(blue(:,1),blue(:,2),'b*');
  plot(red(:,1),red(:,2),'r*');
  axis equal;
  title('Test Data classified with adaboost model');