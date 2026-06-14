### PPGEC-abnTeX2

A ricing of [abnTeX2](http://www.abntex.net.br/) for masters dissertations leveraging the PPGEC/UPE template.

#### Changelog and Features

Renamed files:
- ppgec-abntex2-modelo.tex -> main.tex
- ppgec-abntex2.cls -> stays the smae


For PL Research:
- category theory newcommand definitions
- type theory newcommand definitions

For picture handling, inkscape

#### Dependencies

To use the tooling of this repository, you will need to:
- 1: install texlive,
- 2: install the package abntex2,
- 3: have GNU Make on the system,
- 4: have inkscape on the system.

More on abntex2 usage, in pt-br, on "[Guia para instalação do LaTeX e abnTeX2](https://github.com/abntex/abntex2/wiki/Instalacao)".

This is a previous [example of a document, a PDF file](https://github.com/victormelo/ppgec-abntex2/blob/master/ppgec-abntex2-modelo.pdf), generated with this template setup, by victormelo.

#### Usage

make pdf will create the whole project. There are some options:
- build via pandoc
- build via haskell, using pandoc library.
- build via xelatex
- build via luatex

An HTML version is available, which is useful for reports.

The styles will work with either PDF or HTML.

#### LaTeX Glossary

A quick glossary regarding LaTeX files:
- cls: class filenames
- sty: package filenames
- bst: bibtex style filenames

#### Regarding PL Research

PL Research gets tricky when having to represent logic,
rules of inference, type theory and category theory.
This template attemps to solve this issue in order to break the wall between:
- 1. interested enthusiasts; and
- 2. a document artifact generation, which includes the research itself.



