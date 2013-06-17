xquery version "3.0";
module namespace functions="http://exist-db.org/xquery/apps/functions";
import module namespace config="http://exist-db.org/xquery/apps/config" at "config.xql";
(: 
    fichier qui contient toutes les fonctions publiques
:)
declare function functions:get_img($imgUrl as node()) {
    (: test si l'image est vide -> contient empty ou si le retour est 404 -> contient chaine vide :)
    if ( (data($imgUrl) != "empty") )then
        let $type := data($imgUrl/@Type)
        return
        (: variable qui contient le chemin de l'annonce courante sans url du serveur :)
        let $contextPath := util:collection-name($imgUrl)
        return
        (: la fonction httpclient ne supporte pas les crochets :)
        if($type = 'Link' and not(contains(data($imgUrl), '[')) )then
            let $response := httpclient:get(data($imgUrl), false(), <header/>)
            return
            (: si le type est link tester si url commence par http:)
            if (substring(data($imgUrl), 1, 4) = 'http')then
                if($response[@statusCode != '404'])then
                    <img src="{data($imgUrl)}" alt="{data($imgUrl)}" />
                else
                    <img src="assets/img/img_failed.jpg" alt="image manquante" />
            else
                <img src="{concat($config:serveur, $contextPath, '/', data($imgUrl))}" />
        else if ($type = 'BinaryEncoded')then
                <img src="data:image/jpg;base64,{data($imgUrl)}" alt="{data($imgUrl)}" />
        else()
    else
        <img src="assets/img/img_failed.jpg" alt="image manquante" />
};

(: fonction qui test si le champs est vide ou inexistant :)
declare function functions:check_field($expr as item()*, $text){
    if($expr != "")then
        concat($expr,concat(" ",$text))
    else
        "-"
};