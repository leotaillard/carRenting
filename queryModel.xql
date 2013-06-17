xquery version "3.0";
declare namespace output ="http://www.w3.org/2010/xslt-xquery-serialization";
declare default element namespace 'http://ns.comem.ch/cours/XML/AdVehicle';
declare option output:method "json";
declare option output:media-type "application/json";
<queryModel>
    
{
let $mesVoitures := collection("/db/carrenting/dataBase/")
let $getMark := lower-case(request:get-parameter("make",""))
let $marque := for $k in $mesVoitures where lower-case($k//Make) = $getMark return ($k)
let $model := for $j in ($marque//Model) return lower-case($j)

for $i in distinct-values($model)

let $CountModel := for $l in ($marque//Model) where data(lower-case($l)) = $i return 1
return
<modele>
    <nom>{$i}</nom>
    <nombre>{count($CountModel)}</nombre>    
</modele>

}

</queryModel>

