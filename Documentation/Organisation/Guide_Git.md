# Publication Git à effectuer par l’équipe

Ces commandes ne sont pas exécutées par le paquet. Remplacer les valeurs entre chevrons. Choisir un nom de dépôt conforme à votre classe/groupe. Créer un dépôt public vide sur la plateforme de l’équipe, puis, depuis la racine du paquet :

```bash
git init -b main
git add .
git commit -m "docs: conception validation AWD semaine 4"
git remote add origin <URL_DU_DEPOT>
git push -u origin main
```

Ajouter le compte exact de l’enseignant dans les collaborateurs du dépôt. Une invitation envoyée peut rester en attente; vérifier son état. Vérifier aussi la visibilité publique dans une fenêtre sans connexion. Renseigner l’URL dans TEAM.md et Submission/Texte_Blackboard.md.

Organisation proposée : issues FF-xx, branches feature/FF-xx-sujet, revue par un autre membre et protection de main après création. Les noms des dossiers et fichiers fournis peuvent être conservés. Ne jamais pousser secrets, .env réel, jetons ou livrables contenant des données privées.
