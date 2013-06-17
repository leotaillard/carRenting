xquery version "3.0" encoding "iso-8859-15";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare default element namespace 'http://ns.comem.ch/cours/XML/AdVehicle';
declare option output:method "json";
declare option output:media-type "application/json";

import module namespace config="http://exist-db.org/xquery/apps/config" at "config.xql";

<queryAds>
    {
    let $myCollection := collection($config:dataBaseLocation)
    
    
        (: si il y pas de balise image on fait une balise Image empty selon la convention :)
        let $etat := for $j in $myCollection/Ad//Data//Status return $j
        for $i in distinct-values($etat)
        return
        
            <etat>{$i}</etat>

        
}
    
</queryAds>