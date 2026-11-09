# Frontend de Dabber Khdma

Une application Next.js/TypeScript commune accueille les pages de chaque membre. Les formulaires et écrans communiquent uniquement avec la Gateway et les backends métier. Aucun accès direct au moteur IA Python/FastAPI, aucune URL ou clé de moteur dans le bundle.

Ayoub : éditeur du profil professionnel, compétences, expériences, formations, langues, portfolio, disponibilité et visibilité; import/suivi du CV; relecture/confirmation des suggestions; prévisualisation du profil et offres recommandées. Voir Documentation/Organisation/Mission_Ayoub_Backend_Frontend.md pour les API, erreurs et critères.

Les autres membres réalisent les pages de leurs domaines selon Repartition_Backend_Frontend.md. L’authentification et la gestion des comptes sont partagées. Le CV et les résultats passent par le backend d’Ayoub; le frontend n’enregistre jamais directement les données dans une base ou un moteur.

Maquettes.html est un support de conception avec données fictives, sans API connectée. Les implémentations frontend et backend restent à réaliser.
