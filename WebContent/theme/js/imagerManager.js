function AutoSize(ImgD,MaxWidth,MaxHeight){
   var image=new Image();
   image.src=ImgD.src;
   if(image.width>0 && image.height>0){
    flag=true;
    if(image.width/image.height>= MaxWidth/MaxHeight){
     if(image.width>MaxWidth){  
     ImgD.width=MaxWidth;
     ImgD.height=(image.height*MaxWidth)/image.width;
     }else{
     ImgD.width=image.width;  
     ImgD.height=image.height;
     }
     //ImgD.alt="原始尺寸:宽" + image.width+",高"+image.height;
     }
    else{
     if(image.height>MaxHeight){  
     ImgD.height=MaxHeight;
     ImgD.width=(image.width*MaxHeight)/image.height;     
     }else{
     ImgD.width=image.width;  
     ImgD.height=image.height;
     }
     //ImgD.alt="原始尺寸:宽" + image.width+",高"+image.height;
     }
    }
 } 
