# Dabber Khdma · présentation HTML AWD

Application indépendante : 19 diapositives, 13 minutes prévues, six interventions individuelles de 50 secondes. Discussion séparée : 10 minutes. Aucun backend modifié.

```sh
pnpm install
pnpm dev
pnpm build
pnpm preview
```

Ouvrir l’URL affichée par Vite. Le build statique est dans `dist/`. Les images, diagrammes et polices sont locaux : aucun accès Internet nécessaire après installation, avec serveur local actif. Le build doit être servi en HTTP, pas ouvert par file://.

Flèches et Espace : navigation ; Home/End : début/fin ; O : vue d’ensemble avec recherche ; N : notes et chronomètre manuel ; F : plein écran ; Échap : fermer. Les panneaux de détail contiennent les modèles complets et contrats. Imprimer via le panneau d’aide ou le navigateur : une page 16:9 par diapositive, arrière-plans activés.

Le contenu, les durées et notes sont dans `src/content/slides.ts`. Les modèles de services et routages sont copiés du pack dans `src/content/`. Diagrammes SVG générés : `src/diagrams/index.ts`; modèles complets éditables : `public/diagrams/`. Tokens CSS : `src/styles/main.css`. L’illustration Farfour est le PNG propre original, sans modification. Les autres poses restent indisponibles ; aucun asset de pose n’est revendiqué.

## Sources et arbitrages

Consigne enseignant : `public/Consigne_enseignant.pdf`, pages 1–3. TEAM.md, dossier technique, contrats et 22 diagrammes du pack inspectés. Le dossier et les anciennes notes contiennent des contradictions historiques : les contrats actuels et diagrammes récents priment. Le profil professionnel appartient au service 6 d’Ayoub ; le socle ne conserve que comptes et rôles. Le moteur IA privé est appelé par le worker backend, sans accès direct au broker, stockage, bases ou navigateur. L’événement réel proposé est `contract.created.v1`.

Les affectations de Rayen, Rana, Yassin, Farah et Oussama restent proposées. Ayoub est confirmé. Groupe, date, URL publique du dépôt, accès enseignant et calendrier restent à compléter. Les APIs sont des contrats proposés ; aucun résultat métier ou déploiement n’est affirmé.

Références officielles vérifiées : [RabbitMQ confirms](https://www.rabbitmq.com/docs/confirms), [Spring Security JWT](https://docs.spring.io/spring-security/reference/servlet/oauth2/resource-server/jwt.html), [PostgreSQL contraintes](https://www.postgresql.org/docs/current/ddl-constraints.html).

## Correspondance AWD

| Consigne | Couverture |
|---|---|
| p.1 idée, problématique, fonctionnalités | 1–5 |
| p.1 acteurs et cas d’utilisation | 4, UML |
| p.1 architecture, Gateway, données, sécurité, technologies | 6–10 |
| p.1–2 responsabilités et bases par service | 10–16, 17 |
| p.2 classes, APIs, codes HTTP et événements | 10–16, panneaux complets |
| p.2 interactions synchrones / asynchrones | 7–8 et chaque service |
| p.2 chaque étudiant ≤ 1 minute | 11–16 : 50 secondes chacun |
| p.2 service commun / un délégué | 10 : toute l’équipe, Ayoub |
| p.2 Git, outil de gestion, planning, risques | 17–18 |
| p.2 durée 10–15 min / discussion 10 min | 13 min + discussion séparée |
| p.1–3 dépôt public, enseignant, Blackboard | Restent des actions externes de l’équipe |

## Validation et limites

`pnpm build` réussit : TypeScript strict et build Vite. Les styles comprennent reduced-motion, adaptation mobile et impression de toutes les slides. La taille du canvas reste 1600×900, mise à l’échelle dans la fenêtre ; utiliser les détails en grand format pour lire les modèles sur petit écran. Les notes sont dans un panneau visible sur le même écran : ce n’est pas une fenêtre privée multi-écrans. Aucun test métier du plan T01–T15 n’a été exécuté.
