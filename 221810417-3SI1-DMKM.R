---
  title: "Untitled"
author: "Meytry Petronella Purba"
date: "10/27/2020"
output: word_document
---
  
  ```{r}
#Eksplorasi Data
#Ubah struktur data, intinya kalau data numerik -> numerik, kalau data kategorik -> factor
str(mydata)
mydata$D <- as.factor(mydata$D)
mydata$X1 <- as.factor(mydata$X1)
mydata$X4 <- as.factor(mydata$X4)
mydata$X5 <- as.factor(mydata$X5)
mydata$X6 <- as.factor(mydata$X6)
mydata$X7 <- as.factor(mydata$X7)
mydata$X9 <- as.factor(mydata$X8)
mydata$X8 <- as.factor(mydata$X9)
mydata$X10 <- as.factor(mydata$X10)
mydata$X14 <- as.factor(mydata$X14)
mydata$X15 <- as.factor(mydata$X15)
```

### Load Library
Dua library yang dibutuhkan, yaitu **psych, dan caret**. 

Library **psych** akan digunakan untuk melihat korelasi antar variabel dan library **caret** digunakan untuk membuat confusion matriks dan melihar akurasi model.

```{r message=FALSE, warning=FALSE}
library(psych)
library(caret)
```

### Konversi Data
Mengubah variabel **D** dan **X17** menjadi bertipe factor
```{r}
mydata$D  <- as.factor(mydata$D)
mydata$X17 <- as.factor(mydata$X17)
str(mydata)
```

```{r}
#VARIABEL BROWN FROGS
brown 
brown$X17 <- as.factor(brown$X17)
```

```{r}

```
### Pair Plot

```{r}
pairs.panels(brown)
```
####Terlihat korelasi antara variabel tidak terlalu signifikan, kita misalkan tidak ada multikolinear. Pada kasus asli harap diuji dengan uji multikolinearitas

### Split Data
Memecah data menjadi data training(80% dari data awal) dan data test (20% dari data awal)
```{r}
set.seed(1234)
sampel <- sample(2, nrow(brown), replace = T, prob = c(0.8,0.2))
trainingdat <- brown[sampel==1, ]
testingdat <- brown[sampel==2, ]
print(paste("Jumlah Train Data: ", nrow(trainingdat), "| Jumlah Test Data: ", nrow(testingdat)))
```
### Buat Model
Karena kasus ini hanya ada(1) atau tidak ada(0), maka model yang dibangun adalah model regresi logistik sederhana. Jika target class memiliki banyak nilai, gunakan multinomial.
```{r}
modellogreg<-glm(X17~., data=trainingdat, family = "binomial")
summary(modellogreg)
```
#### Koefisien model
```{r}
coefficients(modellogreg)
```
### Model Evaluation
#### Melakukan Prediksi

```{r}
prediksilogreg <- predict(modellogreg, testingdat, type="response") #output berupa peluang
prediksilogreg
```
###Menyaring prediksi, lebih besar dari 0.05 dikategorikan 1 (admit) selain itu dikategorikan 0 (tidak diadmit)

```{r}
pred <- ifelse(prediksilogreg>0.5, 1, 0)
pred
```

