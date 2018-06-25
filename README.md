# tesseract-traineddata-script
The script to generate trained data from images

1 Install tesseract 3.05.01 ( released on June 1, 2017)
 pre-built binary package, https://github.com/tesseract-ocr/tesseract/wiki/Downloads
 
 the download address is https://github.com/tesseract-ocr/tesseract/wiki
Binaries for Windows
4.0.0: https://github.com/tesseract-ocr/tesseract/wiki/4.0-with-LSTM#400-alpha-for-windows
3.5.1: https://github.com/parrot-office/tesseract/releases/tag/3.5.1 (3rd party - @parrot-office)

2. Install jTessBoxEditor-2.0 (Don't use jTessBoxEditorFX-2.0 which is still not stable at this monent.)
Refer to : http://vietocr.sourceforge.net/training.html
The download url: https://sourceforge.net/projects/vietocr/files/jTessBoxEditor/

jTessBoxEditor is a box editor and trainer for Tesseract OCR, providing editing of box data of both Tesseract 2.0x and 3.0x formats and full automation of Tesseract training. It can read images of common image formats, including multi-page TIFF. The program requires Java Runtime Environment 7 or later.

jTessBoxEditorFX is jTessBoxEditor rewritten in JavaFX to address the existing issue of rendering complex scripts in Java Swing. It requires JRE 8u40 or later. (jTessBoxEditorFX is not stable right now, dont' use it....)

3. copy generateTrainedData.bat to the same folder whihc contains images and .tif files

4. run the script with font name, such as:

generateTrainedData.bat test2

Issue:
1. If jTessBoxEditor cann't recognize on the one of page of tif in jTessBoxEditor, then just open .box file, and copy some of lines to specify page, and rename the last number of line as page number, which can't be recognized.


2. Warning: No shape table file present: shapetable , when runing mftraining.exe

Possible solution:  shapeclustering before mftraining.exe ?
