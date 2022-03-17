import { Db, MongoClient } from "mongodb";
import chalk from 'chalk';
class Database {
  db?: Db;
  
  async init(): Promise <Db | undefined> {
    console.log("----- Database ------");
    try {
      //Definimos url
      const MONGODB = `${ process.env.DATABASE }` ;
      console.log(MONGODB);
      //conectamos con el cliente de mongodb
      const mongoClient = await MongoClient.connect(MONGODB);
      //inicializamos la bd
      this.db = mongoClient.db();
      console.log(`STATUS: ${chalk.greenBright("ONLINE")}`);
      console.log(`DATABASE: ${chalk.greenBright(this.db.databaseName)}`);
      const lastId = await this.db.collection("users")
                .find().limit(1).sort({registerDate: -1}).toArray();
    } catch (error) {
        console.log(`error:${error}`);
        console.log(`STATUS: ${chalk.redBright("OFFLINE")}`);
        console.log(`DATABASE: ${chalk.redBright(this.db?.databaseName)}`);
    }
    return this.db;

  }
}

export default Database;