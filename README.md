# Haitian-Forts
Carte interactive des Forts d'Haiti utilisant la technologie Shiny
# **Application Shiny : Carte interactive des Forts d'Haïti**
![My Image](https://github.com/stepminer/Haitian-Forts/blob/main/citadelle.jpg)

## **Description**

Cette application Shiny interactive peut etre explorée en ligne ici: https://jeunessedebout.shinyapps.io/soup_liberte_2024-main/ Elle permet de visualiser une carte des forts historiques d'Haïti, accompagnée d'une table de données détaillant leurs caractéristiques principales. Chaque fort est représenté par un marqueur sur la carte, avec des informations accessibles via des popups interactifs. Une table dynamique est également incluse pour explorer et filtrer les données associées à chaque fort. Des photos sont disponibles en cliquant sur le lien dans les fenètres popup. La qualité des données et des photos n'a pas encore été validée.

---

## **Fonctionnalités**

- **Carte interactive :**  
  Visualisez les emplacements des forts historiques d'Haïti sur une carte. Les marqueurs affichent des informations détaillées lorsque vous cliquez dessus, notamment :
  - Nom du fort
  - Taille de la garnison
  - Nombre de canons
  - Superficie en mètres carrés
  - Liens vers des ressources externes ou des images
  
- **Tableau dynamique :**  
  Explorez et filtrez les données des forts dans un tableau interactif. La table affiche des informations telles que les coordonnées géographiques, la garnison, les canons et les liens vers des informations supplémentaires.

---

## **Prérequis**

### **Installation des dépendances**

Assurez-vous que R et les bibliothèques suivantes sont installés sur votre système :

```r
install.packages("shiny")
install.packages("leaflet")
install.packages("DT")
---
# **Auteur**

Créé par PATRICK PRÉZEAU STEPHENSON EN COLLABORATION AVEC DES JEUNES D'HAITI
Contact : manifeste1804@gmail.com
https://ps-consults.com/
