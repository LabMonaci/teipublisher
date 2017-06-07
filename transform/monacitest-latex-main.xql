import module namespace m='http://www.tei-c.org/pm/models/monacitest/latex' at '/db/apps/labmonaci/transform/monacitest-latex.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "class": "article",
    "section-numbers": false(),
    "font-size": "12pt",
    "styles": ["../transform/monacitest.css"],
    "collection": "/db/apps/labmonaci/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)