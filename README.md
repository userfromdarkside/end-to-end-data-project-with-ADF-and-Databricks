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
----- the reason we create ADLS GEN 2 instead of blob storage because later we need toi create 3 containers for 3 layers bronze, silver, and gold. -----
## Step 3: create 3 containers
- go to storage account -> containers
<img width="1080" height="823" alt="image" src="https://github.com/user-attachments/assets/9124567e-0b16-43eb-8242-e4c591e6d9a5" />
- create 3 containers like this
  <img width="1726" height="845" alt="image" src="https://github.com/user-attachments/assets/267c7594-911f-48d3-bbad-af38fd30d516" />
## Step 4: create Azure Data Factory
<img width="980" height="720" alt="image" src="https://github.com/user-attachments/assets/6eda6e69-b3ed-433a-82eb-8ffca04069f3" />
- pick data factories (V2)
- choose the resource group that I have created before
  <img width="991" height="799" alt="image" src="https://github.com/user-attachments/assets/eaae9447-d7c1-46aa-89e8-da6a33c91ff7" />
- then review and create
  
