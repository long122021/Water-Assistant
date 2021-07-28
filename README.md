# Water Assistant #

_______________________________________________________________________________________________________________________________________________

## What is Water Assistan? ##
Water Assistant是一种移动应用程序解决方案，可帮助水资源匮乏、水源污染地区的人们应对气候变化带来的水资源问题。在水污染严重、水资源匮乏的地区，人们难以获得充足的清洁水源。由于缺乏水源饮用或灌溉，他们的生命财产安全无法得到保障。Water Assistant使用AI技术，帮助这些地区的居民及时获取水质信息、提前掌握水质变化，从而采取积极措施应对水资源困境。首先我们使用IBM IoT获取各地水质实时数据，展示在水源地图上，供用户随时查看。其次，基于IBM Cloud Pak for Data及Machine Learning服务，用户能够得知未来一段时间内周边区域的水质及水深变化趋势，提前采取措施，降低天气变化带来的水污染或水资源短缺风险。最后，借助IBM Watson Assistant服务，用户可以通过聊天机器人获取水质信息，以及针对目前状况的水资源利用、节约用水、健康用水等相关用水方案。Water Assistant为水资源匮乏地区的居民提供解决方案，改善用户的生活质量。


## Contents

01. [Short Description](#Short-Description)
02. [Demo Video](#Demo-Video)
02. [Demo APP](#Demo-APP)
03. [How it works](#How-it-works)
06. [Project Roadmap](#Project-Roadmap)
07. [Getting Started](#Getting-Started)
08. [IBM Cloud Services](#IBM-Cloud-Services)
10. [Authors](#Authors)

## Short Description <a name="Short-Description"></a>

### What's the problem?
水资源是受气候变化威胁最大的自然资源，是地球上的生命延续和发展的先决条件。根据世界卫生组织的统计，全球有 22 亿人无法获得安全健康的饮用水，约占世界人口总数40%的80个国家和地区严重缺水。水资源匮乏、水源污染严重威胁着这些地区经济发展、人身健康。在这些地区，人们往往由于缺水，难以发展工业、农业等对于水资源需求较大的产业，导致经济水平落后。水资源受天气影响明显，这些地区的人们无法及时获取水源信息或天气预警，抗风险能力较低，只能被动承受恶劣天气带来的水质污染、水源短缺等困境。此外，因为缺少网络或移动设备，人们很难学到用水的知识与技能，不知道应该采取什么样的措施抵御风险。实时水质信息、水资源预警及用水技能将打破以上恶性循环，保障这些地区人们的人身安全及生活质量。


### How can technology help?

* 提供水源地图，能够让用户随时查看附近水源情况 .
* Real-time weather monitoring (*text and visual*).
* 预测水源变化（水质、水深）.
* 与专家工具交谈（使用人工智能机器人分享水资源利用、节约用水、健康用水等相关知识与技能）

获取实时水源数据、根据天气情况预测水源变化、针对水源变化提供解决方案，对于帮助水资源短缺地区的居民摆脱困境至关重要。Water Assistant将先进的物联网技术、AI技术带到欠发达地区，降低技术使用门槛，让全世界所有人都能够得到充足洁净的水源，享受到科技发展对于生活质量的改善。
Water Assistant借助IBM提供的Watson IoT Platform、Cloud Pak for Data、Machine Learning、Watson Assistant等服务，利用PHP、AngularJS、NodeJS、Python、iOS等技术，动态展示实时水源数据与未来水源变化，提前预警，科普技能，从源头缓解水资源问题对用户的困扰。


## Demo Video <a name="Demo-Video"></a>
[![Demo Video](https://github.com/long122021/Water-Assistant/blob/master/cover.png?raw=ture)]()

## Demo APP <a name="Demo-APP"></a>
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/app_1.GIF?raw=true)
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/app_2.GIF?raw=true)
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/app_3.GIF?raw=true)
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/app_4.GIF?raw=true)

## How it works <a name="How-it-works"></a>
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/Architecture.png?raw=true)
1. 使用物联网水质监测设备，监测水源信息，存储数据到Cloudant数据库，并由IoT Plantform管理物联网设备，在APP上生成水源地图.
2. 为分析天气与水质、水深之间存在的依赖关系，选取四个不同维度的天气指标（温度、湿度、降雨、风速）作为模型输入，水质类别（Ⅰ、Ⅱ、Ⅲ、Ⅳ、Ⅴ、劣Ⅴ）及水深分别作为模型输出。使用IBM Cloud Pak for Data对历史数据进行清洗及处理，将处理后的数据输入IBM Machine Learning服务。选择多个机器学习模型（决策树、XgBoost、随机森林、线性回归等），Machine Learning服务自动进行特征工程，并根据模型运行时间、准确率等指标综合考虑，选择效果最佳的模型。最后，从The Weather Company获取的天气信息，使用模型预测水质、水深变化。
3. 使用Watson Assistant创建聊天机器人，为用户提供自助查询水源信息、水源利用相关的知识与技能的服务。


## Project Roadmap <a name="Project-Roadmap"></a>
<div  align="center">    
<img src="https://github.com/long122021/Water-Assistant/blob/master/Roadmap.png?raw=true" width="50%" height="50%">
</div>

* 在第一阶段，我们专注于利用物联网技术，实现水质、水深监测，构建水源地图，给用户提供随时查看水源信息的可能.
* 第二阶段，侧重于训练预测模型，预测水源变化，为用户提供水质、水深变化趋势，提出应对措施等.
* 第三阶段，完善聊天机器人，实现自助查询最近洁净水源并导航前往；根据用户需求推荐农业灌溉、畜牧养殖等水资源利用方案等.

## Getting Started <a name="Getting-Started"></a>

#### Prerequisite
* 注册一个 [IBM Cloud account](https://www.ibm.com/account/reg/us-en/signup?formid=urx-42793&eventid=cfc-2020).
* 申请一个 [Weather Company API key](https://callforcode.weather.com/)
* 注册一个 [Apple ID](https://appleid.apple.com/account).

#### Run it
* 下载 Github 代码
* 安装 node.js
* 部署nodejs服务后，从server.js启动
* 使用XCode要构建一个 iOS 包

## IBM Cloud Services <a name="IBM-Cloud-Services"></a>
* [IBM Cloud Object Storage](https://www.ibm.com/cloud/object-storage)
* [IBM Watson Studio](https://www.ibm.com/cloud/watson-studio)
* [IBM Watson Assistant](https://www.ibm.com/cloud/watson-assistant/)
* [The Weather Company API](https://callforcode.weather.com/)   
  Check out Agrolly's website  repository database [click here](https://github.com/helentsai17/agrolly)


## Authors <a name="Authors"></a>
* Yuanlong He - 产品和软件开发人员，系统设计
* Yao Yao - 人工智能工程师
* Yanan Huang - 网络开发人员
* Zhibo Zi - 软件开发人员
* Wang Tianhao – UI设计师

## License <a name="License"></a>
This project is licensed under the Apache 2 License - see the [ LICENSE ](https://github.com/long122021/Water-Assistant/blob/master/LICENSE)
for details.
