# car_license_exams

For prepare car license exam


## Demo screenshot

<img src="../master/assets/Screenshot_20201208_1.jpg?raw=true" width="320">

<img src="../master/assets/Screenshot_20201208_2.jpg?raw=true" width="320">
<img src="../master/assets/Screenshot_20201208_3.jpg?raw=true" width="320">


## Getting Started

This project is a starting point for a Flutter application.


## 把汽車駕照考題轉換成 json

0. 進入 car_license_data_conver 資料夾
1. 從 公路總局開放資料 https://data.gov.tw/dataset/30305 下載 odt 檔案
2. 將 odt 檔案整理至 汽車.xlst (答案欄位為 ans, 是非題將是轉為 1; 否轉為 0)
3. 使用 python3 -m notebook 打開 test.ipynb
4. 使用 js 整理選擇題裡面的答案以及資料結構
5. 整理過後的 json file 移到 assets/data 裡面

