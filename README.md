<a name="readme-top"></a>
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow">
    <img src="assets/icon.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">SDXL ComfyUI Ultimate Workflow</h3>

  <p align="center">
    Everything you need to generate amazing images! Unlimited potential to define your own image processing flow with easy to use workflow.
    <br />
    <a href="https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow">View Demo</a>
    ·
    <a href="https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow/issues">Report Bug</a>
    ·
    <a href="https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![SDXL Ultimate Workflow Cover][product-screenshot]](https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow)

SDXL Ultimate Workflow is a powerful and versatile workflow that allows you to create stunning images with SDXL 1.0 and SD 1.5. Whether you want to generate realistic portraits, landscapes, animals, or anything else, you can do it with this workflow. You can use multiple Checkpoints, LoRAs/LyCORIS, ControlNets, and more to create complex image generation flows with ease.

This workflow has many features that make it easy to use and set up. With the included install script and update script, you can set get started with one click. Inside the workflow, you can use the quick settings controls to adjust the settings for each image generation and processing module. You can also use the AfterDetailer to fix the faces, hands, and bodies of your generated images, or use the Face Restore included in each module to touch up the results. The included metadata extractor application gives you the ability to quickly view and save the image metadata in Automatic1111 format, which adds autofill for CivitAI uploads.

SDXL Ultimate Workflow is the best and most complete single workflow that exists for SDXL 1.0 and SD 1.5. It has many upscaling options, such as img2img upscaling and Ultimate SD Upscale upscaling. It also has full inpainting support to make custom changes to your generations.

If you have any questions or feedback about SDXL Ultimate Workflow, please feel free to contact us at betherobot.sd@gmail.com. We would love to hear from you and help you with any issues you may have. Thank you for choosing the SDXL Ultimate Workflow as your image generation tool!

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Python][Python.org]][Python-url]
* [![Bootstrap][Bootstrap.com]][Bootstrap-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* Download the included zip file containing the latest SDXL Ultimate Workflow files
* Install Git at [git-scm.com](https://git-scm.com/download/win)

### Clean Installation (Recommended)

1. Extract the workflow zip file
2. Copy the `install-comfyui.bat` file to the directory where you want to set up ComfyUI
3. Double click the `install-comfyui.bat` file to run the script
4. Wait while the script downloads the latest version of ComfyUI Windows Portable, along with all the latest required custom nodes and extensions
5. OPTION 1: Once the script has finished, rename your `ComfyUI/extra_model_paths.yaml.example` to `ComfyUI/extra_model_paths.yaml` and update it to point to your models
6. OPTION 2: Move your existing models to the `ComfyUI/models/...` directories
7. Start ComfyUI by running the `run_nvidia_gpu.bat` file



### Update Existing Installation (Quickest)

1. Extract the workflow zip file
2. Copy the `update-comfyui.bat` file to your `ComfyUI/` directory
3. Double click the `update-comfyui.bat` file to run the script
4. Wait while the script updates ComfyUI, custom nodes, and all dependencies to their latest version
5. Start ComfyUI by running the `run_nvidia_gpu.bat` file


### Update Existing Installation with ComfyUI Manager (Not Recommended)

1. Extract the workflow zip file
2. Start ComfyUI by running the `run_nvidia_gpu.bat` file
3. Click "Load" in ComfyUI and select the `SDXL-ULTIMATE-WORKFLOW.json` file
4. Launch the ComfyUI Manager using the sidebar in ComfyUI
5. Click "Install Missing Custom Nodes" and install/update each of the missing nodes
6. Click "Install Models" to install any missing models



<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

TO-DO

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Add ControlNet / ControlNet Preprocessors
- [x] Add Face Restore
- [x] Add After Detailer
- [ ] Add usage tips and examples
- [ ] Add CLIPVision workflow
- [ ] Add Multi-ControlNet support for each module
- [ ] TBD...

See the [open issues](https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

BeTheRobot - [@BeTheRobot](https://civitai.com/user/BeTheRobot/models) - betherobot.sd@gmail.com

Project Link: [https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow](https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

Nodes, tools, and extensions used in this workflow.

* [ComfyUI Impact Pack](https://github.com/ltdrdata/ComfyUI-Impact-Pack)
* [WAS Node Suite](https://github.com/WASasquatch/was-node-suite-comfyui)
* [Comfyroll CustomNodes](https://github.com/RockOfFire/ComfyUI_Comfyroll_CustomNodes)
* [Derfuu Modded Nodes](https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes)
* [UltimateSDUpscale](https://github.com/ssitu/ComfyUI_UltimateSDUpscale)
* [SDXL Prompt Styler](https://github.com/twri/sdxl_prompt_styler)
* [ControlNet Preprocessors](https://github.com/Fannovel16/comfyui_controlnet_aux)
* [Comfy MTB](https://github.com/melMass/comfy_mtb)
* [rgtrhee Comfy Nodes](https://github.com/rgthree/rgthree-comfy)
* [Efficiency Nodes](https://github.com/LucianoCirino/efficiency-nodes-comfyui)
* [Failfa.st Extensions](https://github.com/failfa-st/failfast-comfyui-extensions)
* [TencentARC GFPGAN](https://github.com/TencentARC/GFPGAN)


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/BeTheRobotSD/sdxl-comfyui-ultimate-workflow.svg?style=for-the-badge
[contributors-url]: https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/BeTheRobotSD/sdxl-comfyui-ultimate-workflow.svg?style=for-the-badge
[forks-url]: https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow/network/members
[stars-shield]: https://img.shields.io/github/stars/BeTheRobotSD/sdxl-comfyui-ultimate-workflow.svg?style=for-the-badge
[stars-url]: https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow/stargazers
[issues-shield]: https://img.shields.io/github/issues/BeTheRobotSD/sdxl-comfyui-ultimate-workflow.svg?style=for-the-badge
[issues-url]: https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow/issues
[license-shield]: https://img.shields.io/github/license/BeTheRobotSD/sdxl-comfyui-ultimate-workflow.svg?style=for-the-badge
[license-url]: https://github.com/BeTheRobotSD/sdxl-comfyui-ultimate-workflow/blob/master/LICENSE.txt
[product-screenshot]: assets/COVER-v3_2.png

[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[Python.org]: https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white
[Python-url]: https://python.org