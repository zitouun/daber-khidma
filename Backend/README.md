# Backend de Dabber Khdma

Six backends métier Spring Boot : Catalogue (Rayen), Propositions (Rana), Contrats (Yassin), Communication (Farah), Notifications (Oussama), Profil professionnel/CV/Matching (Ayoub).

Authentification OIDC, comptes et rôles forment un socle commun hors décompte. Le profil professionnel n’est plus dans ce socle : il appartient au backend d’Ayoub.

Le dossier ai-engine décrit le moteur Python/FastAPI technique et privé. Il est appelé uniquement par les backends autorisés, via leurs adaptateurs; le frontend et la Gateway n’exposent aucune API du moteur. Les workers restent des composants de leurs backends propriétaires.

Le pack contient contrats, modèles SQL et travaux à réaliser, sans application métier implémentée. La mission full-stack d’Ayoub et la répartition des six membres sont dans Documentation/Organisation.
