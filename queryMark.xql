xquery version "3.0";
declare namespace output ="http://www.w3.org/2010/xslt-xquery-serialization";
declare default element namespace 'http://ns.comem.ch/cours/XML/AdVehicle';
declare option output:method "json";
declare option output:media-type "application/json";
(:  declare option exist:serialize "method=json jsonp=carRentingFct"; //Permettra de faire du jsonp dans le cas ou l'on veut faire une appli crossdomaine ou API :)
<queryMark>
{
let $mesVoitures := collection("/db/carrenting/dataBase/")
let $make := for $j in $mesVoitures/Ad//Make return lower-case($j)
for $i in distinct-values($make) order by $i

return
<Marque>{$i}</Marque>

}
</queryMark>
