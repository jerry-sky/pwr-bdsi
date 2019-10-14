import { data } from './base';

data
  .then(data => {

    data.rows.sort((a, b) => a.name < b.name ? -1 : a.name > b.name ? 1 : 0);

    for (const row of data.rows) {

      if (row.species === 'dog' && row.birth.getMonth() < 6) {
        console.log(row.name, row.date.toLocaleDateString());
      }

    }

  });
