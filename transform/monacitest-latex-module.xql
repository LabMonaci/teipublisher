module namespace pml='http://www.tei-c.org/pm/models/monacitest/latex/module';

import module namespace m='http://www.tei-c.org/pm/models/monacitest/latex' at '/db/apps/labmonaci/transform/monacitest-latex.xql';

(: Generated library module to be directly imported into code which
 : needs to transform TEI nodes using the ODD this module is based on.
 :)
declare function pml:transform($xml as node()*, $parameters as map(*)?) {

   let $options := map {
    "class": "article",
    "section-numbers": false(),
    "font-size": "12pt",
       "styles": ["../transform/monacitest.css"],
       "collection": "/db/apps/labmonaci/transform",
       "parameters": if (exists($parameters)) then $parameters else map {}
   }
   return m:transform($options, $xml)
};