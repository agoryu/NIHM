# Application de visualisation de données de la carte de France

Elliot Vanegue
==============

## Objectif
L'objectif de ce TP est de représenter des informations concernant la France dans une carte en utilisant l'outil Processing.

## Sélection des données
J'ai décidé d'utiliser les données concernant la population et la densité de population, car cela me paraissait être les données les plus intéressantes dans le but d'utiliser les connaissances que nous avons vu en cours.

## Représentation des données
* position des villes : position en (x,y) de la ville
* population : pour représenter la population, j'ai décidé d'utiliser la taille d'un cercle. Cette donnée est ordinal.
* densité de population : pour cette donnée j'ai choisi la couleur. J'ai utilisé un dégradé allant du jaune, pour les villes les moins peuplé, au rouge.

## Travail effectué
J'ai réalisé l'ensemble du TP jusque la première étape optionnel (je n'ai pas réussi à être un gouroux). J'ai, cependant, rajouté une légende à droite de la carte, afin d'expliquer ce que représente la couleur et les taille de cercle.

## Interaction
* Il est possible d'afficher le nom d'une ville lorsque la souris est sur le cercle représentant celle-ci
* Lorsque l'on clique sur une ville le nom de celle-ci change de couleur
* Le déplacement du curseur sur le slider ajoute/retire des villes en fonction du nombre d'habitant. Le slider jusque 10 000 et a un intervalle de 100

## Sources
[slider](https://processing.org/examples/scrollbar.html)
[dégradé de la légende](https://processing.org/examples/lineargradient.html)
