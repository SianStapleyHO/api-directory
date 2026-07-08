# api-directory

A central location to publish project API documentation

### Introduction
This service is built using two container types:

#### dapperdox
This is a golang application that displays multiple OpenAPI specs and markdown. https://github.com/UKHomeOffice/cto-docker-dapperdox

#### git-sync
This is a service that syncs git repos to a local volume. https://github.com/UKHomeOffice/docker-git-sync

### Overview

Together they provide a service to display specs from multiple project repositories.

The 'kubes/deployment.yaml' file describes whats going on best.
In short :

- Mount a number of shared volumes
- git-sync per project syncs to a volume
- dapperdox has a number of volume mappings, one per project

 
 > The dapperdox project has a shell script that re-maps the volumes to what dapperdox expects.