from flask import Flask, request, Response, render_template, send_from_directory
from PIL import Image, PngImagePlugin
from io import BytesIO
import exifread
import json
import webbrowser
import socket
from threading import Timer
import os

app = Flask(__name__)

TXT_2_IMG = {
    "base_node": "448",
    "refiner_node": "449",
    "seed": "1018",
    "base_checkpoint": "86",
    "refiner_checkpoint": "445",
    "steps": "594",
    "base_cfg": "187",
    "refiner_cfg": "894",
    "base_sampler_name": "448",
    "refiner_sampler_name": "449",
    "base_scheduler": "448",
    "refiner_scheduler": "449",
    "prompt_style": "878",
    "primary_prompt": "541",
    "secondary_prompt": "542",
    "negative_prompt": "543"
}

IMG_2_IMG = {
    "node": "206",
    "seed": "1022",
    "checkpoint": "465",
    "steps": "595",
    "cfg": "460",
    "denoise": "596",
    "sampler_name": "206",
    "scheduler": "206",
    "prompt_style": "882",
    "primary_prompt": "559",
    "secondary_prompt": "560",
    "negative_prompt": "561",
    "upscale_model": "245"
}

ULTIMATE_SD_UPSCALE = {
    "node": "244",
    "seed": "1020",
    "checkpoint": "94",
    "steps": "599",
    "cfg": "240",
    "denoise": "598",
    "sampler_name": "206",
    "scheduler": "206",
    "prompt_style": "888",
    "primary_prompt": "569",
    "secondary_prompt": "570",
    "negative_prompt": "571",
    "upscale_model": "249"
}

AFTER_DETAILER = {
    "node": "328",
    "seed": "1023",
    "checkpoint": "98",
    "steps": "597",
    "cfg": "338",
    "denoise": "600",
    "sampler_name": "328",
    "scheduler": "328",
    "prompt_style": "888",
    "primary_prompt": "579",
    "secondary_prompt": "580",
    "negative_prompt": "581",
    "detector_model": "347"
}

INPAINT = {
    "node": "398",
    "seed": "1024",
    "checkpoint": "102",
    "steps": "602",
    "cfg": "397",
    "denoise": "603",
    "sampler_name": "398",
    "scheduler": "398",
    "prompt_style": "891",
    "primary_prompt": "589",
    "secondary_prompt": "590",
    "negative_prompt": "591"
}


def getTxt2ImgPrompt(prompt_str):
    prompt = json.loads(prompt_str)
    prompt_data = {}

    for param, node_id in TXT_2_IMG.items():
        if param == "seed":
            prompt_data["seed"] = prompt[node_id]["inputs"]["seed"]
        elif param == "base_checkpoint":
            if node_id not in prompt:
                return {}
            pipe_id = prompt[node_id]["inputs"]["pipe"][0]
            model_id = prompt[pipe_id]["inputs"]["model"][0]
            prompt_data["base_checkpoint"] = prompt[model_id]["inputs"]["ckpt_name"]
        elif param == "refiner_checkpoint":
            pipe_id = prompt[node_id]["inputs"]["pipe"][0]
            model_id = prompt[pipe_id]["inputs"]["model"][0]
            prompt_data["refiner_checkpoint"] = prompt[model_id]["inputs"]["ckpt_name"]
        elif param == "steps":
            prompt_data["steps"] = prompt[node_id]["inputs"]["Value"]
        elif param == "base_cfg":
            prompt_data["base_cfg"] = prompt[node_id]["inputs"]["Value"]
        elif param == "refiner_cfg":
            prompt_data["refiner_cfg"] = prompt[node_id]["inputs"]["Value"]
        elif param == "base_sampler_name":
            prompt_data["base_sampler_name"] = convertSamplerName(prompt[node_id]["inputs"]["sampler_name"])
        elif param == "refiner_sampler_name":
            prompt_data["refiner_sampler_name"] = convertSamplerName(prompt[node_id]["inputs"]["sampler_name"])
        elif param == "base_scheduler":
            prompt_data["base_scheduler"] = prompt[node_id]["inputs"]["scheduler"]
        elif param == "refiner_scheduler":
            prompt_data["refiner_scheduler"] = prompt[node_id]["inputs"]["scheduler"]
        elif param == "prompt_style":
            prompt_data["prompt_style"] = prompt[node_id]["inputs"]["style"]
        elif param == "primary_prompt":
            prompt_data["primary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "secondary_prompt":
            prompt_data["secondary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "negative_prompt":
            prompt_data["negative_prompt"] = prompt[node_id]["inputs"]["text"]

    return prompt_data

def getImg2ImgPrompt(prompt_str):
    prompt = json.loads(prompt_str)
    prompt_data = {}

    for param, node_id in IMG_2_IMG.items():
        if param == "seed":
            prompt_data["seed"] = prompt[node_id]["inputs"]["seed"]
        elif param == "checkpoint":
            if node_id not in prompt:
                return {}
            pipe_id = prompt[node_id]["inputs"]["pipe"][0]
            model_id = prompt[pipe_id]["inputs"]["model"][0]
            prompt_data["checkpoint"] = prompt[model_id]["inputs"]["ckpt_name"]
        elif param == "steps":
            prompt_data["steps"] = prompt[node_id]["inputs"]["Value"]
        elif param == "cfg":
            prompt_data["cfg"] = prompt[node_id]["inputs"]["Value"]
        elif param == "denoise":
            prompt_data["denoise"] = prompt[node_id]["inputs"]["Value"]
        elif param == "sampler_name":
            prompt_data["sampler_name"] = convertSamplerName(prompt[node_id]["inputs"]["sampler_name"])
        elif param == "scheduler":
            prompt_data["scheduler"] = prompt[node_id]["inputs"]["scheduler"]
        elif param == "prompt_style":
            prompt_data["prompt_style"] = prompt[node_id]["inputs"]["style"]
        elif param == "primary_prompt":
            prompt_data["primary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "secondary_prompt":
            prompt_data["secondary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "negative_prompt":
            prompt_data["negative_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "upscale_model":
            prompt_data["upscale_model"] = prompt[node_id]["inputs"]["model_name"]


    return prompt_data

def getUltimateSDUpscalePrompt(prompt_str):
    prompt = json.loads(prompt_str)
    prompt_data = {}

    for param, node_id in ULTIMATE_SD_UPSCALE.items():
        if param == "seed":
            prompt_data["seed"] = prompt[node_id]["inputs"]["seed"]
        elif param == "checkpoint":
            if node_id not in prompt:
                return {}
            pipe_id = prompt[node_id]["inputs"]["pipe"][0]
            model_id = prompt[pipe_id]["inputs"]["model"][0]
            prompt_data["checkpoint"] = prompt[model_id]["inputs"]["ckpt_name"]
        elif param == "steps":
            prompt_data["steps"] = prompt[node_id]["inputs"]["Value"]
        elif param == "cfg":
            prompt_data["cfg"] = prompt[node_id]["inputs"]["Value"]
        elif param == "denoise":
            prompt_data["denoise"] = prompt[node_id]["inputs"]["Value"]
        elif param == "sampler_name":
            prompt_data["sampler_name"] = convertSamplerName(prompt[node_id]["inputs"]["sampler_name"])
        elif param == "scheduler":
            prompt_data["scheduler"] = prompt[node_id]["inputs"]["scheduler"]
        elif param == "prompt_style":
            prompt_data["prompt_style"] = prompt[node_id]["inputs"]["style"]
        elif param == "primary_prompt":
            prompt_data["primary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "secondary_prompt":
            prompt_data["secondary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "negative_prompt":
            prompt_data["negative_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "upscale_model":
            prompt_data["upscale_model"] = prompt[node_id]["inputs"]["model_name"]

    return prompt_data

def getAfterDetailerPrompt(prompt_str):
    prompt = json.loads(prompt_str)
    prompt_data = {}

    for param, node_id in AFTER_DETAILER.items():
        if param == "seed":
            prompt_data["seed"] = prompt[node_id]["inputs"]["seed"]
        elif param == "checkpoint":
            if node_id not in prompt:
                return {}
            pipe_id = prompt[node_id]["inputs"]["pipe"][0]
            model_id = prompt[pipe_id]["inputs"]["model"][0]
            prompt_data["checkpoint"] = prompt[model_id]["inputs"]["ckpt_name"]
        elif param == "steps":
            prompt_data["steps"] = prompt[node_id]["inputs"]["Value"]
        elif param == "cfg":
            prompt_data["cfg"] = prompt[node_id]["inputs"]["Value"]
        elif param == "denoise":
            prompt_data["denoise"] = prompt[node_id]["inputs"]["Value"]
        elif param == "sampler_name":
            prompt_data["sampler_name"] = convertSamplerName(prompt[node_id]["inputs"]["sampler_name"])
        elif param == "scheduler":
            prompt_data["scheduler"] = prompt[node_id]["inputs"]["scheduler"]
        elif param == "prompt_style":
            prompt_data["prompt_style"] = prompt[node_id]["inputs"]["style"]
        elif param == "primary_prompt":
            prompt_data["primary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "secondary_prompt":
            prompt_data["secondary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "negative_prompt":
            prompt_data["negative_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "detector_model":
            prompt_data["detector_model"] = prompt[node_id]["inputs"]["model_name"]

    return prompt_data

def getInpaintPrompt(prompt_str):
    prompt = json.loads(prompt_str)
    prompt_data = {}

    for param, node_id in INPAINT.items():
        if param == "seed":
            prompt_data["seed"] = prompt[node_id]["inputs"]["seed"]
        elif param == "checkpoint":
            if node_id not in prompt:
                return {}
            pipe_id = prompt[node_id]["inputs"]["pipe"][0]
            model_id = prompt[pipe_id]["inputs"]["model"][0]
            prompt_data["checkpoint"] = prompt[model_id]["inputs"]["ckpt_name"]
        elif param == "steps":
            prompt_data["steps"] = prompt[node_id]["inputs"]["Value"]
        elif param == "cfg":
            prompt_data["cfg"] = prompt[node_id]["inputs"]["Value"]
        elif param == "denoise":
            prompt_data["denoise"] = prompt[node_id]["inputs"]["Value"]
        elif param == "sampler_name":
            prompt_data["sampler_name"] = convertSamplerName(prompt[node_id]["inputs"]["sampler_name"])
        elif param == "scheduler":
            prompt_data["scheduler"] = prompt[node_id]["inputs"]["scheduler"]
        elif param == "prompt_style":
            prompt_data["prompt_style"] = prompt[node_id]["inputs"]["style"]
        elif param == "primary_prompt":
            prompt_data["primary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "secondary_prompt":
            prompt_data["secondary_prompt"] = prompt[node_id]["inputs"]["text"]
        elif param == "negative_prompt":
            prompt_data["negative_prompt"] = prompt[node_id]["inputs"]["text"]
    
    return prompt_data

def convertSamplerName(name):
    if name == "euler":
        return "Euler"
    elif name == "euler_ancestral":
        return "Euler a"
    elif name == "heun":
        return "Heun"
    elif name == "dpm_2":
        return "DPM2"
    elif name == "dpm_2_ancestral":
        return "DPM2 a"
    elif name == "lms":
        return "LMS"
    elif name == "dpm_fast":
        return "DPM fast"
    elif name == "dpm_adaptive":
        return "DPM adaptive"
    elif name == "dpmpp_2s_ancestral":
        return "DPM++ 2S a"
    elif name == "dpmpp_sde":
        return "DPM++ SDE"
    elif name == "dpmpp_sde_gpu":
        return "DPM++ SDE"
    elif name == "dpmpp_2m":
        return "DPM++ 2M"
    elif name == "dpmpp_2m_sde":
        return "DPM++ 2M SDE"
    elif name == "dpmpp_2m_sde_gpu":
        return "DPM++ 2M SDE"
    elif name == "dpmpp_3m_sde":
        return "DPM++ 3M SDE"
    elif name == "dpmpp_3m_sde_gpu":
        return "DPM++ 3M SDE"
    elif name == "ddim":
        return "DDIM"
    elif name == "uni_pc":
        return "UniPC"
    elif name == "uni_pc_bh2":
        return "UniPC"
    else:
        return name

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                          'icon-3.ico',mimetype='image/vnd.microsoft.icon')

@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['file']
    image = Image.open(file)
    metadata = image.info
    for key, value in metadata.items():
        if key == "prompt":
            prompt_data = {
                "txt2img": getTxt2ImgPrompt(value),
                "img2img": getImg2ImgPrompt(value),
                "ultimate_sd_upscale": getUltimateSDUpscalePrompt(value),
                "after_detailer": getAfterDetailerPrompt(value),
                "inpaint": getInpaintPrompt(value)
            }
            return Response(json.dumps(prompt_data), mimetype='application/json')
    
    return Response(json.dumps({"error": "No prompt metadata found"}), mimetype='application/json')

@app.route('/save', methods=['POST'])
def save():
    file = request.files['file']
    prompt = request.form['prompt']
    json_prompt = json.loads(prompt)
    filename = "civitai_" + file.filename
    image = Image.open(file)
    metadata = PngImagePlugin.PngInfo()

    parameters = ""
    if "primary_prompt" in json_prompt:
        parameters += json_prompt["primary_prompt"] + " . "
    if "secondary_prompt" in json_prompt:
        parameters += json_prompt["secondary_prompt"] + " "
    if "negative_prompt" in json_prompt:
        parameters += "Negative prompt: " + json_prompt["negative_prompt"]
    if "steps" in json_prompt:
        parameters += f"\nSteps: {json_prompt['steps']}, "
    if "sampler_name" in json_prompt:
        parameters += "Sampler: " + json_prompt["sampler_name"] + ", "
    if "base_sampler_name" in json_prompt:
        parameters += "Sampler: " + json_prompt["base_sampler_name"] + ", "
    if "cfg" in json_prompt:
        parameters += f"CFG scale: {json_prompt['cfg']}, "
    if "base_cfg" in json_prompt:
        parameters += f"CFG scale: {json_prompt['base_cfg']}, "
    if "seed" in json_prompt:
        parameters += f"Seed: {json_prompt['seed']}, "
    if "checkpoint" in json_prompt:
        parameters += "Model: " + json_prompt["checkpoint"].split(".", 1)[0] + ", "
    if "base_checkpoint" in json_prompt:
        parameters += "Model: " + json_prompt["base_checkpoint"].split(".", 1)[0] + ", "
    if "denoise" in json_prompt:
        parameters += f"Denoising strength: {json_prompt['denoise']}, "
    
    parameters += "Hashes: {}"

    metadata.add_text('parameters', parameters)
    image.save("saved/" + filename, pnginfo=metadata)
    return Response(json.dumps({"filename": filename}), mimetype='application/json')

def open_browser(port):
      webbrowser.open(f"http://127.0.0.1:{port}")

if __name__ == '__main__':
    if not os.path.isdir("saved"):
        os.mkdir("saved")

    port = 6008
    Timer(1, open_browser, [port]).start()
    app.run(port=port)
