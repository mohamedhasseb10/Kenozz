Swift Project Template
---
---

## Summary

This document provides an overview of the development of Modules and Applications .

## Supported OS versions

Minimum Target : iOS 10.0

## Programming languages

Swift 4.2 or higher .

## Architecture

In this section, we demonstrate which used structure in IOS Base Repo   is **The Modular Architecture**.

#### Overview 

Consider the following diagrams, that show how IOS Base Repo layers will interact with each others

![image](/uploads/95e20bb1b62837affdb0d8978f620153/Items.png)


## Platform Architecture

IOS Base Repo developed based on Modular Architecture .

There are 3 main layers in platform: 

![image](/uploads/41ae73881766290a735e112ca61f1a53/Items-5.png)

As see in above diagram:
### Application Layer:

This layer responsible to define the following configuration:
1. Environment (Development, Staging & Production) 
2. Target/Product flavors: The app must has specific variables.
   - Backend Application ID
   - Backend Organisation ID
   - Target/Product name
   - Target/Product bundle/application id

### Features Layer

This layer includes business features like (Login, Registration, etc...)

#### Every feature includes:
1. UI: to describe how user will interact with feature
2. Business: to define feature business requirements


### Core Layer

This layer includes funcational modules like (Networking, Logging, Analytics & etc...) to facilitate on other platform layers (Application & Features)

## MVVM - Desgin Pattern 

Each feature/Module use MVVM(Model view view-model) Architecture as the below diagram:

![image](/uploads/4db6787de9836adf1f189d7eed32216a/Items-6.png)

### Presentation Stage:
This layer comprises UI components and UI process components .

Being at this layer, the feature has to define the way the mobile app will present it in front of the end users

 this layer includes all classes of type:
- View controller
- View

### Business Stage:
As the name suggests, the layer focuses on the business front. In simple language it focuses on the way business will be presented in front of the end users.

This includes workflows, business components and requirements such as filter, sort & mapping the UI data

This layer includes all classes of type "ViewModel"

### Data Stage:
At this third stage data related factors are kept in mind. This includes Data access components, data helpers/utilities, and service agents.

This layer responsible to provide the different data sources such as Network, KeyChain, Core data, Files

To access this layer there is module called (Data-Module),This module built on Repository pattern to Save,Get & Cache any kind of data

## General notes:
- MVVM (Mode View-View Model) is the used pattern across all application modules .
- (Core layer) is abstracted layer, it doesn't know anything about application features and business needs.
- (Core layer) can be moved from application to another.
- (Feature layer) modules can be used by Application layer or another module in same layer

# Developer

- Fork this repo to the new group created for the project.
- Install CocoaPods on your machine
- `cd` to the project directory
- Run Command 'pod install'

# Setting up correct Environment

- navigate to info.plist file and change OrganizationID and AppID values .
- change Base_URL, Registration_URL and Account_URL values in :
    1. BASE_URL = https:/$()/put-BaseUrl- here
    2. REGISTRATION_URL = https:/$()/put-RegistrationBaseUrl-here
    3. ACCOUNT_URL = https:/$()/dev-put-AccountBaseUrl-here


Now, your project is set up and you can go ahead to create modules for your features.
