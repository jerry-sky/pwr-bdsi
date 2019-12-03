import { HobbyDatabase } from "./base";
import { Db } from "mongodb";

HobbyDatabase((database: Db) => {

  return database.collection('osoby')
    .updateOne(
      {},
      {
        '$pull': {
          zainteresowania: {
            '$in': [
              'strzelectwo',
              'narciarstwo'
            ]
          }
        }
      }
    )

})