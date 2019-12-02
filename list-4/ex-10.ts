import { HobbyDatabase } from "./base";
import { Db } from "mongodb";

HobbyDatabase((database: Db) => {

  return database
    .collection('osoby')
    // .deleteMany(
    .find(
      {
        zainteresowania: {
          '$all': [
            'txuisae',
            'tbrpggw',
            // 'koszykówka',
            // 'hokej',
          ]
        }
      },
    )
    .toArray()
    .then((results) => {
      console.log(results);
      // results.forEach(value => {
      //   console.log(value);
      // });
    })

});