# okoul_challenge_recipes_flutter

Okoul Challenge
I participated in the Okoul Challenge - Recipes and developed a Flutter application to showcase our skills. Check out the challenge link to learn more about the requirements and see my solution in action.


Goal: Implement clean architecture principles in a Flutter app using Riverpod as a state management library and work with an API that provides recipe-related data to demonstrate its practical use. This project aims to achieve measurable progress by setting clear goals as requested by Okoul company.

<div style="background-color: #f5f5f5; padding: 20px; border-radius: 50%; border: 5px solid #008000; display: inline-block;">
  <h3 style="color: #333;">Note</h3>
  <p style="font-size: 16px;">You can try this app on the web since Flutter supports web deployment. We created the app for Android and iOS, but wanted to make it available on the web as well.</p>
  <p style="font-size: 16px;">Check out the <a href="https://recipes-challenge-752f0.web.app/" style="color: #008000; text-decoration: none;">recipeX web preview</a> to see it in action.</p>
</div>

 

## Table of Contents

1. [Introduction](#introduction)
    - [Project description](#project-description)
    - [Screenshots or demo videos](#screenshots-or-demo-videos)


2. [app architecture](#app-architecture)
3. [Project Structure](#project-structure)

4. [Packages](#packages)
    - [List of packages](#list-of-packages)

5. [License](#license)
    - [License information](#license-information)

6. [Contact](#contact)
    - [Contact information](#contact-information)
7. [Acknowledgments](#acknowledgments)
8. [Designer](#designer) 
9. [Photo/Video Gallery](#photovideo-gallery)

## Introduction

### Project description

# okoul_challenge_recipes_flutter project

This project aims to develop a mobile app using Flutter framework that enables users to search, view, and save recipes from the Tasty API. The app will feature a search field for users to enter their queries and display the relevant recipes in a list view. Clicking on a recipe in the list will navigate the user to a recipe details screen, which will show the recipe name, photo, rating, ingredients, and instructions. The app will also allow users to add and remove recipes from their favorites list, and it should have a well-designed and maintainable codebase, incorporating good programming practices such as modularization and separation of concerns.

### Screenshots or demo videos

<div style="background-color: #f5f5f5; padding: 20px; border-radius: 50%; border: 5px solid #008000; display: inline-block;">
  <h3 style="color: #333;">Note</h3>
  <p style="font-size: 16px;">You can try this app on the web since Flutter supports web deployment. We created the app for Android and iOS, but wanted to make it available on the web as well.</p>
  <p style="font-size: 16px;">Check out the <a href="https://recipes-challenge-752f0.web.app/" style="color: #008000; text-decoration: none;">recipeX web preview</a> to see it in action.</p>
</div>


We understand that seeing our project in action is essential to understanding its full potential. That's why we've included screenshots and demo videos to showcase our project's UI and functionality.

But we also want to acknowledge the incredible work of our UI/UX designer,  Fatimah Alamoudi, who has been instrumental in creating the stunning visuals and intuitive user experience that you see in these screenshots and demo videos.

To learn more about  Fatimah Alamoudi and her contributions to our project, check out the [Designer](#designer)  section below .


Note to see all the UI and video go to this section: [Photo/Video Gallery](#photovideo-gallery)

## Use Cases

| Use Case Number | Use Case Name           | UI                         |
|-----------------|-------------------------|---------------------------|
| 1               | Search for Recipes      |                            |
| 2               | Display Search Results  |                            |
| 3               | View Recipe Details     |                            |
| 4               | Add Recipe to Favorites |                            |
| 5               | Remove Recipe from Favorites |                      |
| 6               | Search for Favorite Recipes |                          |



 # App Architecture
 
Note: The architecture shown below is the full architecture that we implement for complex features. For simple features, you may not see all the layers of the application, as they are not required. We only add extra layers when we have a complete feature.


 ## Image :
 ![Riverpod arch image]

 ![architecture](https://user-images.githubusercontent.com/67343431/233339494-c8bfc94b-b9ad-443b-aa46-0bee3e313c6e.png)


## Presentation Layer
The **Presentation Layer** in Flutter refers to the visual aspect of an application, including the user interface and its display on the screen. It is responsible for rendering the UI components, managing the widget state, and facilitating communication with the data layer. In Flutter, the presentation layer is usually implemented using widgets, which are building blocks that can be combined to create the final user interface. The presentation layer is crucial in determining the overall look and feel of the application and its user experience.

A **Controller** in the presentation layer acts as a bridge between the UI components and the data layer, regulating the widget state and displaying the correct data on the screen. It also handles user interactions and updates the application state accordingly. By separating the business logic from the presentation layer, the controller helps create a clean and maintainable architecture, making it easier to develop and test the application.

## Application Layer
The **Architecture-Application Layer** implements application-specific functionality by accessing the relevant data storage as needed. It is not responsible for managing and updating the component state (that's the job of the Controller) or data parsing and serialization (that's the job of the data storage).

## Domain Layer
The **Domain Layer** implements the core business logic of an application. It represents the business domain and encapsulates the business rules and processes specific to that domain. By isolating it from the presentation and data layers, the domain layer helps ensure separation of concerns and makes the code easier to maintain and extend.

The domain layer defines entities and services needed to implement the business logic. It contains the core classes and interfaces that define the behavior and rules of the application and serves as the source of truth for how the application should behave. By separating the business logic from the presentation and data layers, the domain layer helps make the code more modular and testable.

A well-designed domain layer provides a clear definition of the business domain and ensures the application accurately reflects the underlying business processes and rules. This leads to a maintainable, scalable, and easily extensible application.

## Repository Layer
The **Repository Layer** is a software design pattern that manages data access in an application. It acts as an intermediary between the application and the data source, providing a consistent interface for data access. The repository pattern improves separation of concerns and code maintainability and can be used to abstract the data access code from the rest of the application, making it easier to change the underlying data source without affecting the rest of the application.


## Project Structure
The project is structured into the following folders:
**Note** we will follow the **Feature-first (layers inside features)**

- `common_widgets`: Contains reusable widgets that are used throughout the project.

- `constants`: Holds any constant values used in the project, such as colors, font sizes, etc.

- `features`: Separate folder for each feature of the project, such as a Login feature.

- # Single Feature

This repository contains code for a specific feature. The code is organized into two main folders: `Domain` and `Presentation`.

### Domain

The `Domain` folder holds the code related to the business logic and data access of the feature.

### Model

The `Model` folder contains the data models for the feature. These models define the structure of the data used in the feature.

### Repo

The `Repo` folder contains the repository for the feature. The repository is responsible for retrieving and storing data.

## Presentation

The `Presentation` folder holds the code related to the user interface and user interactions of the feature.

### Controller

The `Controller` folder contains the logic for handling user interactions. It communicates with the domain to retrieve and manipulate data, and updates the screen with the results.

### Screen

The `Screen` folder contains the visual components for displaying information to the user. It receives updates from the controller and displays the information accordingly.


- `keys`: Stores key values for accessing elements in the project, such as keys for accessing a particular widget (when needing it we addint it ).

- `routing`: Contains routing information for navigating between pages in the project.

- `utils`: Contains utility classes and functions that are used throughout the project.

## Packages

### List of packages

| Package Name | Version | Description | Link |
| ------------ | ------- | ----------- | ---- |
| flutter_svg | ^2.0.5 | For displaying svg images | [Link](https://pub.dev/packages/flutter_svg) |
| connectivity | ^3.0.6 | To keep watching user connections | [Link](https://pub.dev/packages/connectivity) |
| flutter_riverpod | ^2.1.3 | For state management | [Link](https://pub.dev/packages/flutter_riverpod) |
| go_router | ^6.0.1 | For handling the routing in the app | [Link](https://pub.dev/packages/go_router) |
| http | ^0.13.5 | For sending http request | [Link](https://pub.dev/packages/http) |
| shared_preferences | ^2.0.17 | For storing the user preferences | [Link](https://pub.dev/packages/shared_preferences) |
| shimmer | ^2.0.0 | For showing to the user amazing loading screens | [Link](https://pub.dev/packages/shimmer) |


## License

### License information

This project is licensed under the MIT License - see the [LICENSE](https://github.com/username/my_flutter_project/blob/master/LICENSE) file for details.

## Contact

### Contact information

<div align="center">
  <a href="mailto:ahmedfouadali1213@gmail.com">
    <img src="https://img.shields.io/badge/Email-ahmedfouadali1213%40gmail.com-red?style=for-the-badge&logo=gmail"/>
  </a>&nbsp;&nbsp;
  <a href="https://twitter.com/AhmedFouadAli9">
    <img src="https://img.shields.io/badge/Twitter-%40AhmedFouadAli9-blue?style=for-the-badge&logo=twitter"/>
  </a>&nbsp;&nbsp;
  <a href="https://www.linkedin.com/in/ahmed-fouad-ali/">
    <img src="https://img.shields.io/badge/LinkedIn-Ahmed%20Fouad%20Ali-blue?style=for-the-badge&logo=linkedin"/>
  </a>
</div>


## Acknowledgments

Special thanks to [Okoul](https://www.okoul.com/) for providing the challenge that inspired this project. Their commitment to providing opportunities for students to apply what they learn in real projects is greatly appreciated.

## Designer
I am absolutely thrilled to give a big shoutout to the one and only Fatimah Alamoudi, our incredible UI/UX designer!  Fatimah Alamoudi boundless talent, unbridled creativity, and unwavering dedication have transformed our project into something truly extraordinary.

Her meticulous attention to detail, sharp creative vision, and unparalleled passion for design are truly inspiring. Working with her has been an absolute joy and privilege, and we could not have asked for a better collaborator and partner.

If you're blown away by Fatimah Alamoudi's work, we encourage you to follow her on <a href="https://twitter.com/AlamoudiBy">Twitter</a> and check out her portfolio to see more of her amazing designs. If you're looking for a top-notch UI/UX designer who will elevate your project to new heights, don't hesitate to contact her on <a href="https://twitter.com/AlamoudiBy">Twitter</a>.

### Contact information with designer

<div align="center">
  <a href="https://www.behance.net/fatimahalamoudi">
    <img src="https://img.shields.io/badge/Behance-fatimahalamoudi-blue?style=for-the-badge&logo=behance"/>
  </a>&nbsp;&nbsp;
  <a href="https://twitter.com/AlamoudiBy">
    <img src="https://img.shields.io/badge/Twitter-Fatimah_Ahmed_Alamoudi-blue?style=for-the-badge&logo=twitter"/>
  </a>&nbsp;&nbsp;
  <a href="https://www.linkedin.com/in/fatimah-ahmed-alamoudi/">
    <img src="https://img.shields.io/badge/LinkedIn-Fatimah_Ahmed_Alamoudi-blue?style=for-the-badge&logo=linkedin"/>
  </a>
</div>


## Photo/Video Gallery

| Image 1 | Image 2 | Image 3 |
|---------|---------|---------|
| <img src="https://user-images.githubusercontent.com/67343431/233356384-efe545ec-3fc9-4edd-b2ac-166325db0dda.jpg" width="150"> | <img src="https://user-images.githubusercontent.com/67343431/233356390-477ce341-e60c-499a-9d19-0e7a2d9ac6cf.jpg" width="150"> | <img src="https://user-images.githubusercontent.com/67343431/233356394-75425e1d-f318-4e43-8f82-6f88487538f4.jpg" width="150"> |
| Image 4 | Image 5 | Image 6 |
| <img src="https://user-images.githubusercontent.com/67343431/233356397-25260bbc-49de-49bd-94a5-54b70654abbd.jpg" width="150"> | <img src="https://user-images.githubusercontent.com/67343431/233356401-0a8f4ba1-e52f-4c21-8dbe-4f595a03eed6.jpg" width="150"> | <img src="https://user-images.githubusercontent.com/67343431/233356406-e79ba460-37f1-4a98-a061-755be6ad442c.jpg" width="150"> |
| Image 7 | Image 8 | Image 9 |
| <img src="https://user-images.githubusercontent.com/67343431/233356408-1bbbea9d-44ea-4e4b-8c11-fa2e22cf2923.jpg" width="150"> | <img src="https://user-images.githubusercontent.com/67343431/233356410-75b7cae5-9e79-412f-b550-1478ec87d429.jpg" width="150"> | <img src="https://user-images.githubusercontent.com/67343431/233356416-14d9b84e-c5af-44de-8ebd-3227795ad96e.jpg" width="150"> |
| Image 10 |
| <img src="https://user-images.githubusercontent.com/67343431/233356422-e1011b38-90d2-4614-972e-de4ddede4809.jpg" width="150"> |


## video
[![Video](https://img.youtube.com/vi/XsyRFE10YpM/0.jpg)](https://www.youtube.com/watch?v=XsyRFE10YpM)
