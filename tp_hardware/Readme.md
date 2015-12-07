# Jeux pong avec LED

Elliot Vanegue et Samuel Grandsir
=================================

## Introduction
Lors de ce TP, nous apprenons à programmer un périphérique grâce à uc-SDK.
Pour cela, nous avons réalisé une application reprenant le concept du jeux
pong.

## Projet
L'objectif de notre projet est de réaliser un mini jeux pong grâce aux outils
qui nous sont mis à disposition. Nous avons donc utilisé deux boutons simulant
les raquettes de tennis et cinq LED représentant la trajectoire de la balle.

Les LEDs vont s'allumer une par une dans la direction d'un joueur. Celui-ci
doit appuyer sur le boutons au moment ou la derniere LED de son côté s'allume.
Cela permet de rallumer les LEDs dans la direction du joueur adverse. Le jeu
se termine lorsque l'un des joueurs n'a pas appuyer sur le bouton au bon moment.

## Réalisation
Nous avons réussi à créer le mouvement de la balle, les LEDs s'allume une
par une dans une direction. L'appui sur un bouton est bien reconnu.

## Non fonctionnel
Nous n'avons pas réussi à faire en sorte que les LEDs se rallume lorsque le joueur
appui sur le bouton au bon moment.

## Pour aller plus loin
Nous voulions également placer un vibreur sur le circuit afin que celui-ci vibre
lorsque l'un des joueurs frappe bien dans la balle au bon moment. Cela aurai pu
servir à indiquer au joueur si sa frappe a été efficace.

Nous voulions également allumer les LEDs du côté du joueur victorieux.
