# end-to-end-data-project-with-ADF-and-Databricks
This project implements a modern data pipeline using Azure Data Factory and Power BI to enable efficient data ingestion, transformation, and visualization. Data is sourced from HTTP endpoints and GitHub repositories, then processed through Azure Data Factory and stored in a structured, layered architecture
the datasets are really well-known and you guys can find it in Kaggle here is the link: https://www.kaggle.com/datasets/ukveteran/adventure-works 
the datasets have many tables with foreign keys so you guys can do join queries.
<img width="1075" height="665" alt="Ảnh chụp màn hình 2025-09-26 121019" src="https://github.com/user-attachments/assets/0a3a1f1f-4bc5-4e2a-88ee-887710a8401f" />



Here I will show all the steps to build this project and I also explain every configuration that I do

## Step 1: create a resource group
  <img width="1357" height="887" alt="image" src="https://github.com/user-attachments/assets/1115ddd5-6bd4-4ac6-b7d9-bac1f9556662" />
- select the your region (I recommend you select the nearest one)
  <img width="933" height="798" alt="image" src="https://github.com/user-attachments/assets/d3123d21-79bb-43d5-b241-3dd76716482f" />
- then click review and create
  
## Step 2: create a storage account
  <img width="1243" height="643" alt="image" src="https://github.com/user-attachments/assets/932a2b28-e581-444b-9632-43057cf920a9" />
- choose ADLS GEN2 for the storage type; and choose 'Locally-redundant storage' because it is the cheapest one for the learning purpose
  <img width="1059" height="780" alt="image" src="https://github.com/user-attachments/assets/b07c518d-d297-4780-8e3e-0d6a8cb29ed9" />
- remember to enable hierarchical namespace
  <img width="1022" height="800" alt="image" src="https://github.com/user-attachments/assets/f6a8788d-b589-4d1e-abb4-2dbf0ce0759d" />
- then click review and create
- the reason we create ADLS GEN 2 instead of blob storage because later we need toi create 3 containers for 3 layers bronze, silver, and gold.
  
## Step 3: create 3 containers
- go to storage account -> containers
<img width="1080" height="823" alt="image" src="https://github.com/user-attachments/assets/9124567e-0b16-43eb-8242-e4c591e6d9a5" />
- create 3 containers like this
  <img width="1726" height="845" alt="image" src="https://github.com/user-attachments/assets/267c7594-911f-48d3-bbad-af38fd30d516" />
  
## Step 4: create Azure Data Factory (ADF)
<img width="980" height="720" alt="image" src="https://github.com/user-attachments/assets/6eda6e69-b3ed-433a-82eb-8ffca04069f3" />
- pick data factories (V2)
- choose the resource group that I have created before
  <img width="991" height="799" alt="image" src="https://github.com/user-attachments/assets/eaae9447-d7c1-46aa-89e8-da6a33c91ff7" />
- then review and create

## Step 5: create 2 linked services for GitHub (datasource) and ADLS Gen2 (sink)
- once ADF is created. launch it.
  <img width="1748" height="889" alt="image" src="https://github.com/user-attachments/assets/d1ba9ba1-7a70-4be2-8458-cabd3423a579" />
- go to Manage and create linked services
- search for HTTP because I ingest data from Github
  <img width="1897" height="873" alt="image" src="https://github.com/user-attachments/assets/696057fc-13d9-4704-8177-e5570b8a5ab9" />
- notice that base URL is not the full URL. Full URL = base URL + relative URL
  <img width="767" height="762" alt="image" src="https://github.com/user-attachments/assets/181fb76d-0d85-4230-a3bd-e1c87126a585" />
- I just created a linked service for Github. Now I will do the similar thing with ADLS
  <img width="795" height="816" alt="image" src="https://github.com/user-attachments/assets/3519c186-5db9-49ca-903f-0980d3960dd3" />
- select Azure Datalake Storage Gen2
- don't forget to test connection, then create it.
  <img width="787" height="811" alt="image" src="https://github.com/user-attachments/assets/52807ed4-5fb8-491a-9f2b-dda4cd1761a8" />
- done so now you should see something like this
  <img width="1454" height="510" alt="image" src="https://github.com/user-attachments/assets/d336712f-21f8-4253-9448-e0488bc6ceaf" />

## Step 6: create 2 datasets for source and sink
- here I have so many csv files that mean there are many relative URLs and I don't want to repeatly ingest them one by one. so I will create a pipeline which has these activities: lookup, foreach, and copy
- go to Author -> create a pipeline -> create an activity called copy
  <img width="1457" height="822" alt="image" src="https://github.com/user-attachments/assets/bb419c7b-40fb-4d3d-8fc8-3009c17f4d04" />
- go to source -> create a dataset -> search for http
  <img width="1574" height="837" alt="image" src="https://github.com/user-attachments/assets/c36aa095-e22d-4cb2-ba5c-f1655bc4d856" />
- then select csv format because all the data files I have are csv
- select the linked service for github that was created before. then go to advanced -> click open this dataset
 <img width="843" height="816" alt="image" src="https://github.com/user-attachments/assets/44f3fb84-9206-499b-80a6-0af3d46d1b79" />
- create a parameter for relative URLs
  <img width="1504" height="846" alt="image" src="https://github.com/user-attachments/assets/f2a24f2f-1bd9-49b6-8168-9e1d0937142e" />


  
