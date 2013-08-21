Refooormat - Mobile Image Retargeting
===========

This is my Bachelor thesis on content-aware image retargeting. It is a universal iOS app that allows real-time refinement of the retargeted image.

Visit the website of the project for more information: http://refooorm.at

The app is available in the iOS app store: 
https://itunes.apple.com/app/refooormat/id650410245

Technical ReadMe
==============
Mobile Image Retargeting
Bachelor Thesis
Daniel Graf
grafdan@ethz.ch

The Xcode project runs out of the box.
Just press run to execute it in the iOS simulator
or choose your connected device (needs code signing).

Project Structure
-----------------
The classes are grouped into:
- CVXGen Solver
- Model (keep state of projects, retargeting operator, settings...)
- Controller (connect UI with OS and state)
- View (everything that draws onto the screen)
-- Toolbars (Editor, Library)
-- Popovers (Settings, Ratio Picker)
-- RetargetingViews (OpenGL code)
- Helper (small extensions)
- Numerics (compressed column storage matrix library)

Key Parts of the Implementation
-------------------------------
- retargeting operator (prepare and call solver for convex QP)
--> RetargetingSolver solveASAPWithTask:
- cropping
--> RetargetingSolver solveWithCropping:
- threshold range interpolation
--> RetargetingSolver croppingRampWidth:withTask:
- automatic saliency
--> RetargetingState automaticSaliency:
    calculateGradient: / faceDetection:
- painting and saliency matrix update
	RetargetingState paintAtPosition:
- connect everything together:
	RetargetingViewController
- OpenGL calls to render the image:
	e.g. in CombineSaliencyView drawRect:
- fixed-point motion stabilization
	CombinedContainerView paintImage:
	CombinedVew layoutSubviews: