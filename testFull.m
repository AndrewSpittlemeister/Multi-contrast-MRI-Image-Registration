function testFull(img1_filename, img2_filename)
    [Ireg,Iref,Mask] = getImageData(img1_filename,img2_filename);
    dicomshow(Iref); title({'Original Reference Image'});
    dicomshow(Ireg); title({'Original Registration Image'});
    Ireg_G = GlobalMotionEstimation(Mask, Iref, Ireg);
    dicomshow(Ireg_G); title({'Registration Image after GME'});
    final = LocalMotionEstimation(Ireg_G, Iref, Mask);
    dicomshow(final); title({'Registration Image after LME'});
end

