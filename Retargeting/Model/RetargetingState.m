//
//  RetargetingState.m
//  Retargeting
//
//  Created by Daniel Graf on 16.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "RetargetingState.h"
#import "RetargetingSolver.h"
#import "RetargetingTask.h"

#define PRINT_DEBUG_SOLUTION 0

#define SALIENCY_RESOLUTION 250

@implementation RetargetingState {
    RetargetingSolver * solver;
    int max_fill;
    int min_fill;
}

@synthesize originalImage = _originalImage;
@synthesize imageTexture = _imageTexture;
@synthesize saliencyExtractionImageBitmap = _saliencyExtractionImageBitmap;
@synthesize saliencyExtractionImage = _saliencyExtractionImage;
@synthesize originalSize = _originalSize;
@synthesize originalUIImageSize = _originalUIImageSize;
@synthesize saliencyMapSize = _saliencyMapSize;
@synthesize saliencyTextureSize = _saliencyTextureSize;
@synthesize sourceSize = _sourceSize;
@synthesize textureSize = _textureSize;
@synthesize targetSize = _targetSize;
@synthesize sourceRatio = _sourceRatio;
@synthesize targetRatio = _targetRatio;
@synthesize needsRecalc = _needsRecalc;
@synthesize useMipMaps = _useMipMaps;
@synthesize gridM;
@synthesize gridN;
@synthesize laplacianRegularizationWeight = _laplacianRegularizationWeight;
@synthesize LFactor = _LFactor;
@synthesize paintMode = _paintMode;
@synthesize brushSize = _brushSize;
@synthesize upsamplingFactor = _upsamplingFactor;
@synthesize layoutMode = _layoutMode;
@synthesize zoomFactor = _zoomFactor;
@synthesize translationVector = _translationVector;
@synthesize showGrid = _showGrid;
@synthesize showSaliency = _showSaliency;
@synthesize motionCompensation = _motionCompensation;
@synthesize croppingFlag = _croppingFlag;
@synthesize croppingAlpha = _croppingAlpha;
@synthesize croppingBeta = _croppingBeta;
@synthesize croppingGamma = _croppingGamma;
@synthesize cropBox = _cropBox;
@synthesize cropPreviewSize = _cropPreviewSize;
@synthesize cropPreviewRatio = _cropPreviewRatio;

@synthesize task = _task;


- (void)setDefaultParameterSettingsWithCropping:(bool)croppingFlag {
    if(self.croppingFlag) {
        self.LFactor = 0.7;
        self.croppingAlpha = 0.5;
        self.croppingBeta = 0.5;
        self.croppingGamma = 0.5;
    } else { // based on the paper of Panozzo et al. 2012
        self.LFactor = 0.2;
    }

}

- (void)resetDefaultParameterSettings {
    
    self.laplacianRegularizationWeight = 0.0;
    self.paintMode = YES;
    
    self.upsamplingFactor = 2.0;
    self.showGrid = NO;
    self.showSaliency = NO;
    self.motionCompensation = YES;    
    
    self.croppingFlag = YES;
    self.LFactor = 0.7;
    self.croppingAlpha = 0.5;
    self.croppingBeta = 0.5;
    self.croppingGamma = 0.5;

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) self.brushSize = 60.0;
    else self.brushSize = 40.0;
    

}
- (RetargetingState *) init {
    //NSLog(@"INIT OF SAMPLE RETARGETING STATE");
    self = [super init];
    self.gridM = 25;
    self.gridN = 25;
    
    max_fill = 200;
    min_fill = 10;

    // parameters not reset when switching between simple and advanced settings
    self.layoutMode = kLayoutModeCombined;
    self.zoomFactor = 1.0;
    self.translationVector = CGPointMake(0.0, 0.0);

    [self resetDefaultParameterSettings];

    TCropBox c;
    c.left = 0;
    c.right = 0;
    c.bottom = 0;
    c.top = 0;
    self.cropBox = c;
    
    self.useMipMaps = YES;

    solver = [[RetargetingSolver alloc] init];
    return self;
}
- (void) dealloc {
    solver = nil;
}

- (RetargetingTask *)task {
    if([self needsRecalc]) {
        [self calculateWarp];
    }
    return _task;
}

- (double)cropPreviewRatio {
    if([self needsRecalc]) {
        [self calculateWarp];
    }
    return _cropPreviewRatio;
}
- (CGRect)cropPreviewInnerRect {
    if([self needsRecalc]) {
        [self calculateWarp];
    }
    return self.task.cropPreviewInnerRect;
}

- (void) setNeedsRecalc:(BOOL)needsRecalc {
    _needsRecalc = needsRecalc;
}
- (void) calculateWarp {
    self.needsRecalc = false;
    double LW,LH;
    // old version - just uniformly dividing
//    LW = self.targetSize.width / self.gridN * self.LFactor;
//    LH = self.targetSize.height / self.gridM * self.LFactor;
    
    // new version - keeping the limiting aspect ration
    if(self.targetRatio > self.sourceRatio) {
        // height is limiting
        LH = self.targetSize.height / self.gridM * self.LFactor;
        LW = self.sourceRatio * self.targetSize.height / self.gridN * self.LFactor;
    } else {
        LW = self.targetSize.width / self.gridN * self.LFactor;
        LH = 1.0 / self.sourceRatio * self.targetSize.width / self.gridM * self.LFactor;
    }
    
//    printf("LW %f LH %lf\n",LW,LH);
    //RetargetingSolver * solver = [[RetargetingSolver alloc] init];
    
    self.task = [[RetargetingTask alloc] initWithOmega:self.saliencyMatrix
                                                     M:self.gridM
                                                     N:self.gridN
                                                     W:self.originalSize.width
                                                     H:self.originalSize.height
                                                    Wp:self.targetSize.width
                                                    Hp:self.targetSize.height
                                                    LW:LW
                                                    LH:LH
                                                 wregL:self.laplacianRegularizationWeight
                                      upsamplingFactor:self.upsamplingFactor
                                          croppingFlag:self.croppingFlag
                                          croppinAlpha:self.croppingAlpha
                                           croppinBeta:self.croppingBeta
                                          croppinGamma:self.croppingGamma
                                               cropBox:(TCropBox)self.cropBox];
    
    self.task = [solver solveAndPostprocessWithTask:self.task];
    self.cropPreviewSize = CGSizeMake([self.task.cropPreviewCols last],
                                      [self.task.cropPreviewRows last]);
    self.cropPreviewRatio = 1.0 * self.cropPreviewSize.width / self.cropPreviewSize.height;
//    printf("cropPreviewRatio: %f\n",self.cropPreviewRatio);
//    double * xsol = [[self.task.sRows stackTo:self.task.sCols] rawDataAsColumnMajor];
    
    if(PRINT_DEBUG_SOLUTION) {
        [self.task dumpMatlabExportToConsole];
//    printf("problem description: M %d N %d\n",self.gridM,self.gridN);
//    printf("W %lf H %lf\n",self.sourceSize.width, self.sourceSize.height);
//    printf("W' %lf H' %lf\n",self.targetSize.width, self.targetSize.height);
//    printf("LW %lf HW %lf\n",L_factor*self.targetSize.width/self.gridN, L_factor*self.targetSize.height/self.gridM);
//    printf("Saliency: ");
//    for(int i=0;i<25*25;i++)printf("%lf ",self.saliencyMatrix[i]);
//    printf("\nResult: ");
//    for(int i=0;i<50;i++)printf("%lf ",xsol[i]);
//    printf("\n-------\n");
    }
    
    //use them
//    s = (double *)xsol;
//    self.warpDescriptionVector = [[NSMutableArray alloc] initWithCapacity:50];
//    for(int i=0;i<50;i++) {
//        [self.warpDescriptionVector insertObject:[NSNumber numberWithDouble:s[i]] atIndex:i];
//    }
    return;
}
- (void) loadImageFromPath:(NSString*)path {
    NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
    [self loadImage:[[UIImage alloc] initWithData:texData]];
}
    
- (void) loadImage:(UIImage *)image {
    if(self.imageTexture) {free(self.imageTexture); self.imageTexture = 0;}

    self.originalImage = image;
    if(self.originalImage == nil) {
        NSLog(@"Error when loading the texture image");
    }
    
    GLuint width = CGImageGetWidth(self.originalImage.CGImage);
    GLuint height = CGImageGetHeight(self.originalImage.CGImage);
    self.originalUIImageSize = CGSizeMake(width, height);
    GLuint square = 1;
    while(square < width || square < height) square *= 2;
    
    // impose device specific maximum size limit in a way such that
    // no texture gets allocated that the OpenGL ES chip can not handle
    while(square > GL_MAX_TEXTURE_SIZE) square /= 2;

    // iPad 1 Specific Fix -> limit texture size to 512x512 as the OpenGL
    // implementation there seems to be very limited -> crash when allocating bigger textures
    NSString *platform = [DeviceType platform];
    if ([platform isEqualToString:@"iPad1,1"]) {
        if(square > 512) square = 512;        
    }
    
    // scale image down if needed
    if(MAX(width, height) > square) {
        NSLog(@"Need to scale the image down from its original size to fit into the texture buffer");
        double scalingFactor = 1.0 * square / MAX(width, height);
        printf("Original image dimensions %d %d -> scaling factor %lf\n",width,height,scalingFactor);
        width *= scalingFactor;
        height *= scalingFactor;
    }
    
    
    self.originalSize = CGSizeMake(width, height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    self.imageTexture = malloc ( square * square * 4 );
    CGContextRef context = CGBitmapContextCreate(self.imageTexture, square, square, 8, 4*square, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextClearRect(context, CGRectMake(0, 0, square, square));
    
    // flip y-axis of the image such that it gets rendered in the usual upper-left-origin way
    CGContextTranslateCTM(context, 0, square);
    CGContextScaleCTM(context, 1.0, -1.0);
    // draw to buffer
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.originalImage.CGImage);
//    NSLog(@"predefined texture loaded with size %d by %d", width,height);
    CGContextRelease(context);
    self.textureSize = CGSizeMake(square, square);
    self.sourceRatio = 1.0 * width / height;
    self.targetRatio = self.sourceRatio; //initialize with original aspect ratio
    self.targetSize = CGSizeMake(self.targetRatio, 1.0);

    [self resetSaliency];
    [self createSaliencyResolutionImage];
    //self.paintMode = YES; // -> settings view needs to be updated
        
}

- (void) unloadImage {
    if(self.imageTexture) {
        free(self.imageTexture);
        self.imageTexture = 0;
    }
    if(self.saliencyExtractionImageBitmap) {
        free(self.saliencyExtractionImageBitmap);
        self.saliencyExtractionImageBitmap = 0;
    }
    if(self.saliencyMap) {
        free(self.saliencyMap);
        self.saliencyMap=0;
    }
}
- (void) createInitialSaliency {
    // prepare for automatic saliency detection
    [self resetSaliency];
    [self automaticSaliency];
}

- (void) loadSaliencyImage:(UIImage *)saliencyImage {
    [self resetSaliency];

    int width = self.saliencyMapSize.width;
    int height = self.saliencyMapSize.height;
    int square = self.saliencyTextureSize.width;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // render saliency Image onto saliencyMap
    CGContextRef context = CGBitmapContextCreate(self.saliencyMap, square, square, 8, 4*square, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextClearRect(context, CGRectMake(0, 0, width, height));
    
    // flip y-axis of the image such that it gets rendered in the usual upper-left-origin way
//    CGContextTranslateCTM(context, 0, height);
//    CGContextScaleCTM(context, 1.0, -1.0);
    // draw to buffer
    CGContextDrawImage(context, CGRectMake(0, square-height, width, height), saliencyImage.CGImage);
//    NSLog(@"saliencyImage loaded with size %d by %d", width,height);
    CGContextRelease(context);
    for(int x=0;x<width;x++) {
        for(int y=0;y<height;y++) {
            int s = 4*(y*square+x);
            self.saliencyMap[s] = 255;
            self.saliencyMap[s+1] = 255;
            self.saliencyMap[s+2] = 255;
        }
    }
    [self recalculateSaliencyMatrix];
}

- (UIImage *) saveSaliencyImage {
    int width = self.saliencyMapSize.width;
    int height = self.saliencyMapSize.height;
    int square = self.saliencyTextureSize.width;
    char * bitmap = malloc(width*height*4*sizeof(char));
    for(int x=0;x<width;x++) {
        for(int y=0;y<height;y++) {
            int s = 4*(y*square+x);
            int t = 4*(y*width+x);
            bitmap[t] = self.saliencyMap[s];
            bitmap[t+1] = self.saliencyMap[s+1];
            bitmap[t+2] = self.saliencyMap[s+2];
            bitmap[t+3] = self.saliencyMap[s+3];
        }
    }
    NSData *bitmapData = [NSData dataWithBytesNoCopy:bitmap length:width*height*4 freeWhenDone:YES];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CIImage * ciImage = [CIImage imageWithBitmapData:bitmapData bytesPerRow:4*width size:CGSizeMake(width, height) format:kCIFormatRGBA8 colorSpace:colorSpace];
    CGColorSpaceRelease(colorSpace);
    
//    UIImage * uiImage = [UIImage imageWithCIImage:ciImage];

    CIContext *context = [CIContext contextWithOptions:nil];
    UIImage *uiImage = [UIImage imageWithCGImage:[context createCGImage:ciImage fromRect:ciImage.extent]];
    
    NSLog(@"created Saliency Image %f %f",uiImage.size.width, uiImage.size.height);
    return uiImage;
}

- (void) createSaliencyResolutionImage {
    int width = self.saliencyMapSize.width;
    int height = self.saliencyMapSize.height;
    CGSize size = CGSizeMake(width, height);
    // first create a lowres UIImage
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.originalImage.CGImage);
    
    self.saliencyExtractionImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    
    // now generate the corresponding bitmap
    
    if(self.saliencyExtractionImageBitmap) {free(self.saliencyExtractionImageBitmap); self.saliencyExtractionImageBitmap=0;}
    
    
    self.saliencyExtractionImageBitmap = malloc(width*height*4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(self.saliencyExtractionImageBitmap, width, height, 8, 4*width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextClearRect(context, CGRectMake(0, 0, width, height));
    
    // flip y-axis of the image such that it gets rendered in the usual upper-left-origina way
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // draw to buffer
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.saliencyExtractionImage.CGImage);
//    NSLog(@"saliency resolution image made with size %d by %d", width,height);
    CGContextRelease(context);
}

- (void) resetSaliency {
    // map
    if(self.saliencyMap) {free(self.saliencyMap); self.saliencyMap = 0;}
    CGFloat width = round(SALIENCY_RESOLUTION * self.originalSize.width/(MAX(self.originalSize.width, self.originalSize.height)));
    CGFloat height = round(SALIENCY_RESOLUTION * self.originalSize.height/(MAX(self.originalSize.width, self.originalSize.height)));
    GLuint square = 1;
    while(square < width || square < height) square *= 2;
    self.saliencyMapSize = CGSizeMake(width,height);
    self.saliencyTextureSize = CGSizeMake(square, square);
//    NSLog(@"Saliency Map Size %f %f",self.saliencyTextureSize.width, self.saliencyTextureSize.height);
    
    self.saliencyMap = malloc(square * square * 4);
    for(int xy=0; xy < square * square; xy++) {
        self.saliencyMap[4*xy+0] = 255;
        self.saliencyMap[4*xy+1] = 255;
        self.saliencyMap[4*xy+2] = 255;
        self.saliencyMap[4*xy+3] = 10;
    }
    //matrix
//    if(self.saliencyMatrix) free(self.saliencyMatrix);
    self.saliencyMatrix = [[Matrix alloc] initWithSizeRows:self.gridM andColumns:self.gridN];
    for(int x=0;x<self.gridN;x++) {
        for(int y=0;y<self.gridM;y++) {
            [self.saliencyMatrix setEntryAtRow:y andColumn:x toValue:0.05];            
        }
    }
    self.zoomFactor = 1.0;
    self.translationVector = CGPointMake(0.0,0.0);
    [self setNeedsRecalc:YES];
}

- (double *) calculateGradient {
    int width = self.saliencyMapSize.width;
    int height = self.saliencyMapSize.height;
    
    char * image = self.saliencyExtractionImageBitmap;
    double * grayscale = malloc(width*height*sizeof(double));
    
    //    for(int x=0;x<width; x++) {
    //        for(int y=0; y<height; y++) {
    //            printf("green: %d\n",image[4*(y*width + x) + 1]);
    //            printf("gray: %f\n",grayscale[y*width + x]);
    //        }
    //    }
    
    for(int x=0;x<width; x++) {
        for(int y=0; y<height; y++) {
            // grey = 0.299 * R + 0.587 * G + 0.114 * B
            //printf("x %d y %d R %d G %d B %d A %d\n",x,y,image[4*(y*width + x) + 0],image[4*(y*width + x) + 1],image[4*(y*width + x) + 2],image[4*(y*width + x) + 3]);
            
            unsigned char red = image[4*(y*width + x) + 0];
            unsigned char green = image[4*(y*width + x) + 1];
            unsigned char blue = image[4*(y*width + x) + 2];
            grayscale[y*width+x] = 0.299*red+0.587*green+0.114*blue;
            //printf("grey: %f\n",grayscale[y*width+x]);
        }
    }
    
    // calculate gradient with Sobel Kernel
    double * xGradient = malloc(width*height*sizeof(double));
    double * yGradient = malloc(width*height*sizeof(double));
    double * Gradient = malloc(width*height*sizeof(double));
    
    double A[3][3];
    for(int x=1;x<width-1; x++) {
        for(int y=1; y<height-1; y++) {
            A[0][0] = grayscale[(y-1)*width+(x-1)];
            A[0][1] = grayscale[(y)*width+(x-1)];
            A[0][2] = grayscale[(y+1)*width+(x-1)];
            A[1][0] = grayscale[(y-1)*width+(x)];
            A[1][1] = grayscale[(y)*width+(x)];
            A[1][2] = grayscale[(y+1)*width+(x)];
            A[2][0] = grayscale[(y-1)*width+(x+1)];
            A[2][1] = grayscale[(y)*width+(x+1)];
            A[2][2] = grayscale[(y+1)*width+(x+1)];
            int c = y*width+x;
            xGradient[c] = -1*A[0][0]-2*A[1][0]-1*A[2][0]+1*A[0][2]+2*A[1][2]+1*A[2][2]; //sobel kernel
            yGradient[c] = -1*A[0][0]-2*A[0][1]-1*A[0][2]+1*A[2][0]+2*A[2][1]+1*A[2][2];
            //            xGradient[c] = A[1][0]-A[1][2]; // simple differential
            //            yGradient[c] = A[0][1]-A[2][1];
            Gradient[c] = sqrt(xGradient[c]*xGradient[c]+yGradient[c]*yGradient[c]);
        }
    }
    //normalize
    double GradMax=0;
    for(int x=1;x<width-1; x++) {
        for(int y=1; y<height-1; y++) {
            int c = y*width+x;
            if(GradMax < Gradient[c]) GradMax = Gradient[c];
        }
    }
    // normalize gradient
    for(int x=1;x<width-1; x++) {
        for(int y=1; y<height-1; y++) {
            int c = y*width+x;
            
            // cut off the lowest 10 percent
            //if(Gradient[c]<0.1*GradMax) Gradient[c] =0.0;
            Gradient[c]/=GradMax;
            Gradient[c]*=250;            
        }
    }
    
    //    Matrix * grayMatrix = [[Matrix alloc] initFromRowMajorData:grayscale withRows:height andColumns:width];
    //    [grayMatrix printMatrixAsMatlabCodeWithName:@"gray"];
    //    Matrix * xGradMatrix = [[Matrix alloc] initFromRowMajorData:xGradient withRows:height andColumns:width];
    //    [xGradMatrix printMatrixAsMatlabCodeWithName:@"Xgrad"];
    //    Matrix * yGradMatrix = [[Matrix alloc] initFromRowMajorData:yGradient withRows:height andColumns:width];
    //    [yGradMatrix printMatrixAsMatlabCodeWithName:@"Ygrad"];
    //    Matrix * GradMatrix = [[Matrix alloc] initFromRowMajorData:Gradient withRows:height andColumns:width];
    //    [GradMatrix printMatrixAsMatlabCodeWithName:@"Grad"];
    
    free(xGradient);
    free(yGradient);
    free(grayscale);
    return Gradient;
}

- (double *)expandMap:(double *) source {
    int width = self.saliencyMapSize.width;
    int height = self.saliencyMapSize.height;
    double * dest = malloc(width*height*sizeof(double));
    int d = 4; // neighborhood radius
    for(int x=0;x<width; x++) {
        for(int y=0; y<height; y++) {
            int c = y*width+x;
            for(int dx = -d; dx<=d;dx++) {
                for(int dy=-d; dy<d;dy++) {
                    double dist = sqrt(dx*dx+dy*dy);
                    if(dist<=d) { // check radius for circular drawings
                        int xn = x+dx; int yn = y+dy;
                        if(0<=xn && xn < width && 0<=yn && yn<height) {
                            dest[c] = MAX(dest[c],(0.5+0.5*(d*d-dist*dist)/(d*d))*source[yn*width+xn]);
                        }
                    }
                }
            }
        }
    }
    return dest;
}

- (void)recalculateSaliencyMatrix {
    int width = self.saliencyMapSize.width;
    int height = self.saliencyMapSize.height;
    int square = self.saliencyTextureSize.width;
    double cell_size = (width * height) / (self.gridM*self.gridN);
    //reset
    [self.saliencyMatrix setAllEntriesToValue:0.0];
    // saliency map
    int x,y,m,n,c;
    for( x=1;x<width; x++) {
        for( y=1; y<height; y++) {
            c = 4*(y*square +x) + 3;
            m = (int)(1.0 * y/height*self.gridM); n = (int)(1.0*x/width*self.gridN);
            [self.saliencyMatrix setEntryAtRow:m
                                     andColumn:n
                                       toValue:[self.saliencyMatrix entryAtRow:m andColumn:n] +1.0*(self.saliencyMap[c])/(cell_size * max_fill)];
        }
    }
}

- (void) faceDetection {
    // Create the image
    int width = self.saliencyMapSize.width;
    int height = self.saliencyMapSize.height;

    // Create the face detector
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:CIDetectorAccuracyLow, CIDetectorAccuracy, nil];
    
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];

    CIImage* ciimage = [CIImage imageWithCGImage:self.originalImage.CGImage];
//    CIImage* ciimage = [CIImage imageWithCGImage:self.saliencyExtractionImage.CGImage];
    // Detect the faces
    NSArray *faces = [faceDetector featuresInImage:ciimage];
    NSLog(@"%d faces found",[faces count]);
    NSLog(@"%@", faces);
    
    for(CIFaceFeature* face in faces) {
        CGRect faceRect = face.bounds;
        NSLog(@"x %lf y %lf w %lf h %lf",faceRect.origin.x,faceRect.origin.y,
              faceRect.size.width, faceRect.size.height);
//        CGPoint leftEye = face.leftEyePosition;
//        CGPoint rightEye = face.rightEyePosition;
//        CGPoint eyeCenter = CGPointMake(0.5*(leftEye.x+rightEye.x),
//                                     0.5*(leftEye.y+rightEye.y));
        CGPoint faceCenter = CGPointMake(faceRect.origin.x + 0.5*faceRect.size.width,
                                     faceRect.origin.y + 0.5*faceRect.size.height);
        CGPoint center = faceCenter; 
        CGPoint radius = CGPointMake(abs(center.x-faceRect.origin.x),
                                     abs(center.y-faceRect.origin.y));
        
        // transform into saliency space:
        center = CGPointMake(center.x/self.originalUIImageSize.width*width, center.y/self.originalUIImageSize.height*height);
        radius = CGPointMake(radius.x/self.originalUIImageSize.width*width, radius.y / self.originalUIImageSize.height*height);
        
        // fill the ellipse around it
        int rx = radius.x;
        int ry = radius.y;
        for(int dx = -rx; dx<=rx; dx++) {
            for(int dy = -ry; dy<=ry; dy++) {
                double qx = 1.0*dx/rx, qy = 1.0*dy/ry;
                double rad = 1.0*ABS(qx*qx*qx)+ABS(qy*qy*qy);
                if(rad<=1.0) {
                    int x = center.x + dx;
                    int y = center.y + dy;
                    if(0<=x && x<width && 0<=y && y<=height) {
                        int m = 4*(y*(int)self.saliencyTextureSize.width + x) + 3;
                        self.saliencyMap[m] = MAX(self.saliencyMap[m],(1-rad*rad*rad)*max_fill);
                    }
                }
            }
        }
                                     
    }
}

- (void) automaticSaliency {
    int width = self.saliencyMapSize.width;
    int height = self.saliencyMapSize.height;
    
    //calculate gradient
    double * Gradient = [self calculateGradient];
    double * ExpandedGradient = [self expandMap:Gradient];
    // set it to the saliency map
    for(int x=1;x<width-1; x++) {
        for(int y=1; y<height-1; y++) {
            int c = y*width+x;
            int m = 4*(y*(int)self.saliencyTextureSize.width + x) + 3;
            self.saliencyMap[m] = MIN(max_fill, self.saliencyMap[m]+ExpandedGradient[c]);
            
        }
    }
    
    
    //face detection
    
    [self faceDetection];
    
    
    // recalculate matrix
    [self recalculateSaliencyMatrix];
    
    // set for recalculation
    self.needsRecalc = YES;
    free(Gradient);
    free(ExpandedGradient);
 
}

- (void) paintAtPosition:(CGPoint)point {
    CGFloat width = self.saliencyMapSize.width;
    CGFloat height = self.saliencyMapSize.height;
    
    int ox = (int)1.0*point.x*width;
    int oy = (int)1.0*point.y*height;
    //NSLog(@"Point in Model at %d %d",ox, oy);
    int x,y,c,dx,dy;
    float effective_radius;
    float brightness = 100;
    int old_saliency, new_saliency;
    int m,n; //grid coordinates
    double cell_size = (width * height) / (self.gridM*self.gridN);
    
//    printf("source width %f\n",self.sourceSize.width);
//    int maxSize = MAX(self.sourceSize.width,self.sourceSize.height);
    
    double diagonal = sqrt(self.sourceSize.height*self.sourceSize.height
                           + self.sourceSize.width*self.sourceSize.width);
//    printf("diagonal %lf\n",diagonal);
//    MAX([UIApplication currentSize].width,[UIApplication currentSize].height);
    int radius = round(1.0*self.brushSize*self.saliencyMapSize.width/diagonal);
    
//    printf("saliencyMapSize %lf sourceSize %lf\n",self.saliencyMapSize.width,self.sourceSize.width);
//    printf("saliency map pixel radius %d\n",radius);
    int square = self.saliencyTextureSize.width;
//    printf("square %d\n",square);
    for(dx = -radius; dx <= radius; dx++) {
        for(dy = -radius; dy <= radius; dy++) {
            x = ox+dx; y = oy+dy; c = 4*(y*square +x) + 3;
            effective_radius = sqrt(dx*dx+dy*dy);
            if(effective_radius<=radius) {
                if(0<=x && x<width && 0<=y && y<height) {
                    int intensity = brightness * (radius-effective_radius)/radius;
                    old_saliency = self.saliencyMap[c];
                    if(self.paintMode) {
                        new_saliency =  MIN(max_fill, self.saliencyMap[c]+intensity);
                    } else {
                        new_saliency = MAX(min_fill, self.saliencyMap[c]-intensity);
                    }
                    //map
                    self.saliencyMap[c] = new_saliency;

                    //matrix
                    m = (int)(1.0 * y/height*self.gridM); n = (int)(1.0*x/width*self.gridN);
//                    if(new_saliency > old_saliency) {
//                        printf("break");
//                    }
                    [self.saliencyMatrix setEntryAtRow:m andColumn:n toValue:
                     [self.saliencyMatrix entryAtRow:m andColumn:n] +
                     1.0*(new_saliency-old_saliency)/(cell_size * max_fill)];
//                    self.saliencyMatrix[m*self.gridN + n] += 1.0*(new_saliency-old_saliency)/(cell_size * max_fill);
                }
            }
            
        }
    }
    self.needsRecalc = YES;
//    [self calculateWarp];
    
}


@end