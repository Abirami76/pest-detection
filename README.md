# 🐞Pest Detection Using MATLAB

This repository contains a MATLAB-based application for pest detection using image classification techniques. The project aims to assist farmers and agricultural researchers in identifying pests accurately to promote healthier crops and sustainable farming practices.

## 🔍Project Overview

Our pest detection system utilizes:
- **MATLAB Deep Network Designer:** For training a deep learning model using the SqueezeNet architecture.
- **Image Classification:** The model classifies uploaded pest images and predicts the pest type with a labeled output.

## ⭐Features
- **User-Friendly Interface:** A MATLAB-based app with a simple GUI for uploading and detecting pests.
- **Pre-trained Model Integration:** The system uses a trained model generated using the SqueezeNet architecture.
- **Fast Image Processing:** Provides quick pest detection results with a loading screen for better user experience.

## 🧐How It Works
1. **Upload Image:** Select and upload a pest image from your device.
2. **Detect Button:** Click the 'Detect' button.
3. **Processing:** The app displays a loading screen while the model processes the image.
4. **Result:** The detected pest type is displayed with a label.

## 🗃️Project Structure
```
📁 Pest-Detection-Project
├── 📂 datasets/               # Contains the pest image dataset used for training
├── 📂 trained_model/         # Contains the trained SqueezeNet model (.mat file)
├── 📂 GUI/                   # MATLAB app files for the graphical interface
├── 📄 pest_detection.m       # Main script for loading the model and running the app
├── 📄 params_2023_12_25.mat  # Trained model parameters
├── 📄 README.md              # Project documentation
```

## ‼️Requirements
- MATLAB R2021a or later
- Deep Learning Toolbox
- Image Processing Toolbox

## 📍Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/pest-detection-matlab.git
   ```
2. Open MATLAB and navigate to the project directory.
3. Load the trained model using:
   ```matlab
   load('params_2023_12_25.mat');
   ```
4. Run the main script:
   ```matlab
   pest_detection
   ```

## ✌🏼Contributing
Feel free to contribute by forking the repository and submitting pull requests.

## 🪪License
This project is licensed under the MIT License.
