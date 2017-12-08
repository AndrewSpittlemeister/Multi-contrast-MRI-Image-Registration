function [Ireg, Iref, Mask] = getImageData(Iref_file,Ireg_file)
    Iref = uint16(adjustgray(dicomread(Iref_file)));
    Ireg = uint16(adjustgray(dicomread(Ireg_file)));
    dicomshow(Iref);
    Mask = uint16(createMask(imfreehand));
    
    

end

