let fs = require('fs');

let path = './standard_library_list.json';

const get = (conditions) => {
	let file = JSON.parse(fs.readFileSync(path, 'utf8'));
	let filter = [];
	for (i = 0; i < conditions.length; i++) {
		key = conditions[i].key;
		value = conditions[i].value;
		file.every((element) => {
			if (element[key] == value) {
				filter.push(element);
			}
			return true;
		});
		file = filter;
		filter = [];
	}
	return file;
};

// with given condition array to filters the library list and returns the values
// all conditions bounded with 'and' operator
let result = get([
	{ key: 'header', value: 'ctype.h' },
	{ key: 'done', value: true },
]);

// print the result
console.log(JSON.stringify(result, ' ', '\t'));
