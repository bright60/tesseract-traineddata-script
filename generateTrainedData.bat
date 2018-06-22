@echo off
rem Licensed to the Apache Software Foundation (ASF) under one or more
rem contributor license agreements.  See the NOTICE file distributed with
rem this work for additional information regarding copyright ownership.
rem The ASF licenses this file to You under the Apache License, Version 2.0
rem (the "License"); you may not use this file except in compliance with
rem the License.  You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem Refer to : https://blog.csdn.net/firehood_/article/details/8433077#
rem 		   https://www.joyofdata.de/blog/a-guide-on-ocr-with-tesseract-3-03/
rem ---------------------------------------------------------------------------
rem Generate trained data script for the Tesseract
rem Run it in powershell: cmd /c generateTrainedData.bat
rem ---------------------------------------------------------------------------

echo/
echo/
echo Start to generate trained data ...
echo ===============================================
 
setlocal

set verbose=YES
set quiet=NO
 
set "TESSDATA_PREFIX=D:\devtools\ocr\tesseract-v3.5.1-Win64"

rem Guess CATALINA_HOME if not defined
set "CURRENT_DIR=%cd%"
set "prefix_name=%1"
if "%prefix_name%" == "" goto error1

echo Trained data prefix name: "%prefix_name%"
echo/
echo ----------------------

echo tesseract.exe %prefix_name%.tif %prefix_name% batch.nochop makebox  
tesseract.exe %prefix_name%.tif %prefix_name% batch.nochop makebox  

echo/
echo ----------------------

echo tesseract.exe %prefix_name%.tif %prefix_name% nobatch box.train
tesseract.exe %prefix_name%.tif %prefix_name% nobatch box.train 

echo/
echo ----------------------

echo unicharset_extractor.exe %prefix_name%.box
unicharset_extractor.exe %prefix_name%.box

echo/ 
echo ----------------------

echo Generate font_properties ...
echo %prefix_name% 1 0 0 1 0 > font_properties

echo/
echo ----------------------
echo shapeclustering -F font_properties -U unicharset %prefix_name%.tr
shapeclustering -F font_properties -U unicharset %prefix_name%.tr

echo/
echo ----------------------
echo mftraining.exe -F font_properties -U unicharset %prefix_name%.tr
mftraining.exe -F font_properties -U unicharset %prefix_name%.tr

echo/
echo ----------------------
echo Clustering ...
echo cntraining.exe %prefix_name%.tr
cntraining.exe %prefix_name%.tr

echo/
echo ----------------------
echo Rename file ....
echo Rename inttemp to %prefix_name%.inttemp
move /y inttemp 	%prefix_name%.inttemp

echo Rename normproto to %prefix_name%.normproto
move /y normproto	%prefix_name%.normproto

echo Rename pffmtable to %prefix_name%.pffmtable
move /y pffmtable	%prefix_name%.pffmtable

echo Rename shapetable to %prefix_name%.shapetable
move /y shapetable	%prefix_name%.shapetable

echo Rename unicharset to %prefix_name%.unicharset
move /y unicharset	%prefix_name%.unicharset

echo/
echo ----------------------
combine_tessdata %prefix_name%.

echo/
echo ----------------------

dir *.traineddata

goto end
 
rem ping 127.0.0.1 -n 5000 > nul 

:error1
echo/
echo Error:
echo You have to have one parameter as font name:
echo Usage: %0 fontname
echo For example: %0 test2
echo/

:end

