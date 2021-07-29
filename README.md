# Water Assistant #

_______________________________________________________________________________________________________________________________________________

## What is Water Assistan? ##
Water Assistant is a mobile application that provides solutions for people who live in areas with scarce water resources and severe water pollution, and are facing water-related problems caused by climate change. In these areas, it is hard for people to obtain sufficient clean water. Due to lack of water for drinking or irrigation, the safety of their lives and property cannot be guaranteed. Water Assistant uses artificial intelligence to help residents in these areas obtain water quality information in time and grasp changes in water sources in advance, so as to take active measures to deal with water dilemmas. The steps for users to get assistance are as follows. Firstly, IBM IoT is applied to obtain real-time water quality data from various places, and display them on the water source map for users to view at any time. Secondly, based on IBM Cloud Pak for Data and Machine Learning services, users can learn about the trends of water quality and water depth in the surrounding area for a period of time in the future, and take measures in advance to reduce the risk of water pollution or water shortage caused by climate change. Finally, with the help of the IBM Watson Assistant service, users can obtain not only water quality information but also how to save water and get access to healthy water under the current status of water resources by chatting with robots. Water Assistant provides solutions for residents in water-poor areas to improve the quality of users’ life.


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
Water resources are the cornerstone of development and continuation of life on earth, while they are the natural resources most threatened by climate change. According to data from the World Health Organization, 2.2 billion people worldwide do not have access to safe and healthy drinking water. Besides, 80 countries and regions, which account for about 40% of the world’s population, suffer from severe water shortages. A series of water-related problems, such as water scarcity and water pollution, have seriously threatened the economic development and residents' health in these countries and regions. In these areas, it is often difficult for people to develop  industries which have highly demand of water resources, such as chemical industry and agriculture, resulting in a lack of motivation for economic development. Besides, water resources are obviously affected by the weather. People in these areas cannot learn about water source changes or weather warnings ahead of time due to lack of information sources, and that is the reason why they have low anti-risk capabilities and can only passively endure water pollution or water shortages caused by severe weather. What’s more, because there is no Internet or mobile devices, it is hard for these residents to master the knowledge and skills of water usage, and they do not know what measures should be taken to prevent risks. Real-time water quality information, water shortage early warning and water usage skills would break the above vicious circle and ensure the residents’ personal safety and quality of life in these areas.


### How can technology help?

* A water source map allowing users to check the nearby water information at any time
* Prediction of water sources change, including water quality and water depth
* Chatting with expert tools through artificial intelligence robots to share knowledge and skills related to water usage, water conservation, clean water access, etc.

Obtaining real-time water source data, changes in water conditions for a period of time in the future, and responding to these changes in time are essential for residents in water-deficient areas to get rid of their predicament. Water Assistant brings advanced Internet of Things technology and artificial intelligence to underdeveloped areas, lowering the threshold of technology use, so that enables everyone in the world get sufficient and clean water as well as enjoy the improvement of the quality of life bringing by technological development. With Watson IoT Platform, Cloud Pak for Data, Machine Learning, Watson Assistant and other services provided by IBM, Water Assistant uses PHP, AngularJS, NodeJS, Python, iOS and other technologies to dynamically display real-time water source data and water source changes. Water Assistant alleviate water resources problems for users from the source by means of early warning and popularization of skills.


## Demo Video <a name="Demo-Video"></a>
[![Demo Video](https://github.com/long122021/Water-Assistant/blob/master/cover.png?raw=ture)](https://www.youtube.com/watch?v=YDZhK_8l9pQ&t=29s "DEMO VIDEO")

## Demo APP <a name="Demo-APP"></a>
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/app_1.GIF?raw=true)
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/app_2.GIF?raw=true)
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/app_3.GIF?raw=true)
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/app_4.GIF?raw=true)

## How it works <a name="How-it-works"></a>
![picture alt](https://github.com/long122021/Water-Assistant/blob/master/Architecture.png?raw=true)
1. We use IoT water quality monitoring equipment to monitor water source information, and then store the data in the Cloudant database. IoT Plantform manages these devices so as to generate the water source map on Water Assistant.
2. To analyze the relationship between weather and water resources，we use 4 weather-related indicators of temperature, humidity, wind speed, and rainfall  as independent variables, water quality level and water level as dependent variables. IBM Cloud Pak for Data is used to clean and process historical data, and IBM Machine Learning is used to train the processed data to get the machine learning model. We select multiple machine learning models, such as decision tree, XGBoost, random forest, linear regression and so on. Machine Learning service automatically performs feature engineering, and comprehensively considers running time, accuracy and other indicators of different models to select the best. Finally, the weather data obtained from The Weather Company is applied on the best model to predict water quality and water depth in the future.
3. Constructing a chatting rebot based on Watson Assistant to provide users with self-service inquiries about water source information and water utilization related knowledge and skills.


## Project Roadmap <a name="Project-Roadmap"></a>
<div  align="center">    
<img src="https://github.com/long122021/Water-Assistant/blob/master/Roadmap.png?raw=true" width="50%" height="50%">
</div>

* In the first stage, we focused on using the Internet of Things technology to monitor water quality and water depth, build a water source map, and provide users with the possibility to view water source information at any time.
* In the second stage, we pay attention to train models predicting water source changes, provide users with water quality and water depth trends, and propose countermeasures to deal with water-related problems.
* In the third stage, we improve the chatting robot to realize self-service query of the nearest clean water source and navigate to it. According to users’  needs, we recommend water resources utilization schemes such as agricultural irrigation and animal husbandry.

## Getting Started <a name="Getting-Started"></a>

#### Prerequisite
* Register for an [IBM Cloud account](https://www.ibm.com/account/reg/us-en/signup?formid=urx-42793&eventid=cfc-2020).
* Request a [Weather Company API key](https://callforcode.weather.com/)
* Register for an [Apple ID](https://appleid.apple.com/account)

#### Run it
* Download the Github code
* Install node.js
* After deploying the nodejs service, start from server.js
* Use Xcode to build an iOS package

## IBM Cloud Services <a name="IBM-Cloud-Services"></a>
* [IBM Cloud Object Storage](https://www.ibm.com/cloud/object-storage)
* [IBM Watson Studio](https://www.ibm.com/cloud/watson-studio)
* [IBM Watson Assistant](https://www.ibm.com/cloud/watson-assistant/)
* [The Weather Company API](https://callforcode.weather.com/)


## Authors <a name="Authors"></a>
* Yuanlong He - Product and software developers, system designer
* Yao Yao - Artificial intelligence engineer
* Yanan Huang - Web developer
* Zhibo Zi - Software developer
* Tianhao Wang – UI designer

## License <a name="License"></a>
This project is licensed under the Apache 2 License - see the [ LICENSE ](https://github.com/long122021/Water-Assistant/blob/master/LICENSE)
for details.
