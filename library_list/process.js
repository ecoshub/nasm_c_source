const fs = require('fs');

const path = './standard_library_list.json';

const get = (conditions) => {
  const file = JSON.parse(fs.readFileSync(path, 'utf8'));

  return file.filter((data) => {
    return conditions.every(
      (condition) => data[condition.key] === condition.value
    );
  });
};

// with given condition array to filters the library list and returns the values
// all conditions bounded with 'and' operator
const result = get([
  { key: 'header', value: 'ctype.h' },
  { key: 'done', value: true },
]);

// print the result
console.log(JSON.stringify(result, ' ', '\t'));
