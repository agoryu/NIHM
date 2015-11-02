# Application de visualisation de données de la carte de France

Elliot Vanegue
==============

## Objectif
L'objectif de ce TP est de représenter des informations concernant la France dans une carte en utilisant l'outil Processing.

## Lancement de l'application
* Démarez processing
* Ouvrez tp1/France/France.pde
* Cliquez sur play

## Sélection des données
J'ai décidé d'utiliser les données concernant la population et la densité de population, car cela me paraissait être les données les plus intéressantes dans le but d'utiliser les connaissances que nous avons vu en cours.

## Représentation des données
* position des villes : position en (x,y) de la ville
* population : pour représenter la population, j'ai décidé d'utiliser la taille d'un cercle. Cette donnée est ordinal et reste proportionnel pour chaque ville, ce qui facilite la comparaison entre chacune d'elles.
* densité de population : pour cette donnée j'ai choisi la couleur. J'ai utilisé un dégradé allant du jaune, pour les villes les moins peuplées, au rouge.
J'ai choisi ce dégradé de couleur, car le rouge peut représenter des données critiques (le danger) or une densité trop importante peut-être perçu comme un problème.

## Travail effectué
J'ai réalisé l'ensemble du TP et j'ai rajouté une légende. Pour le niveau gourou, j'ai réalisé le zoom et l'intervalle des villes à afficher. Le zoom ne se fait pas à la position de la souris.

## Interaction
* Il est possible d'afficher le nom d'une ville lorsque la souris est sur le cercle représentant celle-ci
* Lorsque l'on clique sur une ville le nom de celle-ci change de couleur
* Il y a un slider avec deux curseurs afin d'afficher les villes ayant un nombre d'habitant dans un certain intervalle.
* Il est possible de zoomer à plusieurs reprise, mais le zoom se fait toujours dans le coin haut gauche. Le zoom s'effectut avec la molette de la souris.
* Lorsqu'il y a un zoom sur la carte, il est possible de déplacer la carte afin d'observer d'autre parti de celle-ci. Pour le deplacement il faut rester cliqué sur la carte et déplacer la souris.

## Sources
* [slider](https://processing.org/examples/scrollbar.html)
* [dégradé de la légende](https://processing.org/examples/lineargradient.html)
