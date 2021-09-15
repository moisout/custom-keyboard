import fs from 'fs';
import definition from '../src';

const output = definition;

fs.writeFileSync('./output.scad', output.serialize({ $fn: 100 }));
