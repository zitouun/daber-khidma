# Propositions et sélection

Responsable : Rana.

Statut : conception semaine 4, code applicatif à développer.

Créer et retirer les propositions, présélectionner et orchestrer l’attribution après réservation du projet.

## Décompte

Microservice métier 2 sur 6.

## Données et contrats

Base propriétaire : proposal. Classes et API : diagramme de classes, openapi.json et schema.sql. Les clés étrangères restent locales.

## Communication synchrone

Vérifie le projet et son propriétaire dans Catalog; réserve l’attribution avant le commit local de Selection et OutboxEvent.

## Communication asynchrone

proposal.accepted.v1.
