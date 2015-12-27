Elliot Vanegue
==============

# TP Markov

## Etat du TP

Le tp fonctionne, mais la reconnaissance des gestes n'est pas très bonne.

## Réponse aux questions

Q3) Le défaut de la méthode d'extraction proposée est qu'il y a beaucoup d'arrondie,
donc beaucoup d'imprécision. Par exemple, le fait que la valeur de l'angle
soit absolue ne permet pas de différencier deux formes symétriques par rapport
à l'axe horizontal.

Q4)
* computeKmeansLearner : création de la liste de template
* trainHMM : envoit les données à l'algorithme de reconnaissance pour créer une
base d'apprentissage.

Q7) Les scores sont beaucoup trop bas et beaucoup trop irrégulier pour que le
seuil ait un impact sur le résultat. Lorsque je mets un seuil, soit j'ai le même
résultat qu'avant si le seuil est trop bas (ex : 10^-100), soit je ne récupère
plus aucun geste si le seuil est trop haut (ex : 10^-50).

Q8)
le pas de temps:
* si on le diminue, il reconnait de moins en moins bien les formes.
* si on l'augmente, les scores augmentent également, mais les formes demandant
plus de précision, comme des mots, sont moins bien reconnus.
