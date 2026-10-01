\# Acute Lymphoblastic Leukemia Detection



A MATLAB-based academic project for detecting Acute Lymphoblastic Leukemia (ALL) from blood smear images using image processing and machine learning techniques.



\## Project Overview



Acute Lymphoblastic Leukemia (ALL) is a type of blood cancer that affects white blood cells.



This project focuses on processing blood smear images, extracting relevant image features, and performing classification to assist in leukemia-related cell detection.



The project includes image preprocessing, segmentation, feature extraction, classification, and a MATLAB-based graphical user interface.



\## Objectives



\- Process blood smear images.

\- Preprocess input images.

\- Segment relevant cell regions.

\- Extract image-based features.

\- Perform classification of cell images.

\- Provide detection results through a MATLAB GUI.



\## Technologies Used



\- MATLAB

\- Image Processing

\- Machine Learning

\- MATLAB GUI

\- Support Vector Machine (SVM)

\- AdaBoost

\- GLCM-based texture analysis



\## Project Workflow



```text

Input Blood Smear Image

&#x20;         ↓

&#x20;  Image Preprocessing

&#x20;         ↓

&#x20;      Segmentation

&#x20;         ↓

&#x20;   Feature Extraction

&#x20;         ↓

&#x20;     Classification

&#x20;         ↓

&#x20;   Detection Result





| File                   | Description                       |

| ---------------------- | --------------------------------- |

| `MAINGUI.m`            | Main MATLAB GUI program           |

| `MAINGUI.fig`          | GUI layout file                   |

| `maincode.m`           | Main processing code              |

| `SHAPEEXTRACTION.m`    | Shape feature extraction          |

| `svmtraining.m`        | SVM-related training code         |

| `adaboost.m`           | AdaBoost-related implementation   |

| `ANALYZES\_DETECTION.m` | Detection analysis                |

| `BOXCOUNTING.m`        | Box-counting related processing   |

| `UNKNOWNCLASSIFY.m`    | Classification of unknown samples |

| `MEAN.m`               | Mean-related processing           |

| `SAMPLE.m`             | Sample processing                 |

| `ST.m`                 | Supporting processing function    |



Features

Image preprocessing

Image segmentation

Cell/region extraction

Texture feature extraction

Shape feature extraction

Machine learning-based classification

MATLAB graphical user interface

How to Run

Requirements

MATLAB

Required MATLAB toolboxes used by the project

Steps

Clone or download this repository.

Open the project folder in MATLAB.

Make sure all required MATLAB files are available in the project directory.

Open MAINGUI.m.

Run the MATLAB GUI.

Provide the required input image.

Perform the detection process.



Note: Some paths in the existing MATLAB code are specific to the original development environment. These paths may need to be updated when running the project on another computer.



Dataset



The complete TIFF image dataset is not included in this repository.



Large TIFF image files and MATLAB autosave files have been excluded from the Git repository.



Some sample image files are included for demonstration purposes.



Project Structure



acute-lymphoblastic-leukemia-detection/

│

├── MAINGUI.m

├── MAINGUI.fig

├── maincode.m

├── ANALYZES\_DETECTION.m

├── SHAPEEXTRACTION.m

├── svmtraining.m

├── adaboost.m

├── UNKNOWNCLASSIFY.m

├── BOXCOUNTING.m

├── MEAN.m

├── SAMPLE.m

├── ST.m

│

├── BOXCOUNT.mat

├── COLOR.mat

├── GLCM.mat

├── SHAPE.mat

│

├── Sample Images

│

├── .gitignore

└── README.md



Academic Project



This project was developed as an academic project to explore image processing and machine learning techniques for leukemia detection from blood smear images.



Author



Akhila Madhyanapu



GitHub: madhyanapuakhila3-hub

