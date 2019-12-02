import { HobbyDatabase } from "./base";
import { Db } from "mongodb";

HobbyDatabase((database: Db) => {

  return database
    .collection('osoby')
    .find(
      {
        narodowość: { '$all': [{ kraj: 'Rosja' }] }
      },
    )
    .toArray()
    .then((results) => {
      results.forEach(value => {
        console.log(value);
      });
    })

});