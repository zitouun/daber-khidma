# Moteur IA privé

Composant technique Python/FastAPI, intégré au backend métier d’Ayoub. Il ne constitue pas un septième service métier étudiant. Aucun endpoint de ce composant n’est routé par la Gateway publique et aucun écran ne l’appelle.

Le worker backend envoie le fichier validé à POST /v1/extract, ou les compétences confirmées et exigences des offres à POST /v1/score. L’IA répond au backend; elle ne modifie ni profil ni base métier et ne publie pas de notifications. Le backend valide les résultats, les versions et les droits avant persistance et réponse à l’utilisateur.

Authentification de service avec audience et scopes dédiés; pas de clé dans le navigateur. Accès privé limité aux backends autorisés, aucun port Internet. Le moteur ne lit pas directement les bases, le stockage objet ou RabbitMQ : son unique interlocuteur applicatif est le backend. Limiter taille, durée et mémoire de calcul, traiter le CV comme des données, ne suivre aucun lien et ne conserver aucun texte privé dans les logs.

Contrat : internal.openapi.json. Implémentation du moteur, de l’adaptateur HTTP et des scénarios de reprise à réaliser.
