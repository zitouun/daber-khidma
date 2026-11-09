# Profil professionnel, CV et matching

Responsable : Ayoub.

Gérer le profil professionnel, le CV et les recommandations. Le backend métier d’Ayoub conserve les profils, documents, versions et résultats; le moteur IA privé réalise uniquement des calculs à sa demande. Ayoub réalise aussi les écrans frontend liés à ce domaine.

Microservice métier 6 sur 6. API Spring Boot; moteur Python/FastAPI privé, appelé uniquement par le backend.

## Contrat et données

Voir openapi.json et schema.sql. Les modèles sont une conception, sans serveur métier implémenté.

## Communication synchrone

Le backend lit les offres dans Catalog et vérifie le compte dans le socle commun. Son worker appelle le moteur IA privé par HTTP; l’IA renvoie un résultat au backend, qui le valide et le persiste.

## Événements

resume.uploaded.v1 / resume.parsed.v1 / profile.updated.v1 / ai.match.requested.v1 / ai.match.completed.v1

## Travail backend et frontend

Voir Documentation/Organisation/Mission_Ayoub_Backend_Frontend.md et Repartition_Backend_Frontend.md depuis la racine du projet.
