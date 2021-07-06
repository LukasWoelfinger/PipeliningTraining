# Infrastructure as code with Terraform

The examples are showing a simple infrastructure for Azure using the following components

- service plan
- web application service
- SQL Server as PaaS

_All files are written for local execution, but prepared to execute against a storage backend (e.g. in pipelines), too._

| Folder            | Description                                                                                                                             |
| ----------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| 01_singlefile     | all Terraform code within one single file                                                                                               |
| 02_separatedAreas | Same infrastructure as created in 01, but separated into files for code (main), variables and outputs                                   |
| 03_modularized    | Same infrastructure as created in 01, but the areas web and data are separated into small modules. The modules are file separated as 02 |
