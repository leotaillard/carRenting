xquery version "3.0" encoding "iso-8859-15";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare default element namespace 'http://ns.comem.ch/cours/XML/AdVehicle';
declare option output:method "json";
declare option output:media-type "application/json";

import module namespace config="http://exist-db.org/xquery/apps/config" at "config.xql";

(: redonne le prix maximum de notre collection en json :)

<queryAds>
    {
    let $myCollection := collection($config:dataBaseLocation)
    
    
        let $maxAmount := for $j in $myCollection/Ad//Amount return $j
        
        return
        
            <prix>{max($maxAmount)}</prix>

        
}
    
</queryAds>