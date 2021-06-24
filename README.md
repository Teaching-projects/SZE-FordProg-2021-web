# SZE-FordProg-2021-web

Checking basic html syntax, only recognizes a few given html elements and attributes.

Stopping program: "exit" command

Known issue: self closing tags are only accepted with a space before self closing slash if there are any attributes given.

Eg.:
    `<br/>` , 
    `<br />` and
    `<a class="my-class" />` are okay, but
    <del>`<a class="my-class"/>`</del>
    cause error.