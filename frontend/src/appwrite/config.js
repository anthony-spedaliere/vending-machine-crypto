import { Client, Account, Databases } from "appwrite";

// Initialize the Appwrite client
export const client = new Client();

client
  .setEndpoint(import.meta.env.VITE_APPWRITE_ENDPOINT)
  .setProject(import.meta.env.VITE_APPWRITE_PROJECT);

// Export account instance to manage authentication
export const account = new Account(client);

// Export databases instance to interact with Appwrite Database
export const databases = new Databases(client);

// Database and collection IDs
// export const appwriteConfig = {
//   databaseId: import.meta.env.VITE_APPWRITE_DATABASE_ID || "YOUR_DATABASE_ID",
//   vendingMachineCollectionId:
//     import.meta.env.VITE_APPWRITE_VENDING_MACHINE_COLLECTION_ID ||
//     "YOUR_VENDING_MACHINE_COLLECTION_ID",
//   productsCollectionId:
//     import.meta.env.VITE_APPWRITE_PRODUCTS_COLLECTION_ID ||
//     "YOUR_PRODUCTS_COLLECTION_ID",
//   transactionsCollectionId:
//     import.meta.env.VITE_APPWRITE_TRANSACTIONS_COLLECTION_ID ||
//     "YOUR_TRANSACTIONS_COLLECTION_ID",
// };
