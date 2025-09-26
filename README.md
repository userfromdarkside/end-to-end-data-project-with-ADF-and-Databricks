# end-to-end-data-project-with-ADF-and-Databricks
This project implements a modern data pipeline using Azure Data Factory and Power BI to enable efficient data ingestion, transformation, and visualization. Data is sourced from HTTP endpoints and GitHub repositories, then processed through Azure Data Factory and stored in a structured, layered architecture.
the datasets are really well-known and you guys can find it on Kaggle here is the link: https://www.kaggle.com/datasets/ukveteran/adventure-works 
the datasets have many tables with foreign keys so you guys can do join queries.
<img width="1059" height="685" alt="image" src="https://github.com/user-attachments/assets/277a4bb3-74c4-425d-aea1-46277e28e1e7" />





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
- you should see something like this
  <img width="818" height="826" alt="image" src="https://github.com/user-attachments/assets/fe4c4762-bbfd-4927-92b3-f2aac13bc0d1" />
- now do the same thing with sink
  <img width="830" height="839" alt="image" src="https://github.com/user-attachments/assets/530d96a8-43ee-480f-9f2c-9de8aa8b880f" />
- create 2 parameters for folder names and file names
<img width="1416" height="451" alt="image" src="https://github.com/user-attachments/assets/49b0c46b-20d8-4804-aa5d-36f8dc0555d9" />
- now create an activity called foreach
  <img width="1013" height="772" alt="image" src="https://github.com/user-attachments/assets/997c16dc-69c8-4f01-8ba2-bf5e629e665f" />

## Step 7: upload the parameters file to ADLS 
- create a new container and upload the parameters file. it is a json file and you can find it above.
  <img width="1893" height="832" alt="image" src="https://github.com/user-attachments/assets/215e8e77-0111-4a8a-b91b-318ff9251470" />

## Step 8: create a Lookup activity
<img width="1431" height="760" alt="image" src="https://github.com/user-attachments/assets/dc976c18-cfb1-434b-9fba-2fc3a8456ab3" />
- next go to settings -> create a new dataset (choose ADLS Gen 2) -> select format json -> select linked service and point to the path of the json file
  <img width="1893" height="890" alt="image" src="https://github.com/user-attachments/assets/7decc415-1291-4dbe-9417-243040b19389" />
- make sure you untick the 'the first row only'
  <img width="1146" height="276" alt="image" src="https://github.com/user-attachments/assets/82fd5c41-2368-49c1-a714-bff6d48b5946" />

## Step 9: beautiful, so now I am gonna connect these actitivies
- make sure you choose 'connect on success'
  <img width="1500" height="835" alt="image" src="https://github.com/user-attachments/assets/b765cadc-7d29-4814-89f3-4afc95daff27" />
- then go to setting and do like this. don't forget to add '.value' after '@activity('Lookup_URLs').output'
  @activity('Lookup_URLs').output
- now I am gonna copy and paste the copy activity to inside the foreach activity
  <img width="1472" height="854" alt="image" src="https://github.com/user-attachments/assets/441e3013-ae4c-4006-b1ad-a123d76b3418" />
- go to activities -> paste the copy activity here then you will see something like this
  <img width="1796" height="806" alt="image" src="https://github.com/user-attachments/assets/04ddbfbb-c874-45f9-b4c1-c58d831f7dba" />
- cool now go to source and add dynamic value, make sure you write the same parameter as you have in the json file
  <img width="1489" height="838" alt="image" src="https://github.com/user-attachments/assets/f6e39026-2cb6-40af-b104-1a1c7f17567e" />
- do the same thing with sink
  <img width="1140" height="706" alt="image" src="https://github.com/user-attachments/assets/7b53481c-d6bf-4449-8a89-43988e8d971f" />

## Step 10: amazing, now let's try to run the pipeline
- click debug to run it
  <img width="1809" height="889" alt="image" src="https://github.com/user-attachments/assets/54e67cc9-cfe6-4db2-baa3-9b60db2a0eed" />
- wow, it workds
  <img width="1467" height="843" alt="image" src="https://github.com/user-attachments/assets/2c0da173-47bd-4478-9868-b97d28c6c642" />
- go to ADLS, I can see all the data have been loaded to here
  <img width="1454" height="836" alt="image" src="https://github.com/user-attachments/assets/b11f4d0a-a3af-4690-a0c4-a71d10f44468" />

## Step 11: create Databricks - my favourite part
- search for Databricks then click create
  <img width="1819" height="829" alt="image" src="https://github.com/user-attachments/assets/f883205d-ab31-47aa-9d16-e82c453e413f" />
- choose Premium Pricing tier because this time I want to use role-based access controls ->then review and create
  <img width="1026" height="841" alt="image" src="https://github.com/user-attachments/assets/ce2910dd-2104-41cc-b214-94349de48ddd" />

## Step 12: create compute 
- after create Databricks workspace -> launch it -> creat compute
- databricks UI has been changed abit. I will choose personal compute, untick machine learing (it would unable Photon), and choose Standard_DS3_v2 as I see it is the cheapest one, terminal after 10 minutes to protect my wallet. then create it
  <img width="1910" height="890" alt="image" src="https://github.com/user-attachments/assets/43bec4b5-bf91-451b-b98e-b61c7d361268" />
- I got error. the compute I chose is not available in Aus East
<img width="907" height="511" alt="image" src="https://github.com/user-attachments/assets/096a9ab9-811b-4740-98fe-25e6cf428de8" />
- choose another one. and it is running now
  <img width="1620" height="295" alt="image" src="https://github.com/user-attachments/assets/82a29ffe-e407-40c5-a8a8-a688fcd31f81" />

## Step 13: give Databricks permission to access ADLS Gen2
- search for Entra ID -> App registrations -> new registration -> then register
  <img width="1063" height="837" alt="image" src="https://github.com/user-attachments/assets/e1695b06-b853-44c9-8232-b69bd9ad4c76" />
- once it is created. save all its credentials into a notepad
  <img width="1747" height="777" alt="image" src="https://github.com/user-attachments/assets/90ff7cdb-aa7b-4a1c-8309-ad700ae6e7d9" />
- go to credentials and secrets -> create client
  <img width="1414" height="830" alt="image" src="https://github.com/user-attachments/assets/7d6eaa74-80c0-47c1-968f-7ba1cc21fbec" />
- go to ADLS -> access control IAM -> add role assignment -> search for 'Storage Blob Data Contributor'
  <img width="1894" height="828" alt="image" src="https://github.com/user-attachments/assets/35c00f0b-7ec6-4a47-ba79-f90a2d8d6b09" />
- go to members -> search and select the app I registerd before. then review and create
  <img width="1910" height="822" alt="image" src="https://github.com/user-attachments/assets/8fb61c93-3467-494e-bdd1-eb3fee54a539" />

## Step 14: create a Databricks notebook and connect it to ADLS 
- name it silver_layer. and then start the compute I have created before
  <img width="1775" height="884" alt="image" src="https://github.com/user-attachments/assets/58502f4e-7bba-44a8-b6e9-a3a275bb806c" />

## Step 15: now I have the access. let's read data then do some transformations and write them to the silver contair
- you guys can find the silver_layer notebook above


  
