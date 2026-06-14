###  danctfceppg

absurd notes custom template for engenharia da computação ppg.

This is a rice leveraging victormelo's work on [PPGEC-abnTeX2](https://github.com/victormelo/ppgec-abntex2) PPGEC/UPE template, based on the default [abnTeX2](http://www.abntex.net.br/) for masters dissertations.

#### 1. Changelog and Features

Renamed files:
- ppgec-abntex2-modelo.tex -> main.tex
- ppgec-abntex2.cls -> stays the smae


For PL Research:
- category theory newcommand definitions
- type theory newcommand definitions

For picture handling, inkscape

#### 2. Dependencies

To use the tooling of this repository, you will need to:
- 1: install texlive,
- 2: install the package abntex2,
- 3: have GNU Make on the system,
- 4: have inkscape on the system.

More on abntex2 usage, in pt-br, on "[Guia para instalação do LaTeX e abnTeX2](https://github.com/abntex/abntex2/wiki/Instalacao)".

This is a previous [example of a document, a PDF file](https://github.com/victormelo/ppgec-abntex2/blob/master/ppgec-abntex2-modelo.pdf), generated with this template setup, by victormelo.

#### 3. Usage

At the root of the repository:
- 1: run ```m̀ake pdf``` to compile the project.
- 2: run ```make clean``` to clean intermediate files from the compilation.

#### 4. LaTeX Glossary

A quick glossary regarding LaTeX files:
- cls: class filenames
- sty: package filenames
- bst: bibtex style filenames


#### 5. Regarding PL Research

PL Research gets tricky when having to represent logic,
rules of inference, type theory and category theory.
This template attemps to solve this issue in order to break the wall between:
- 1: interested enthusiasts; and
- 2: a document artifact generation, which includes the research itself.


#### 6. todo

Current options for compiling to pdf:
- [X] build via xelatex
- [ ] build via pandoc
- [ ] build via haskell, using pandoc library.
- [ ] build via luatex

Other todo:
- [ ] HTML version is available, which is useful for reports.
- [ ] The styles will work with either PDF or HTML.


#### 7. Contributor's guide

Interested contributors can just fork and custom as they like,
but if you want to contribute to this repository in specific,
just explain exactly why do you think said feature is relevant
to the context here presented. I'll try to review ASAP.


The main themes are overall typesetting. Which includes
- compiling modularized code to pdf,
- other ways of organizing proofs
- type theory tricks
- category theory tricks
- an underground programming language being used.

The code may be put inside a folder with the port name under ```./deploy/```.
Add a Dockerfile and that's it.

From here on the steps are:
- 1: fork the repository
- 2: pull the repository forked in your profile to your editing environment/machine
- 3: create a new branch
- 4: customize as you like, then you can add your name to the license and your caveats.
- 5: commit the changes,
- 6: push to your repo.
- 7: now you can either:
  - 7.1: open a pull request on the main branch of
  your own repository, if it has a webring around or something like that.
  - 7.2: open a pull request on the repository you forked that project from (this one).

PS: ASAP here means I have no idea when I will even see the PR. You will miss 100% shots you don't take though.


