# Manual Segmentation
Graphical interface to carry on the manual segmentation of the Emg signals recorded. Compatible with the latest Data Acquisition version.

## Important Notes
Remember, the Data Acquisition Software generates a unique folder for each user. Whereas the Manual Segmentation Software gathers together all the segmentations of all users in a *.mat* file.

# Getting Started Instructions
1. First of all, you must have recorded some data using the [Data Acquisition Software](https://github.com/laboratorioAI/dataAcquisition).
1. Copy all the folders inside **/data/** of your downloaded Data Acquisition repository.
1. Paste those recolected signals in the folder **/data/** of this repository.
1. Check in the **configs/getParams.m** file that the configuration parameters (such as num of repetitions per gesture) are up to date and correspond to your data recording setup.

# Execution
1. Follow the getting started instructions and then just run **ejecutar.m**.

# Exporting the segmentation indexes
1. Copy the content of the folder **/matFiles/** to the Anonimizator software.
