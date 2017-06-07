import module namespace m='http://www.tei-c.org/pm/models/monacitest/web' at '/db/apps/labmonaci/transform/monacitest-web.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["../transform/monacitest.css"],
    "collection": "/db/apps/labmonaci/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)