# Multi-contrast-MRI-Image-Registration
EE 4951W Team Project

A joint research effort between researchers at the Harvard Medical School and the University Medical Center Mannheim has developed a method of performing qualitative image registration on images with varying levels of contrast. This solution will be used by students in the Multi-Contrast Image Registration group to build an application that will assist Professor Mehmet Akçakaya in his research. This application was designed with ease of use and efficiency in mind.
Currently image registration is widely used in medical MRI to account for small amounts of movement performed by the patient while the images are being taken. This movement is hard to avoid even in healthy patients who can hold their breath for extended periods and often becomes worse in patients who are older or unhealthy. It is important however for there to be low amounts of movement between images to perform myocardial T1 mapping, which is a method of processing and analyzing MRI images. As such, methods have been developed and widely used for performing corrections to images which align feature points between two images and remove minor movements. These methods significantly reduce artifacts seen after performing T1 mapping. However, they don’t account for changes in contrast between images which can interfere with motion estimation.
The proposed algorithm involves looking at a region of interest specified by the user on the most normal image in the set – we have decided that the most normal will be the median image in terms of time it was taken – and zeroing out the intensity values of each pixel outside the region of interest for this image. This same operation is then performed on all other images that will be registered to this reference image using the same mask drawn by the user. Each image has a contrast similarity calculated which is then used to minimize error between the images by applying global motion to the image that’s being registered. We use different formulas for error depending on the contrast similarity being high or low. The domain of high or low contrast similarity was empirically defined by the researchers. A second local non-rigid motion estimation is then performed on each feature point – defined by the user when drawing the region of interest on the reference image – and involves minimizing a third error function which detects intensity error between each pixel in the image and all the feature points. After both forms of motion have been estimated, the resulting matrices can be applied to the image being registered, resulting in our registered image.
The application will be written using MATLAB to integrate seamlessly with Professor Mehmet Akçakaya current research tools and is focused on being able to run in a timely fashion on a typical consumer PC. To increase the speed of the application we will make use of MATLAB’s CUDA integration which uses the PC’s GPU to perform large amount of calculations in parallel. The application will also show the user the images at different points in the registration process which allows the user to better track the changes in the images.
Overall the algorithm was shown by the research group to perform well on images with both low and high levels of contrast variation, with similar results to traditional methods for high contrast similarities. For images with low contrast similarities this algorithm outperformed traditional methods. but there remain several improvements that can still be made. Additional desired features include developing a method of automatically detecting the region of interest and feature points on the reference image. Also desired is a better method of detecting the image with the most average amount of movement. The current method being used does not guarantee it’s the most average image in terms of movement and is simply one of the more likely places for it to be.
