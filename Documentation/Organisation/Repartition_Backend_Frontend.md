# Répartition du travail backend et frontend

Chaque membre réalise le backend de son domaine et les pages associées dans le frontend Next.js commun. Les six services métier restent distincts; il n’y a pas six applications frontend.

| Responsable | Travail backend | Travail frontend | Critère de validation |
|---|---|---|---|
| Rayen | CRUD et recherche d’offres, catégories/compétences requises, publication, annulation et réservation unique | Création/modification d’offre, catalogue, filtres, détail et états de publication | Un brouillon reste privé; une offre publiée est recherchable; une attribution concurrente reste unique |
| Rana | Proposition active unique, versions, présélection, retrait, sélection idempotente et outbox d’acceptation | Formulaire de candidature, mes propositions, comparaison client et attente de contrat | Un tiers ne voit pas les candidatures privées; 202 affiche un suivi réel |
| Yassin | Contrat idempotent, jalons, livrables, révision, approbation et litiges | Tableau de contrat, suivi des jalons, dépôt de livrable, approbation et demande de révision | Seuls les participants agissent; un litige bloque les transitions finales |
| Farah | Conversations, participants, messages persistés, pièces jointes et droits à chaque accès | Liste des conversations, fil paginé, envoi, pièces jointes et états de lecture | Seuls les participants lisent/écrivent; une notification ne remplace pas la persistance |
| Oussama | Consommateurs d’événements, déduplication, préférences, inbox, courriel, retries et DLQ | Centre de notifications, badge/non-lu, préférences et liens vers les ressources autorisées | Un événement rejoué ne crée pas un doublon et l’envoi respecte les préférences |
| Ayoub | Profil professionnel, version/visibilité, CV privé, suggestions, matching et adaptateur IA interne | Éditeur de profil, import/suivi CV, relecture/confirmation, profil public et recommandations | Le frontend ne contacte jamais l’IA; le backend conserve la décision et les données confirmées |

## Travail commun

OIDC et comptes, Gateway, mise en page et composants partagés, client API, routes frontend, conventions d’erreur, observabilité et intégration. Les rôles de sécurité restent dans le socle commun; le profil professionnel appartient à Ayoub.

## Liaison IA par propriétaire métier

Le frontend appelle un cas d’usage du backend concerné. Ce backend valide les droits et données, puis appelle son moteur IA privé par un adaptateur. Il vérifie et conserve le résultat avant de le publier à l’utilisateur. Aucun frontend, route publique Gateway ou autre backend ne contourne cette responsabilité.

À ce stade, seule la fonction d’Ayoub exige un moteur IA : extraction du CV et scoring des offres. Pour un futur usage IA chez un autre membre, ajouter le contrat privé, l’adaptateur, les délais, les tests d’indisponibilité et la trace de décision dans son microservice. Aucun nouveau cas d’usage IA n’est prétendu déjà défini.

## Livraison d’une fonctionnalité

Une issue décrit la règle métier, l’API, l’écran, les erreurs, les événements et les critères testables. Le même responsable vérifie la cohérence backend/frontend; un autre membre relit la pull request. Le test final suit un parcours utilisateur et inclut accès refusé, état asynchrone et reprise après panne.
