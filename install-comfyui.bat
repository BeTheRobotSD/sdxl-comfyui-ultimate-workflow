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

ECHO Download ComfyUI Portable Version
curl -L https://github.com/comfyanonymous/ComfyUI/releases/download/latest/ComfyUI_windows_portable_nvidia_cu118_or_cpu.7z --output ComfyUI_windows_portable_nvidia_cu118_or_cpu.7z

ECHO Download 7-Zip command line exe
curl -L https://www.7-zip.org/a/7zr.exe --output 7zr.exe

ECHO Extract with 7-Zip
7zr.exe x ComfyUI_windows_portable_nvidia_cu118_or_cpu.7z

ECHO Delete ComfyUI 7-Zip file
rm -f ComfyUI_windows_portable_nvidia_cu118_or_cpu.7z

ECHO Delete 7-Zip command line exe
rm -f 7zr.exe

:: Change directory to .\ComfyUI_windows_portable\update so we can pull the latest version of ComfyUI
cd .\ComfyUI_windows_portable\update

:: Update ComfyUI
..\python_embeded\python.exe .\update.py ..\ComfyUI\

:: Change directory to ComfyUI/custom_nodes so we can download them too
cd ..\ComfyUI\custom_nodes

ECHO Install Comfyroll Custom Nodes
git clone https://github.com/RockOfFire/ComfyUI_Comfyroll_CustomNodes.git

ECHO Install ComfyUI Impact Pack
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git

:: Change directory to ./ComfyUI-Impact-Pack
cd .\ComfyUI-Impact-Pack

ECHO Install Impact Pack submodules ahead of initial launch
git submodule update --init --recursive

ECHO Install GitPython dependency (needed for next line)
..\..\..\python_embeded\python.exe -m pip install GitPython --no-warn-script-location

ECHO Install Impact Pack dependencies
..\..\..\python_embeded\python.exe install.py

:: Change directory back to custom_nodes
cd ..

ECHO Install WAS Node Suite
git clone https://github.com/WASasquatch/was-node-suite-comfyui.git

ECHO Change directory to .\was-node-suite-comfyui
cd .\was-node-suite-comfyui

ECHO Install WAS Node Suite dependencies
..\..\..\python_embeded\python.exe -s -m pip install -r requirements.txt --no-warn-script-location

:: Change directory to custom_nodes
cd ..

ECHO Install SDXL Prompt Styler
git clone https://github.com/twri/sdxl_prompt_styler.git

ECHO Install Ultimate SD Upscale
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive

ECHO Install Efficiency Nodes
git clone https://github.com/LucianoCirino/efficiency-nodes-comfyui.git

ECHO Install ControlNet Preprocessors
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git

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

ECHO Download Failfast Extensions
git clone https://github.com/failfa-st/failfast-comfyui-extensions.git

ECHO Download Derfuu Modded Nodes
git clone https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes.git

ECHO Download Comfy_MTB Nodes for Face Swap and Restore
git clone https://github.com/melMass/comfy_mtb.git

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

ECHO Download RGThree Comfy Nodes
git clone https://github.com/rgthree/rgthree-comfy.git

ECHO Download ComfyUI Manager
git clone https://github.com/ltdrdata/ComfyUI-Manager.git

:: Change directory to ..\models\ultralytics\bbox
cd ..\models\ultralytics\bbox

ECHO Download face detection models
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n_v2.pt --output face_yolov8n_v2.pt
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n.pt --output face_yolov8n.pt
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8s.pt --output face_yolov8s.pt

ECHO Download hand detection models
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8n.pt --output hand_yolov8n.pt

:: Change directory to ..\controlnet
cd ..\..\controlnet

ECHO Download SDXL Canny ControlNet
:: curl -L https://huggingface.co/diffusers/controlnet-canny-sdxl-1.0/resolve/main/diffusion_pytorch_model.fp16.safetensors --output canny-sdxl-1.0.fp16.safetensors
curl -L https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-canny-rank256.safetensors --output control-lora-canny-rank256.safetensors


ECHO Download SDXL Depth ControlNet
:: curl -L https://huggingface.co/SargeZT/controlnet-v1e-sdxl-depth/resolve/main/diffusion_pytorch_model.safetensors --output depth-sdxl-1.0.safetensors
curl -L https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors --output control-lora-depth-rank256.safetensors

ECHO Download SDXL OpenPose ControlNet
curl -L https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors --output openpose-sdxl-1.0.safetensors

:: Change directory to models
cd ..

:: Create face_restore model path
mkdir face_restore

:: Change directory to face_restore
cd face_restore

ECHO Download Face Restore GFPGAN model
curl -L https://github.com/TencentARC/GFPGAN/releases/download/v1.3.4/GFPGANv1.4.pth --output GFPGANv1.4.pth

:: Change directory to models
cd ..

:: Create insightface model path
mkdir insightface

:: Change directory to insightface
cd insightface

ECHO Download Face Swap models
curl -L https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_mobilenet0.25_Final.pth --output detection_mobilenet0.25_Final.pth
curl -L https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_Resnet50_Final.pth --output detection_Resnet50_Final.pth
curl -L https://huggingface.co/deepinsight/inswapper/resolve/main/inswapper_128.onnx --output inswapper_128.onnx


ECHO:
ECHO:
ECHO:
ECHO If you have models in another location, such as checkpoints, LoRAs, upscalers, etc. you should rename "extra_model_paths.yaml.example" to "extra_model_paths.yaml" and set the paths in the file to the correct locations.
ECHO:
ECHO:
pause