import { HobbyDatabase } from "./base";
import { Db } from "mongodb";

HobbyDatabase((database: Db) => {

  return database.collection('osoby')
    .find({
      imię: { '$regex': /^[^vxqłąz]+$/ },
      nazwisko: { '$regex': /^[^vxqłąz]+$/ },

      narodowość: {
        '$not': { '$all': ['Polska'] }
      }

    })
    .toArray()
    .then((results) => {

      results.forEach(value => {
        console.log(value);
      })

    })

})