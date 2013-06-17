xquery version "3.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare default element namespace 'http://ns.comem.ch/cours/XML/AdVehicleSimple';
declare option output:method "json";
declare option output:media-type "application/json";
(: imports :)
import module namespace config="http://exist-db.org/xquery/apps/config" at "config.xql";

declare function local:get_img($imgUrl as node()) {
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
                <img src="{concat($config:serveur, $contextPath, '/', data($imgUrl))}" alt="{data($imgUrl)}" />
        else if ($type = 'BinaryEncoded')then
                <img src="data:image/jpg;base64,{data($imgUrl)}" alt="{data($imgUrl)}" />
        else()
    else
        <img src="assets/img/img_failed.jpg" alt="image manquante" />
};



<queryAds>
    {
        subsequence(
            let $myCollection := collection($config:dataBaseLocation)
            for $voiture at $pos in $myCollection/Ad
            (: si il y pas de balise image on fait une balise Image empty selon la convention :)
            let $imgUrl := if($voiture/Image)then ($voiture/Image[1]) else <Image>empty</Image>
            order by util:random()
            return
                <cars>
                    <mark>{data($voiture//Make)}</mark>
                    <model>{data($voiture//Model)}</model>
                    <name>{($voiture//Contact/LastName)}</name>
                    <url>{local:get_img($imgUrl)}</url>
                </cars>
        ,1,6)
    }
</queryAds>

