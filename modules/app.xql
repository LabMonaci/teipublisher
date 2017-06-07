xquery version "3.1";

(: Module for app-specific template functions :)
module namespace app="teipublisher.com/app";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function app:navigation-header($node as node(), $model as map(*)) {
    let $root := $model('data')/ancestor-or-self::tei:TEI
    let $title := $root/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text()
    let $sourceDesc := $root/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p/text()
    let $correspDesc := $root//tei:correspDesc
    return
        <div>
            <!-- <h5>{$title}</h5> -->
            <div>
                <b>Mittente: </b>
                <span>{$correspDesc/tei:correspAction[@type='sent']/tei:persName}</span>
            </div>
            <div>
                <b>Destinatario: </b>
                <span>{$correspDesc/tei:correspAction[@type='received']/tei:persName}</span>
            </div>
            <div>
                <b>Data: </b>
                <span>{$correspDesc/tei:correspAction[@type='sent']/tei:date}</span>
            </div>
            <br/>
            <div>
                <b>Fonte: </b>
                <span>{$sourceDesc}</span>
            </div>
            <br/>
            {for $respStmt in $root/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt
                return <div><b>{$respStmt/tei:resp}: </b><span>{string-join($respStmt/tei:persName, ', ')}</span></div>
                (: return <p>{concat($resp/tei:resp, ': ', string-join($resp/tei:persName, ', '))}</p> :)
            }
            <br/>
            <div>Citare: </div>
            
        </div>
        
    
};



declare function app:alt-list($node as node(), $model as map(*)) {
    let $people := collection($config:auxiliary-root)//tei:person  (: this is defined in config.xqm :)
        return
            <table class="col-md-12 table">
                {for $person in $people
                    return <tr><td>
                                {$person/tei:persName/tei:surname/text() || ', ' || $person/tei:persName/tei:forename/text() || " (" || $person/tei:birth/@when  || "-" || $person/tei:death/@when ||")"}
                            </td></tr>
                }
            </table>
};

declare function app:list-places($node as node(), $model as map(*)) {
    let $places := collection($config:auxiliary-root)//tei:place  (: this is defined in config.xqm :)
        return
            <table class="col-md-12 table">
                {for $place in $places
                    return <tr><td>{concat($place/tei:placeName/text(), ', ', $place/tei:country/text())}</td></tr>
                }
            </table>
};



declare
    %templates:wrap
function app:list-people($node as node(), $model as map(*)) {
   let $people := collection($config:auxiliary-root)//tei:person
   return map:merge(($model, map {
                "people": $people
            }))
};

declare function app:person-count($node as node(), $model as map(*)) {
    count($model('people'))    (: this is the same as $model?people  :)
};

declare 
    %templates:wrap
function app:show-person($node as node(), $model as map(*)) {
    <a>
        {attribute href {$model?person/tei:idno}}
        {$model?person/tei:persName || "(" || $model?person/tei:birth  || " - " || $model?person/tei:death ||")"} 
    </a> (: person is made available in the model because of template:each   in list.html :)
};