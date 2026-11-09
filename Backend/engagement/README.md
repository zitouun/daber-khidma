# Contrats et jalons

Responsable : Yassin.

Statut : conception semaine 4, code applicatif à développer.

Créer un contrat par proposition retenue, gérer les jalons, livrables et litiges. Les paiements restent hors périmètre.

## Décompte

Microservice métier 3 sur 6.

## Données et contrats

Base propriétaire : engagement. Classes et API : diagramme de classes, openapi.json et schema.sql. Les clés étrangères restent locales.

## Communication synchrone

Communication appelle GET /contracts/{id} pour vérifier les participants; Engagement lit le stockage objet pour valider les métadonnées d’un livrable.

## Communication asynchrone

contract.created.v1 / milestone.approved.v1.
