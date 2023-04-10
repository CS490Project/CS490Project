
# PictureThis

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app allows people to draw pictures in a collage format. Friends will able to view other's pictures.

### App Evaluation
- **Category:** Social Networking / ART
- **Mobile:** On mobile devices only
- **Story:** Asks users daily to draw a portion of a picture and share it with friends. At the end of a period it will show a collage of all drawings.
- **Market:** Any person is able to use and enjory this app.
- **Habit:** This app is recomended to be used daily so that the collage is full.
- **Scope:** Our scope is connecting people all around the world and showing their creativity.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users can create an account and sign in COMPLETED ✔
* Users can choose a topic. COMPLETED ✔
* Users can add friends COMPLETED ✔
* Users are given a topic to draw each day COMPLETED ✔

**Optional Nice-to-have Stories**

* Vote button COMPLETED ✔
* Super nice UI COMPLETED ✔
* Brush thickness COMPLETED ✔
* Different types of brushes COMPLETED ✔

### 2. Screen Archetypes

* Login/Signup screen
   * Users can create an account COMPLETED ✔

* Collage/Post Viewer
   * Users can view their and friend's drawings. COMPLETED ✔
   * Users can view their own drawings COMPLETED ✔
   * Users can create a new drawing COMPLETED ✔

* Drawing Page
    * Users can view the new topic COMPLETED ✔
    * UI has a nice sketchpad with different options to draw the picture COMPLETED ✔
    * Allows user to post the picture for the day COMPLETED ✔
* Collage Page (Everyday)
    * Shows a screen of all the user's drawings COMPLETED ✔
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Main tab
    * Post Views 
    * Darawing page
* Collage tab
    * Collage page

**Flow Navigation** (Screen to Screen)

* Logout
   * When a user clicks this button, it brings them to the sign in screen. COMPLETED ✔
   * Will be on both of the tab screens. COMPLETED ✔
* Create new drawing
   * When a user presses the plus sign, it allows them to create a new drawing. COMPLETED ✔

## Wireframes

![image](https://user-images.githubusercontent.com/89480509/222808615-d13587b0-a68a-45ab-b1c4-503238fcb09d.png)

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- Drawing Page: Sends the image drawn by the user to Firebase
- Explore & Collage Page: Recieves the image from Firebase
- Friends Page: Adds the given username to the friend's list in Firebase


https://hackmd.io/s/SkZ1P8pRo

