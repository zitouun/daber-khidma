# Plan de validation

T01 — Un brouillon reste inaccessible aux autres comptes; publication rend le projet visible dans la recherche.
T02 — Une seconde proposition active pour le même couple renvoie 409; la candidature du propriétaire est refusée.
T03 — Deux acceptations concurrentes et une annulation concurrente aboutissent à une seule réservation; aucun contrat n’apparaît pour un perdant.
T04 — Rejouer proposal.accepted avec le même eventId, puis un nouvel eventId portant le même proposalId, conserve un seul contrat.
T05 — Arrêter le publisher après commit métier conserve l’outbox; son redémarrage publie sans perte et sans effets métier en double.
T06 — Arrêter Proposal après réservation mais avant commit local laisse une intention récupérable; la réconciliation utilise la même clé.
T07 — Un tiers ne peut lire contrat, conversation, livrable ou job d’un autre utilisateur; aucun effet métier ne suit le refus.
T08 — Un jalon en litige ne peut être approuvé; une révision conserve l’historique et exige une nouvelle soumission.
T09 — Un message consommé deux fois ne crée qu’une notification; un message invalide finit en DLQ après les essais prévus.
T10 — Un job IA en échec laisse recherche et candidature utilisables; seul son propriétaire consulte les résultats.
Ces scénarios sont planifiés pour le développement. Ils n’ont pas été exécutés sur une application métier. Le contrôle actuel vérifie les fichiers, relations de contrats et exports du pack.
T11 — Un CV d’un autre utilisateur ne peut être lu, prérempli ou supprimé. Un fichier trop volumineux retourne 413 et un type refusé 415.
T12 — Aucun champ extrait n’entre dans le profil avant confirmation; modifier le CV ne modifie pas rôles, droits ou adresse vérifiée.
T13 — Une confirmation avec expectedProfileVersion périmée retourne 409 et conserve le profil courant.
T14 — Après suppression ou changement de version du CV, un worker tardif ne réintroduit aucune suggestion.
T15 — Le matching utilise uniquement la version confirmée; les compétences non validées et champs sensibles n’influencent pas le score.
T16 — Le frontend, la Gateway et un jeton utilisateur ne peuvent appeler le moteur IA privé; seules les identités de backend avec scope valide sont acceptées.
T17 — Une modification manuelle de profil augmente sa version, conserve les champs non modifiés et invalide les anciens résultats.
T18 — Le moteur IA indisponible laisse l’éditeur, le profil et la recherche utilisables; le frontend suit uniquement le statut backend.
T19 — La réponse publique du profil n’expose ni CV, ni coordonnées de compte, ni rôles.
T20 — Le résultat IA ne peut modifier aucun champ non autorisé; le backend vérifie schéma, propriétaire, versions et identifiants avant persistance.