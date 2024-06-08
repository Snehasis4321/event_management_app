# Event Management App

### 👍Note 
for running on android you need to comment out some part on 
`create_event.dart` file as it constans part to upload image for web
so please make sure to do it.


### 🛠 Update -
There was an issue with flutter web the image is not uploading with file picker.
This was the error
```
On web `path` is always `null`,
You should access `bytes` property instead.
```

 For that reason we have done some modifications in the code.

For web platform instead of `file_picker` we are using now `image_picker_web` to upload the event image. Some modifactions are made in the code `create_event_page.dart` please update your code. This was not included in the video. 

### 👨‍💻 Technologies Used :
- Flutter
- Appwrite Cloud

### 📽 Video Links - 
- [Event Management App using Flutter & Appwrite | Login & Signup | Part 1](https://youtu.be/uOWeCc_e1RY)

- [Event Management App using Flutter & Appwrite | Create + Read Events & Upload Images | Part 2](https://youtu.be/se4XMGSASJY)

- [Event Management App using Flutter & Appwrite |Participate in Events (Update) & Read Images | Part 3](https://youtu.be/QRV8BXMN4xE)

- [Event Management App using Flutter & Appwrite | Edit & Delete Events | Part 4](https://youtu.be/cfA7lHKEL1Y)