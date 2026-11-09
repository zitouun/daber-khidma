# Mission de Yassin — Contrats et jalons

Classe SSA 9 · microservice métier 3 sur 6. Cette fiche décrit le travail à réaliser.

## Backend

Créer le contrat de manière idempotente après sélection. Gérer jalons, livrables, demandes de révision, approbations et litiges; contrôler les participants et transitions. Publier les événements de contrat et jalon.

Données propriétaires : base `engagement`. Le backend valide les entrées, vérifie l’identité et les droits sur chaque ressource, conserve ses données et renvoie des erreurs compréhensibles. Les références vers les autres services sont des identifiants externes.

Communication synchrone : Communication appelle GET /contracts/{id} pour vérifier les participants; Engagement lit le stockage objet pour valider les métadonnées d’un livrable.

Communication asynchrone : contract.created.v1 / milestone.approved.v1. Les consommateurs utilisent des traitements idempotents et des reprises bornées.

## Frontend

Créer le tableau des contrats, la vue des jalons, le dépôt de livrables, la demande de révision et l’approbation. Afficher clairement les états et les erreurs.

Les pages appartiennent à l’application Next.js commune et utilisent les API du backend via la Gateway. Elles doivent gérer chargement, données absentes, accès refusé et erreurs, ainsi que la navigation clavier et mobile.

## Écrans et contrats à relier

- `GET /contracts/{id}` : Lire son contrat — 200.
- `POST /contracts/{id}/milestones` : Créer un jalon — 201.
- `POST /milestones/{id}/submit` : Soumettre les métadonnées du livrable — 200.
- `POST /milestones/{id}/approve` : Approuver un livrable — 200.
- `POST /milestones/{id}/request-revision` : Demander une révision — 200.
- `POST /contracts/{id}/disputes` : Ouvrir un litige — 201.
- `POST /milestones/{id}/start` : Démarrer un jalon planifié — 200.

Les contrats complets, entrées, réponses et erreurs se trouvent dans `Documentation/Contrats/engagement.openapi.json`.

## Ordre de réalisation proposé

1. Définir les règles métier et les modèles de données.
2. Implémenter les API, validations, autorisations et tests backend.
3. Réaliser les pages et le client API frontend avec les états d’erreur.
4. Intégrer les échanges avec les services concernés et les événements.
5. Vérifier le parcours complet, les accès refusés et les reprises.

## Critères de fin

- Un tiers ne peut accéder au contrat; un litige ouvert bloque la clôture; un événement rejoué ne crée pas deux contrats.
- Les données appartiennent au service et les accès sont vérifiés côté backend.
- Les écrans et contrats décrivent les mêmes comportements et états.
- Une fonctionnalité IA future est appelée par ce backend, jamais directement par le frontend.
- Les tests métier et d’intégration sont réalisés avec l’implémentation.
