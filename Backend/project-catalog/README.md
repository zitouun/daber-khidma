# Catalogue de projets

Responsable : Rayen.

Statut : conception semaine 4, code applicatif à développer.

Gérer les projets, la recherche et la réservation atomique de l’unique attribution. Posséder la décision de disponibilité évite une course entre annulation et sélection.

## Décompte

Microservice métier 1 sur 6.

## Données et contrats

Base propriétaire : catalog. Classes et API : diagramme de classes, openapi.json et schema.sql. Les clés étrangères restent locales.

## Communication synchrone

Proposal appelle POST /internal/projects/{id}/award-reservations avec une identité de service et une clé stable.

## Communication asynchrone

project.published.v1.
