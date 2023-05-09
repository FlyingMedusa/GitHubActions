const { TableClient, AzureNamedKeyCredential } = require('@azure/data-tables');
const { BlobServiceClient } = require('@azure/storage-blob');
const createCsvWriter = require('csv-writer').createObjectCsvWriter;
const fs = require('fs');


class DataManager {
    constructor() {
        this.storage = process.env.STORAGE_ACCOUNT_NAME;
        this.key = process.env.ACCOUNT_KEY;
        this.subscriptionId = process.env.AZURE_SUBSCRIPTION_ID;
        this.sharedKeyCredential = new AzureNamedKeyCredential(this.storage, this.key);
        this.tableName = "models"
        this.containerName = "container-csv"
        this.blobName = "models-selected"
    }

    // Clients --------------------------------------------------------------------
    configureTableClient(tableName) {
        const tableClient = new TableClient(
        `https://${this.storage}.table.core.windows.net`,
        `${tableName}`,
        this.sharedKeyCredential,
        );
        return tableClient;
    }

    configureBlobServiceClient() {
        const blobServiceClient = new BlobServiceClient(
        `https://${this.storage}.blob.core.windows.net`,
        this.sharedKeyCredential
        );
        return blobServiceClient;
    }

    getContainerClient() {
        const blobServiceClient = this.configureBlobServiceClient();
        const containerClient = blobServiceClient.getContainerClient(this.containerName);
        return containerClient;
    }

    async getBlockBlobClient() {
        const containerClient = this.getContainerClient()
        const blockBlobClient = await containerClient.getBlockBlobClient(this.blobName);
        return blockBlobClient;
    }
    // ----------------------------------------------------------------------------

    async getDataFromTable(selectedColumns) {
        const client = this.configureTableClient('models');
        const modelsProperties = [];
        const entitiesIter = client.listEntities();
        for await (const entity of entitiesIter) {
            const row = {};
            for (const col of selectedColumns) {
                row[col] = entity[col];
            }
            modelsProperties.push(row);
        }
        return modelsProperties;
    }

    async createCsvFromTabularData(selectedColumns) {
        const modelsProperties = await this.getDataFromTable(selectedColumns);
        const csvWriter = createCsvWriter({
          path: 'models.csv',
          header: selectedColumns.map(column => ({ id: column, title: column })),
        });
        await csvWriter.writeRecords(modelsProperties);
        const csvFile = await fs.promises.readFile('models.csv');
        return csvFile;
    }

    async createBlobFromLocalPath(containerClient, blobName, localFileWithPath, uploadOptions){

        // create blob client from container client
        
      
        // upload file to blob storage
        await blockBlobClient.uploadFile(localFileWithPath, uploadOptions);
        console.log(`${blobName} succeeded`);
      }

    // async createContainer() {
    //     try{
    //         const containerNameUnique = `${this.containerName}${new Date().getTime()}`;
    //         const blobClient = this.configureBlobClient();
    //         const containerClient = blobClient.getContainerClient(containerNameUnique);
    //         const createContainerResponse = await containerClient.create();
    //         console.log(
    //         `Container was created successfully.\n\trequestId:${createContainerResponse.requestId}\n\tURL: ${containerClient.url}`
    //         );
    //         return containerClient;
    //     } catch (err) {
    //         console.log(`Error uploading blob: ${err.message}`);
    //         console.log(`Error details: ${JSON.stringify(err.details)}`);
    //         throw err;
    //     }
    // }

    // async uploadBlob(csvFile) {
    //     try{
    //         const containerClient = await this.createContainer();
    //         const blockBlobClient = containerClient.getBlockBlobClient(this.blobName);
    //         console.log(`\nUploading to Azure storage as blob\n\tname: ${this.blobName}:\n\tURL: ${blockBlobClient.url}`);
    //         const uploadBlobResponse = await blockBlobClient.upload(csvFile, csvFile.length);
    //         return `Blob was uploaded successfully. requestId: ${uploadBlobResponse.requestId}`;
    //     } catch (err) {
    //         console.log(`Error uploading blob: ${err.message}`);
    //         console.log(`Error details: ${JSON.stringify(err.details)}`);
    //         throw err;
    //     }
    // }
}  


module.exports = async function (context, req) {
    const columns = req.query.columns.split(',');
    const dataManager = new DataManager();
    const csvFile = await dataManager.createCsvFromTabularData(columns);


    context.log("I'm trying at least")
    const containerNameUnique = `container-csv${new Date().getTime()}`;
    const blobClient = new BlobServiceClient(
        `https://${dataManager.storage}.blob.core.windows.net`,
        dataManager.sharedKeyCredential
        );
    context.log("got 1st client")
    const containerClient = blobClient.getContainerClient(containerNameUnique);
    context.log("got 2nd client")
    const createContainerResponse = await containerClient.create();
    context.log(
    `Container was created successfully.\n\trequestId:${createContainerResponse.requestId}\n\tURL: ${containerClient.url}`
    );


    try{
        const blockBlobClient = containerClient.getBlockBlobClient(models-selected);
        context.log(`\nUploading to Azure storage as blob\n\tname: ${models-selected}:\n\tURL: ${blockBlobClient.url}`);
        const uploadBlobResponse = await blockBlobClient.upload(csvFile, csvFile.length);
        context.log(`Blob was uploaded successfully. requestId: ${uploadBlobResponse.requestId}`);
    } catch (err) {
        context.log(`Error uploading blob: ${err.message}`);
        context.log(`Error details: ${JSON.stringify(err.details)}`);
        throw err;
    }

    
    context.res = {
        body: message
    }
};
