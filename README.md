# Cloud Based Crypto-currency Trading

##### A Currency trading platform which works on multiple devices anywhere across internet across various platforms.

#### Backend:
The Backend for the project is divided into 4 parts as follows. <br/>
You can find Backend for the project below.
1. [Matching Algorithm](https://github.com/PratikMahajan/Dynamic-Currency-Pricing-API)
2. [Currency Pricing Algorithm](https://github.com/PratikMahajan/Dynamic-Currency-Pricing-API)
3. [Verification Backend](https://github.com/PratikMahajan/Dynamic-Currency-Pricing-API)
4. [User-Data API](https://github.com/PratikMahajan/User-Data-API)


#### Frontend:
This repository contains the frontend for the Cloud based Cryptocurrency project.

The frontend is divided into two parts:<br/>

1. Verification Module
2. Customer Module


#### Verification Module:
Verification admin retrives user documents from AWS S3 and checks if they are authentic. If they are, verifies the user do that user can conduct transactions on the platform.

Verification admin can also unverify the user in future.

#### Customer Module
An unverified user can only see the current price of the coin and can add money to the wallet. <br/>
A user needs to be verified to conduct transcations on the platform. A user can upload any government issued ID card in order to get verified.
Once verified, the user can do the following tasks

1. Send SELL request (to sell coins)
2. Send BUY request (to buy coins)
3. Check current price of the coin.
4. Update Profile and upload new Documents


##### This program is written in iOS, There is a Java-Swing version of this application. See [here](https://github.com/PratikMahajan/Cloud-Based-Cryptocurrency-Trading)
