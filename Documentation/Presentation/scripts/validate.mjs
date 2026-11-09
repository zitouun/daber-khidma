import {readFileSync,existsSync} from 'node:fs';
const services=JSON.parse(readFileSync('src/content/services.json','utf8'));
if(services.filter(s=>s.businessNumber).length!==6)throw Error('Expected six owners');
for(const s of services){if(!existsSync('public/contracts/'+s.key+'.openapi.json'))throw Error(s.key);if(!existsSync('public/diagrams/'+s.diagram+'.svg'))throw Error(s.diagram)}
console.log('Six services + socle : contrats et modèles présents.');
