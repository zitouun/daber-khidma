export const esc=(s:string)=>s.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
const text=(x:number,y:number,t:string,size=21,fill='#183D37',anchor='start')=>`<text x="${x}" y="${y}" font-size="${size}" fill="${fill}" text-anchor="${anchor}">${esc(t)}</text>`;
const box=(x:number,y:number,w:number,h:number,title:string,sub='',type='')=>`<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="14" fill="${type==='dark'?'#183D37':type==='warm'?'#F8DFC9':'#FCFAF6'}" stroke="${type==='warm'?'#E27E53':'#C9D2C8'}"/>${text(x+20,y+34,title,23,type==='dark'?'#F7F0E4':'#183D37')}${sub?text(x+20,y+62,sub,17,type==='dark'?'#BDD0C6':'#677A72'):''}`;
const line=(x:number,y:number,x2:number,y2:number,dash=false,color='#183D37')=>`<path d="M${x} ${y} L${x2} ${y2}" fill="none" stroke="${color}" stroke-width="2" ${dash?'stroke-dasharray="7 6"':''} marker-end="url(#${dash?'async':'arrow'})"/>`;
const defs=`<defs><marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10" fill="none" stroke="#183D37" stroke-width="1.5"/></marker><marker id="async" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10" fill="none" stroke="#B95C35" stroke-width="1.5"/></marker></defs>`;
const svg=(w:number,h:number,title:string,body:string)=>`<svg class="diagram" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${w} ${h}" role="img" aria-label="${esc(title)}" font-family="Inter, sans-serif">${defs}<title>${esc(title)}</title>${body}</svg>`;
export function architecture(){
 let b=box(20,10,310,76,'Frontend marketplace','Next.js · TypeScript','dark')+line(330,48,410,48)+box(410,10,440,76,'Spring Cloud Gateway','Routage public · validation JWT','dark')+line(850,48,940,48)+box(940,10,410,76,'Socle commun · identity','OIDC / comptes / rôles');
 b+=line(630,86,630,120)+`<path d="M115 120 H1220" stroke="#183D37" stroke-width="2"/>`;
 const labels=['Catalogue','Propositions','Contrats','Communication','Notifications','Profil / CV / Matching']; const owners=['Rayen','Rana','Yassin','Farah','Oussama','Ayoub'];const db=['catalog','proposal','engagement','communication','notification','matching'];
 for(let i=0;i<6;i++){const x=10+i*230;b+=line(x+105,120,x+105,150)+box(x,150,216,82,labels[i],owners[i])+`<path d="M${x+108} 232 V260" stroke="#677A72" stroke-width="3"/>`+`<rect x="${x+12}" y="260" width="192" height="44" rx="20" fill="#E4E9DE"/>`+text(x+108,288,db[i],18,'#183D37','middle');b+=line(x+104,232,x+104,342,true,'#B95C35');}
 b+=box(10,342,890,72,'RabbitMQ · topic exchange','Événements + files durables → workers des backends','warm');
 b+=box(10,440,390,74,'Notification Worker','Contact autorisé → fournisseur email')+line(160,414,160,440,true,'#B95C35');
 b+=box(445,440,450,74,'Worker CV / Matching · backend 6','Valide les résultats et persiste dans matching')+line(680,414,680,440,true,'#B95C35');
 b+=box(965,440,405,74,'Moteur IA privé','Python / FastAPI · calcul uniquement','warm')+line(895,476,965,476);
 b+=box(965,342,405,72,'MinIO · stockage privé','Accès autorisés par les backends')+line(1275,304,1275,342);
 return svg(1390,530,'Architecture cible : six services Spring Boot, bases propriétaires, RabbitMQ et IA privée',b);
}
export function useCases(){
 const actor=(x:number,y:number,name:string)=>`<g stroke="#183D37" stroke-width="2.5" fill="none"><circle cx="${x}" cy="${y}" r="15"/><path d="M${x} ${y+15} v52 m-28 -34 h56 m-28 34 l-25 36 m25 -36 l25 36"/></g>${text(x,y+130,name,23,'#183D37','middle')}`;
 let b=`<rect x="220" y="12" width="940" height="450" rx="20" fill="#FCFAF6" stroke="#C9D2C8"/>`+text(690,45,'Dabber Khdma · fonctions métier',20,'#677A72','middle');
 const cases:[number,number,string][]=[[450,115,'Publier un projet'],[450,235,'Comparer et sélectionner'],[450,355,'Approuver un jalon'],[920,115,'Confirmer son profil / CV'],[920,235,'Rechercher et candidater'],[920,355,'Soumettre un livrable'],[690,420,'Échanger des messages'],[690,175,'Modérer / traiter un litige']];
 cases.forEach(([x,y,t],i)=>{const from=i<3?[90,215]:i<6?[1290,215]:i===6?[90,215]:[690,520];b+=`<path d="M${from[0]} ${from[1]} L${x} ${y}" stroke="#B4BFB5" stroke-width="1.7"/>`;if(i===6)b+=`<path d="M1290 215 L690 420" stroke="#B4BFB5" stroke-width="1.7"/>`;b+=`<ellipse cx="${x}" cy="${y}" rx="175" ry="34" fill="${i===7?'#F8DFC9':'#F7F0E4'}" stroke="#9EAEA1"/>`+text(x,y+7,t,18,'#183D37','middle');});
 b+=actor(90,155,'Client')+actor(1290,155,'Freelancer')+actor(690,500,'Administrateur');
 return svg(1390,650,'Diagramme UML de cas d’utilisation : client, freelancer et administrateur',b);
}
export function sequence(){
 const xs=[120,415,715,1015,1295], names=['Client / Gateway','Proposal','Catalog','RabbitMQ','Engagement']; let b='';
 xs.forEach((x,i)=>{b+=`<rect x="${x-96}" y="5" width="192" height="52" rx="10" fill="${i===3?'#F8DFC9':'#E4E9DE'}"/>`+text(x,38,names[i],20,'#183D37','middle')+`<path d="M${x} 57 V487" stroke="#BCC8BE" stroke-dasharray="5 7"/>`;});
 const msg=(a:number,c:number,y:number,t:string,dash=false)=>line(xs[a],y,xs[c],y,dash,dash?'#B95C35':'#183D37')+text((xs[a]+xs[c])/2,y-10,t,18,'#183D37','middle');
 b+=msg(0,1,100,'POST accept · Idempotency-Key')+msg(1,2,160,'Réserver sous verrou local')+msg(2,1,220,'200 réservation / 409 conflit')+box(280,247,275,49,'Commit + outbox','','warm')+msg(1,0,330,'202 · Location /selections/{id}')+msg(1,3,385,'proposal.accepted.v1',true)+msg(3,4,435,'Créer le contrat · UNIQUE',true);
 b+=text(710,510,'contract.created.v1 → Catalogue, Proposal, Communication et Notifications',20,'#677A72','middle');
 return svg(1400,535,'Séquence proposée d’acceptation : réservation, outbox, réponse 202 et création idempotente du contrat',b);
}
export function eventFlow(){let b=box(15,65,290,100,'Transaction locale','Métier + outbox atomiques','dark')+line(305,115,365,115)+box(365,65,310,100,'Topic exchange','dabber-khdma.events','warm')+line(675,115,735,115,true,'#B95C35')+box(735,65,290,100,'File durable','routing key versionnée')+line(1025,115,1080,115,true,'#B95C35')+box(1080,65,290,100,'Worker propriétaire','Inbox → commit → ACK');
 b+=line(1225,165,1225,265,true,'#B95C35')+box(1070,265,310,90,'Retry borné','5 s → 30 s → 120 s','warm')+line(1070,310,980,310,true,'#B95C35')+box(690,265,290,90,'Dead-letter queue','Dernier échec → alerte')+text(490,220,'Publisher confirm ≠ traitement consommateur',21,'#677A72','middle');return svg(1400,380,'Flux asynchrone avec outbox, RabbitMQ, inbox, acquittement, reprises et DLQ',b);}
export interface Service { key:string;name:string;owner:string;db:string;purpose:string;classes:(string|string[])[][];relations:(number|string)[][];sync:string;event:string;consumer:string;routes:(string|null)[][];diagram:string;scope:string;businessNumber:number|null; }
export function classDiagram(s:Service){
 // Condensed projection view. Full supplied UML is available in the detail panel.
 const selected=s.key==='ai-matching'?[6,0,3,4]:s.key==='communication'?[0,1,2,3]:s.classes.map((_,i)=>i).slice(0,4);
 const positions=selected.map((_,i)=>({x:18+(i%2)*400,y:20+Math.floor(i/2)*255}));let b='';
 for(const r of s.relations){const a=selected.indexOf(Number(r[0])),c=selected.indexOf(Number(r[1]));if(a<0||c<0)continue;const p=positions[a],q=positions[c];const horiz=p.y===q.y;const x=p.x+(horiz?350:175),y=p.y+(horiz?95:218),x2=q.x+(horiz?0:175),y2=q.y+(horiz?95:0);b+=`<path d="M${x} ${y} L${x2} ${y2}" stroke="#183D37" stroke-width="2"/>`+text(x+(horiz?4:8),y+(horiz?-12:-7),String(r[2]),15)+text(x2+(horiz?-32:8),y2+(horiz?-12:-7),String(r[3]),15);}
 selected.forEach((idx,i)=>{const c=s.classes[idx];if(!c)return;const {x,y}=positions[i];const attrs=(c[1] as string[]).slice(0,4);const methods=(c[2] as string[]).slice(0,1);b+=`<rect x="${x}" y="${y}" width="350" height="218" rx="10" fill="#FCFAF6" stroke="#A6B5A7"/><path d="M${x} ${y+47} H${x+350} M${x} ${y+172} H${x+350}" stroke="#A6B5A7"/>`+text(x+18,y+31,String(c[0]),21);attrs.forEach((a,j)=>{b+=text(x+18,y+74+j*27,a.replace(' externe',' ↗').replace(' nullable',' ?'),17,'#52655A')});b+=text(x+18,y+202,methods[0]?'+ '+methods[0]:'Modèle de domaine',17,'#677A72');});
 return svg(800,515,'Classes principales et cardinalités : '+s.name,b);
}
