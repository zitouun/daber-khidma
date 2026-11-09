# Communication

Responsable : Farah.

Statut : conception semaine 4, code applicatif à développer.

Conserver les conversations et messages, vérifier les participants, limiter les abus et référencer les fichiers.

## Décompte

Microservice métier 4 sur 6.

## Données et contrats

Base propriétaire : communication. Classes et API : diagramme de classes, openapi.json et schema.sql. Les clés étrangères restent locales.

## Communication synchrone

Lit les participants du contrat par GET /contracts/{id} lors de l’ouverture; contrôle leur appartenance à chaque lecture/écriture.

## Communication asynchrone

message.sent.v1.
