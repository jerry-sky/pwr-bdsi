import axios from 'axios';

interface row {
  name: string,
  owner: string,
  species: string,
  sex: 'f' | 'm',
  birth: Date,
  death: Date,
  date: Date,
  type: string,
  remark: string,
}

export const data = axios.get('http://cs.pwr.edu.pl/syga/courses/db/menagerie.json')
  .then(response => {

    const data = response.data;

    const dataProcessed: {
      table: string,
      rows: row[]
    } = { table: data.table, rows: [] };

    for (const row of data.rows) {
      const t: row = { ...row };

      for (const d of ['birth', 'death', 'date']) {
        t[d] = new Date(row[d]);
        t[d].setTime(t[d].getTime() + t[d].getTimezoneOffset() * 60 * 1000);
      }

      dataProcessed.rows.push(t);
    }

    return dataProcessed;

  });