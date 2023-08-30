@echo off

:: If you don't already have Git, download Git-SCM and install it here: https://git-scm.com/download/win
WHERE git >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
	ECHO:
	ECHO You will need to install git first before running this script. Please download it at https://git-scm.com/download/win
	ECHO:
	pause
	exit
)

if not exist ComfyUI\ (
	ECHO:
	ECHO This script must be run in the same directory containing your ComfyUI folder. Please move it there and try running it again.
	ECHO:
	pause
	exit
)

if not exist update\ (
	ECHO:
	ECHO Cannot find the update folder to run the update.py file.
	ECHO:
	pause
	exit
)

cd .\update

if not exist update.py (
	ECHO:
	ECHO Cannot find the update.py file.
	ECHO:
	pause
	exit
)

ECHO Update ComfyUI
..\python_embeded\python.exe .\update.py ..\ComfyUI\

cd ..

:: Change directory to .\custom_nodes so we can update them
cd .\ComfyUI\custom_nodes

:: Check if Comfyroll CustomNodes exists to update else install it
if exist ComfyUI_Comfyroll_CustomNodes\ (
  cd ComfyUI_Comfyroll_CustomNodes
  git reset --hard
  git pull
  cd ..
) else (
  git clone https://github.com/RockOfFire/ComfyUI_Comfyroll_CustomNodes.git
)

:: Check if ComfyUI-Impact-Pack exists to update else install it
if exist ComfyUI-Impact-Pack\ (
	cd ComfyUI-Impact-Pack
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
)


:: Change directory to ./ComfyUI-Impact-Pack
cd .\ComfyUI-Impact-Pack

:: Install Impact Pack submodules ahead of initial launch
git submodule update --init --recursive

:: Install GitPython dependency (needed for next line)
..\..\..\python_embeded\python.exe -m pip install GitPython --no-warn-script-location

:: Install Impact Pack dependencies
..\..\..\python_embeded\python.exe install.py

:: Change directory back to custom_nodes
cd ..

:: Check if was-node-suite-comfyui exists to update else install it
if exist was-node-suite-comfyui\ (
	cd was-node-suite-comfyui
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/WASasquatch/was-node-suite-comfyui.git
)

:: Change directory to .\was-node-suite-comfyui
cd .\was-node-suite-comfyui

ECHO Install WAS Node Suite dependencies
..\..\..\python_embeded\python.exe -s -m pip install -r requirements.txt --no-warn-script-location

:: Change directory to custom_nodes
cd ..

:: Check if sdxl_prompt_styler exists to update else install it
if exist sdxl_prompt_styler\ (
	cd sdxl_prompt_styler
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/twri/sdxl_prompt_styler.git
)

:: Check if ComfyUI_UltimateSDUpscale exists to update else install it
if exist ComfyUI_UltimateSDUpscale\ (
	cd ComfyUI_UltimateSDUpscale
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive
)

:: Check if efficiency-nodes-comfyui exists to update else install it
if exist efficiency-nodes-comfyui\ (
	cd efficiency-nodes-comfyui
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/LucianoCirino/efficiency-nodes-comfyui.git
)

:: Check if comfyui_controlnet_aux exists to update else install it
if exist comfyui_controlnet_aux\ (
	cd comfyui_controlnet_aux
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git
)

:: Change directory to .\comfyui_controlnet_aux
cd .\comfyui_controlnet_aux

ECHO Install Python dependencies
..\..\..\python_embeded\python.exe -s -m pip install -r requirements.txt --no-warn-script-location

ECHO Install Addict module as it's not being installed normally
..\..\..\python_embeded\python.exe -m pip install addict --no-warn-script-location

:: Change directory back to custom_nodes
cd ..

ECHO Get simpleeval package as it has trouble loading first time
..\..\python_embeded\python.exe -m pip install simpleeval --no-warn-script-location

:: Check if failfast-comfyui-extensions exists to update else install it
if exist failfast-comfyui-extensions\ (
	cd failfast-comfyui-extensions
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/failfa-st/failfast-comfyui-extensions.git
)

:: Check if Derfuu_ComfyUI_ModdedNodes exists to update else install it
if exist Derfuu_ComfyUI_ModdedNodes\ (
	cd Derfuu_ComfyUI_ModdedNodes
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes.git
)

:: Check if comfy_mtb exists to update else install it
if exist comfy_mtb\ (
	cd comfy_mtb
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/melMass/comfy_mtb.git
)

:: Change directory to comfy_mtb
cd .\comfy_mtb

ECHO Installing MTB depdenencies
..\..\..\python_embeded\python.exe -m pip install requirements-parser --no-warn-script-location

ECHO Installing MTB requirement dependencies
..\..\..\python_embeded\python.exe -m pip install -r reqs_windows.txt --no-warn-script-location

ECHO Installing gfpgan dependency
..\..\..\python_embeded\python.exe -m pip install gfpgan --no-warn-script-location

:: Change directory back to custom_nodes
cd ..

:: Check if rgthree-comfy exists to update else install it
if exist rgthree-comfy\ (
	cd rgthree-comfy
	git reset --hard
	git pull
	
	cd ..
) else (
	git clone https://github.com/rgthree/rgthree-comfy.git
)

:: Check if rgthree already has web extensions installed and delete them
if exist ..\web\extensions\rgthree\ (
	del /Q ..\web\extensions\rgthree
)

:: Check if ComfyUI-OpenPose-Editor exists to update else install it
if exist ComfyUI-OpenPose-Editor\ (
	cd ComfyUI-OpenPose-Editor
	git reset --hard
	git pull

	cd ..
) else (
	git clone https://github.com/space-nuko/ComfyUI-OpenPose-Editor.git
)

:: Check if ComfyUI-Manager exists to update else install it
if exist ComfyUI-Manager\ (
	cd ComfyUI-Manager
	git reset --hard
	git pull
	cd ..
) else (
	git clone https://github.com/ltdrdata/ComfyUI-Manager.git
)

:: Change directory to ..\models\ultralytics\bbox
cd ..\models\ultralytics\bbox

:: Download face detection models
if not exist face_yolov8n_v2.pt (
	curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n_v2.pt --output face_yolov8n_v2.pt
)

:: Download face detection models
if not exist face_yolov8n.pt (
	curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n.pt --output face_yolov8n.pt
)

:: Download face detection models
if not exist face_yolov8s.pt (
	curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8s.pt --output face_yolov8s.pt
)

:: Download hand detection models
if not exist hand_yolov8n.pt (
	curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8n.pt --output hand_yolov8n.pt
)

:: Change directory to ..\controlnet
cd ..\..\controlnet

:: Download SDXL Canny ControlNet
if not exist control-lora-canny-rank256.safetensors (
	curl -L https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-canny-rank256.safetensors --output control-lora-canny-rank256.safetensors
)

:: Download SDXL Depth ControlNet
if not exist control-lora-depth-rank256.safetensors (
	curl -L https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors --output control-lora-depth-rank256.safetensors
)

:: Download SDXL OpenPose ControlNet
if not exist openpose-sdxl-1.0.safetensors (
	curl -L https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors --output openpose-sdxl-1.0.safetensors
)

:: Change directory to models
cd ..

:: Create face_restore model path
if not exist face_restore\ (
	mkdir face_restore
)

:: Change directory to face_restore
cd face_restore

:: Download Face Restore GFPGAN model
if not exist GFPGANv1.4.pth (
	curl -L https://github.com/TencentARC/GFPGAN/releases/download/v1.3.4/GFPGANv1.4.pth --output GFPGANv1.4.pth
)

:: Change directory to models
cd ..

:: Create insightface model path
if not exist insightface\ (
	mkdir insightface
)

:: Change directory to insightface
cd insightface

:: Download Face Swap models
if not exist detection_mobilenet0.25_Final.pth (
	curl -L https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_mobilenet0.25_Final.pth --output detection_mobilenet0.25_Final.pth
)

:: Download Face Swap models
if not exist detection_Resnet50_Final.pth (
	curl -L https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_Resnet50_Final.pth --output detection_Resnet50_Final.pth
)

:: Download Face Swap models (currently not available)
:: if not exist inswapper_128.onnx (
	:: curl -L https://huggingface.co/deepinsight/inswapper/resolve/main/inswapper_128.onnx --output inswapper_128.onnx
:: )

ECHO:
ECHO:
ECHO:
ECHO All custom node dependencies have been updated and/or installed. >&2
ECHO:
ECHO:
pause