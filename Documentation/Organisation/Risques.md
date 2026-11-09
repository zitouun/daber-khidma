# Risques

Surdimensionnement — probabilité élevée, impact élevé : conserver les six services et limiter les fonctionnalités de chaque sprint; matching planifié après le CV; démontrer d’abord un seul parcours.
Double attribution ou annulation concurrente — probabilité moyenne, impact élevé : réservation dans Catalog sous verrou, clés stables, contraintes uniques et tests concurrents.
Panne de broker ou contrat non créé — probabilité moyenne, impact élevé : outbox, confirmations, déduplication, réconciliation et alertes sur AWARD_PENDING.
Accès aux ressources d’un autre utilisateur — probabilité moyenne, impact élevé : contrôle propriétaire à chaque service et tests négatifs.
Retard d’intégration frontend — probabilité élevée, impact moyen : contrats en premier, exemples HTTP et états d’attente visibles.
Matching peu pertinent — probabilité élevée, impact moyen : baseline déterministe, jeu d’exemples annotés, explications et recherche classique.
Informations de remise manquantes — probabilité élevée tant qu’elles restent vides, impact élevé : compléter classe/groupe, dépôt public et accès enseignant avant Blackboard.
Extraction erronée ou document malveillant — impact élevé : quarantaine, contrôle de format, traitement isolé, provenance des suggestions et validation humaine avant persistance.
Fuite de CV — impact élevé : stockage privé par propriétaire, aucun CV dans les événements, contrôle de chaque accès et suppression traçable.