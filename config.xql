xquery version "3.0";
module namespace config="http://exist-db.org/xquery/apps/config";

(: 
    fichier qui contient toutes les variables globale de config.
:)
declare variable $config:serveur := "http://localhost:8080/exist/rest";
declare variable $config:dataBaseLocation := "/db/carrenting/dataBase";