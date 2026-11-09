# Mission de Rayen — Catalogue de projets

Classe SSA 9 · microservice métier 1 sur 6. Cette fiche décrit le travail à réaliser.

## Backend

Créer, modifier, publier, rechercher et annuler les projets. Contrôler le propriétaire, les états et les budgets. Assurer la réservation atomique d’une attribution, avec clé idempotente et verrou partagé avec l’annulation. Émettre les événements depuis une outbox.

Données propriétaires : base `catalog`. Le backend valide les entrées, vérifie l’identité et les droits sur chaque ressource, conserve ses données et renvoie des erreurs compréhensibles. Les références vers les autres services sont des identifiants externes.

Communication synchrone : Proposal appelle POST /internal/projects/{id}/award-reservations avec une identité de service et une clé stable.

Communication asynchrone : project.published.v1. Les consommateurs utilisent des traitements idempotents et des reprises bornées.

## Frontend

Créer les écrans de publication, modification, recherche et filtres. Afficher les détails, les compétences demandées, les états du projet et les erreurs de validation.

Les pages appartiennent à l’application Next.js commune et utilisent les API du backend via la Gateway. Elles doivent gérer chargement, données absentes, accès refusé et erreurs, ainsi que la navigation clavier et mobile.

## Écrans et contrats à relier

- `POST /projects` : Créer un brouillon — 201.
- `GET /projects` : Rechercher les projets ouverts — 200.
- `GET /projects/{id}` : Lire un projet visible — 200.
- `POST /projects/{id}/publish` : Publier son projet — 200.
- `POST /projects/{id}/cancel` : Annuler avant réservation — 200.

Les contrats complets, entrées, réponses et erreurs se trouvent dans `Documentation/Contrats/project-catalog.openapi.json`.

## Ordre de réalisation proposé

1. Définir les règles métier et les modèles de données.
2. Implémenter les API, validations, autorisations et tests backend.
3. Réaliser les pages et le client API frontend avec les états d’erreur.
4. Intégrer les échanges avec les services concernés et les événements.
5. Vérifier le parcours complet, les accès refusés et les reprises.

## Critères de fin

- Un brouillon reste privé; deux demandes concurrentes ne peuvent réserver le même projet.
- Les données appartiennent au service et les accès sont vérifiés côté backend.
- Les écrans et contrats décrivent les mêmes comportements et états.
- Une fonctionnalité IA future est appelée par ce backend, jamais directement par le frontend.
- Les tests métier et d’intégration sont réalisés avec l’implémentation.
