xquery version "3.1";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace tei="http://www.tei-c.org/ns/1.0";

import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";

declare option output:method "json";
declare option output:media-type "application/json";

array {
    for $place in collection($config:auxiliary-root)//tei:listPlace/tei:place
    let $coords := tokenize($place/tei:location/tei:geo, "\s*,\s*")
    return
        map {
            "id": $place/@xml:id/string(),
            "name": $place/tei:placeName/string(),
            "geo": map {
                "lat": number($coords[1]),
                "lng": number($coords[2])
            }
        }
}
