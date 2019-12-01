import { HobbyDatabase, getRandomString, getRandomFromList } from './base';
import { Db } from 'mongodb';
import { Sport } from './model';

HobbyDatabase((database: Db) => {

  const sporty: Sport[] = [];

  const sportTypy: Sport["typ"] = ['indywidualny', 'zespołowy'];
  const sportMiejsceWykonywania: Sport["miejsceWykonywania"] = ['hala', 'na zewnątrz'];

  return new Promise(resolve => {

    for (let i = 0; i < 10; i++) {
      sporty.push({
        nazwa: getRandomString(7),
        typ: getRandomFromList(sportTypy, 2),
        miejsceWykonywania: getRandomFromList(sportMiejsceWykonywania, 2),
      });
    }

    resolve(sporty);

  })
    .then((sporty: Sport[]) => {

      database.collection('sport').insertMany(sporty);

    });

});