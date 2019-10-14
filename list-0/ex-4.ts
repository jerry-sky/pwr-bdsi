import { data } from './base';

data
  .then(data => {

    const ownersWithMultiplePets: string[] = [];

    for (const row of data.rows) {

      if (ownersWithMultiplePets.find(x => x === row.owner)) {
        console.log(row.owner);
      } else {
        ownersWithMultiplePets.push(row.owner);
      }

    }

  });
