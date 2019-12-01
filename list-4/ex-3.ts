import { HobbyDatabase, getRandomString } from './base';
import { Db } from 'mongodb';
import { Zwierzę } from './model';

HobbyDatabase((database: Db) => {

  const zwierzęta: Zwierzę[] = [];

  return new Promise(resolve => {

    for (let i = 0; i < 10; i++) {

      const rasy: string[] = [];
      for (let i = 0; i < Math.floor(Math.random() * 3) + 2; i++) {
        rasy.push(getRandomString(10));
      }

      const minWaga = Math.round((Math.random() + 0.3) * 200);
      const maxWaga = minWaga + 3 + Math.round((Math.random() + 0.3) * 70);

      zwierzęta.push({
        nazwa: getRandomString(6),
        rasy,
        minWaga,
        maxWaga,
        ubarwienie: getRandomString(5),
        przewidywanaDługośćŻycia: Math.round(3 + Math.random() * 25),
      });
    }

    resolve(zwierzęta);

  })
    .then((zwierzęta: Zwierzę[]) => {

      database.collection('zwierzęta').insertMany(zwierzęta);

    });

});