# Dabber Khdma — validation intermédiaire AWD, semaine 4

Classe : SSA 9. Équipe : Rayen, Rana, Yassin, Farah, Oussama et Ayoub.
Groupe : **À RENSEIGNER**. Date : **À RENSEIGNER**.
Dépôt Git public : **À RENSEIGNER**. Enseignant collaborateur : **À VÉRIFIER**.

## Structure de remise

```text
├── Backend/
├── Frontend/
├── Documentation/
│   ├── Presentation/
│   ├── Diagrams/
│   ├── Technique/
│   ├── Contrats/
│   ├── Organisation/
│   ├── Identite_Visuelle/
│   └── References/
└── README.md
```

- **Backend/** : conception des six services métier, socle comptes partagé, Gateway, moteur IA privé et infrastructure. Contient modèles et contrats de conception ; les services ne sont pas annoncés comme implémentés.
- **Frontend/** : conception du frontend marketplace Next.js/TypeScript et maquettes existantes. Le frontend métier est distinct de la présentation HTML.
- **Documentation/Presentation/** : présentation HTML Vite/TypeScript, sources, assets locaux, notes et build statique `dist/`. 19 diapositives, cible 13 minutes, six interventions individuelles de 50 secondes. Voir son README pour la checklist AWD et les limites de validation.
- **Documentation/Diagrams/** : architecture globale PNG, modèles SVG éditables, exports et galerie des diagrammes.
- **Documentation/Technique/Dossier_Technique.docx** et **Dossier_Technique.pdf** : dossier technique existant, accompagné de ses sources. Certains passages historiques sur le profil contredisent les contrats actuels : à relire avant remise. Les contrats actuels et diagrammes récents placent le profil professionnel chez Ayoub.
- **Documentation/Contrats/** : API OpenAPI, exemples HTTP et contrats d’événements proposés.
- **Documentation/Organisation/** : équipe, responsabilités, missions, planning, risques et plan de validation.
- **Documentation/References/Consigne_enseignant.pdf** : consigne de référence.

## Lancer la présentation HTML

Depuis `Documentation/Presentation/` :

```sh
pnpm install
pnpm dev
```

Pour produire puis servir le build statique :

```sh
pnpm build
pnpm preview
```

Les polices et images sont locales. Le serveur local fonctionne sans Internet une fois les dépendances installées. Pour servir le build fourni sans installer les dépendances : `python3 -m http.server 8080 --directory Documentation/Presentation/dist`, depuis la racine de ce dossier, puis ouvrir http://localhost:8080.

Flèches / Espace : navigation. O : aperçu. N : notes. F : plein écran. Home / End : première / dernière. Échap : fermer. Impression PDF depuis l’aide ou le navigateur, avec arrière-plans activés.

## Avant le dépôt Blackboard

1. Compléter groupe, date, URL du dépôt public et compte enseignant ; vérifier son accès collaborateur.
2. Confirmer les cinq affectations proposées (Ayoub confirmé), le calendrier et le déposant unique.
3. Relire le dossier technique pour harmoniser les passages historiques avec les contrats et diagrammes récents.
4. Répéter les interventions, vérifier les diagrammes sur le projecteur et exporter le PDF de la présentation si demandé.
5. Déposer le lien Git, le dossier technique, la présentation HTML (archive si nécessaire) et l’architecture globale, selon les modalités Blackboard de l’enseignant.

Le rendu porte sur une conception proposée, sans revendication d’application déployée ou de tests métier réussis. Les anciens PPTX/PDF de présentation ont été conservés dans une sauvegarde extérieure à ce dossier pour éviter de les confondre avec la nouvelle version HTML.

## Vérification de la structure après nettoyage

La racine contient uniquement Backend/, Frontend/, Documentation/ et README.md. Les six domaines métier et le socle commun sont présents. Les modèles SQL, contrats OpenAPI, exemples HTTP et événements sont conservés pour la validation technique.

Les diagrammes SVG éditables et PNG restent disponibles ; les anciens DOT, l’atlas PDF redondant, les exports individuels de missions Word/PDF et les logos PNG redondants ont été retirés. Les missions Markdown et le PDF collectif sont conservés. Le dossier technique reste fourni en Word, PDF et source Markdown.

Les copies d’assets dans Presentation/public/ et Presentation/dist/ sont nécessaires : public/ sert au développement, dist/ est le livrable statique prêt à servir. Ne pas les supprimer comme doublons. Le dossier n’inclut ni node_modules ni captures de test.
