# [Code Samples](https://github.com/dabobert/code_sample) Readme

## Philosophy

I like writing simple code.  I don't think a person should need a PHD in computer science to understand my code.  However one should never confuse the simplicty of my (attempted) solution with the complexity of the problem I am trying to solve.  Where my code does become complex is in its layers of abstraction.  I try to abstract the problem enough so that the solution can be re-used  many many times over to solve "similiar" problems.

## Overview

This archives contains the relevant files for a feature allowing users to create custom pdf exports for their projects on DesignerPages.  Previously they were locked into a predfined set of templates that were implemented within ruby.  This features moves that funcationality from the repo into the database so that all users with a basic understanding of HTML can create and edit templates, not just the indviduals with a deep understanding of rails and with access to the repo.

This feature uses [liquid](https://shopify.github.io/liquid/) to allow iteration and control flow with the template.  I initially debated creating my own langauge but I immeidatly dismissed that idea.

This feature like all new features I create is made to be easily expanded.  For instance all names, variables, and designs are based on the idea that an export is to be created, NOT a PDF export.  The idea is that this code can be easily updated so that csv, doc, and xls files can be generated as well.  In fact as of this writing I'm in the process of expanding support for csv files.

To reach this next step a mime type column will be added to the export tables.   I'm adding it as a string column because the total number of rows will remain in the tens and hundreds and never in the thousands and millions.  The mime column is just metadata, it will never be used to sort or search by

### Quck Notes
`Export Templates` defines the design and layout of a template, how it looks what data it contains.

`Export Flow Templates` defines how the product data is iterated over.  The default export flow template simply iterates over all the products in a project.  This contrasts with a manufacturer flow which would iterate over all the manufacturers in a project, and then over every product for the manufacturer

`acts as bitfield` is included in our repo.  The version of the gem we were using is no longer maintained and not comaptaible with recent version of raile.  So we patched and put it in the folder and put it in our lib folder.

I'm debating putting [GrapeJS](http://grapesjs.com/demo.html) on trop of this, I'm just concerned that with all the transformations of code happening what the user sees may not actually be what they get.

## Other Samples
For a while I was working on the idea of creating a version of plex powered by s3 rather than a user's hardrive.  I called it eivu  The server portion is written in Rails, the client is written in Node. THIS IS MY FIRST TIME EVER WORKING WITH OR WRITING NODE

server - [https://github.com/dabobert/eivu-server](https://github.com/dabobert/eivu-server)

client - [https://github.com/dabobert/eivu-client](https://github.com/dabobert/eivu-client)