xquery version "3.0" encoding "iso-8859-15";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare default element namespace 'http://ns.comem.ch/cours/XML/AdVehicle';
declare option output:method "json";
declare option output:media-type "application/json";

import module namespace config="http://exist-db.org/xquery/apps/config" at "config.xql";
import module namespace functions="http://exist-db.org/xquery/apps/functions" at "functions.xql";

<queryAds>
    {
    let $myCollection := collection($config:dataBaseLocation)
    let $getMake := lower-case(request:get-parameter("make",""))
    let $getModel := lower-case(request:get-parameter("model",""))
    let $getName := lower-case(request:get-parameter("name",""))
    let $getEtat := lower-case(request:get-parameter("etat",""))
    
    let $getPrixMin := request:get-parameter("prixMin",0) cast as xs:float

    (: let $Amount := for $j in $myCollection/Ad//Amount return $j
    let $maxAmount := max($Amount) cast as xs:float 
    
    permettra de rendre le prix maximum de la collection
    :)
    
    let $getPrixMax := request:get-parameter("prixMax",500000) cast as xs:float 

    let $request := concat(
                                    "true()",
                                    if ($getMake = "")
                                        then ()
                                        else " and lower-case($x//Make) = lower-case($getMake)"
                                )
    let $request := concat(
                                    $request,
                                    if ($getModel = "")
                                        then ()
                                        else " and lower-case($x//Model) = lower-case($getModel)"
                                )
    let $request := concat(
                                    $request,
                                    if ($getName = "")
                                        then ()
                                        else " and lower-case($x//LastName) = lower-case($getName)"
                                )
    let $request := concat(
                                    $request,
                                    if ($getEtat = "")
                                        then ()
                                        else " and lower-case($x//Status) = lower-case($getEtat)"
                                )
    let $request := concat(
                                    $request,
                                    if ($getPrixMin = 0)
                                        then ()
                                        else " and ($x//Amount) cast as xs:float > $getPrixMin"
                                )
    let $request := concat(
                                    $request,
                                    " and ($x//Amount) cast as xs:float <= $getPrixMax"
                                )
    

    for $x at $pos in $myCollection/Ad
        (: si il y pas de balise image on fait une balise Image empty selon la convention :)
        let $imgUrl := if($x/Images/Image) then ($x/Images/Image[1]) else <Image>empty</Image>
        where util:eval($request)
        return
        <cars>
            <Source>{data($x//Source/Url)}</Source>
            <InfoDate>
                <CreatedDate>{functions:check_field(data($x//CreatedDate),"")}</CreatedDate>
                <ModifiedDate>{functions:check_field(data($x//ModifiedDate),"")}</ModifiedDate>
            </InfoDate>
            <Contact>
                <LastName>{data($x//LastName)}</LastName>
                <FirstName>{data($x//FirstName)}</FirstName>
                
                <Phone>{functions:check_field(data($x//Phone[1]),"")}</Phone>
                <Email>{functions:check_field(data($x//Email),"")}</Email>
            </Contact>
            <Type>
                <Make>{data($x//Make)}</Make>
                <Model>{data($x//Model)}</Model>
            </Type>
            <TechnicalData>
                <Power>{data($x//Power)}</Power>
                <Cm3>{functions:check_field(data($x//Cm3),"Cm3")}</Cm3>
                <Gear>{functions:check_field(data($x//Gear/@Type), "")}</Gear>
                <Weight>{functions:check_field(data($x//Weight), "Kg")}</Weight>
                <Fuel>{functions:check_field(data($x//Fuel[1]/@type), "")}</Fuel>
                
            </TechnicalData>

            <Data>
                <Status>{data($x//Status)}</Status>
                <Km>{functions:check_field(data($x//Km),"Km")}</Km>
                <Color>{data($x//Color)}</Color>
                <Places>{functions:check_field(data($x//Places),"")}</Places>
                <InsideColor>{functions:check_field(data($x//InsideColor),"")}</InsideColor>
                <Doors>{data($x//Doors)}</Doors>
            </Data>
            <Images>{functions:get_img($imgUrl)}</Images>
        
            <Amount>{functions:check_field(data($x//Amount)," CHFS")}</Amount>


            <Warranty>{functions:check_field(data($x//Warranty), "Mois")}</Warranty>
            
            {
            if(data($x/Ad//Comment) != "")then
                <Comment>{data($x/Ad//Comment)}</Comment>
            else
                <Comment>il n'y a pas de commentaires</Comment>
            }
            </cars>
}
    
</queryAds>