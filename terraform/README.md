# Desafio 01: Infrastructure-as-code - Terraform
## Objetivo
Este projeto tem o objetivo criar uma instancia na AWS utilizando terraform como gerenciador de configuracao.

## Estrutura
```
/
 - access_key.tf
 - apache-instance.tf
 - backend.tf
 - modules/
    - instances/
        - main.tf
        - outputs.tf
        - variables.tf
 - networks.tf
 - provider.tf
 - README.md
 - terraform.plan
 - variables/
    - production.tfvars
    - stage.tfvars 
 - vars.tf
```
 
Para acesso a instancia criada foi configurada uma chave. A chave privada correspondente e:
```
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn
NhAAAAAwEAAQAAAQEAtHuBWdNM8HPM56+GpfIQZSoWUdA5co+HNqGQUIkcepfZd0fGUoZC
qnknqgjlBTDhJjMFjdFu8myvlVPY4V/M2TEgbxXbmaZgy0RmlPkiuzfBgl8+0tSpHK/9oJ
sjNoUWw+KK78CzdeP7r2c3FnFZI3ouhnCWL20fTYpIUw47akYNNTr7zwVIWTvwtVkJDpNd
U87g3ObeDb6FjG/gBj+7v3B5Wk2lgiSxy8SCp1q4J9D9WMGeSybD1kK046iK0lKr4mL7wB
zyZYdXd92We/6PeuGd+8e6PLzLXkkAk+YQwac6xLParJcrfIdmWGlMG08vWmstSUDtPFAO
GNcvpc3OCQAAA8iJifgHiYn4BwAAAAdzc2gtcnNhAAABAQC0e4FZ00zwc8znr4al8hBlKh
ZR0Dlyj4c2oZBQiRx6l9l3R8ZShkKqeSeqCOUFMOEmMwWN0W7ybK+VU9jhX8zZMSBvFduZ
pmDLRGaU+SK7N8GCXz7S1Kkcr/2gmyM2hRbD4orvwLN14/uvZzcWcVkjei6GcJYvbR9Nik
hTDjtqRg01OvvPBUhZO/C1WQkOk11TzuDc5t4NvoWMb+AGP7u/cHlaTaWCJLHLxIKnWrgn
0P1YwZ5LJsPWQrTjqIrSUqviYvvAHPJlh1d33ZZ7/o964Z37x7o8vMteSQCT5hDBpzrEs9
qslyt8h2ZYaUwbTy9aay1JQO08UA4Y1y+lzc4JAAAAAwEAAQAAAQAqq/TGTx4mz8pHkQmN
3LChqpTCXS/n9SVr9kEPuYtBNPvWpuKuCk5izehh3F6Bnq/s/y01/al0qdvNu5hQmPzu8R
2RBiL4rgy+onp6iHj8uM8IywoogN1HChk2StfFgSwDvmFJFE+Z9QBB1W6B4OTJbY7ofGAV
8H/xLluxP3Euy+GHEskgyMjIj1VypOnBgJ/KFHWI9d6x6bXwiTohJBs/KMaCAISMcMuN7h
PW5AMzQeuAbtZIY+QWLPxCUKfR8Y67P/eaW1FJVqYAzXwyuCrZY71xCBTlXQv+XFyzGNfU
weQ+03F3H+rbLDTX6taAXWN/b4TcEapIpk8s1obuKoOxAAAAgQCMIh/wluAgBbSZg2umCn
M/eYwFJxKQY6DnUJXd6gZ1tWZRjE2Igf6fjnmZXk4/Zi0GsYYo9Jv8r3hkRnQSv0owOaJb
ICT7kvI2d66xwQe5yFaPvJegY/s3Z9T7Fh4FUDS+3uAV9fyyAyZk0duSpNEIP+Dfm5DiR9
js6D2KcqlR1QAAAIEA3wtrhdxinpU9aJFLfalrc+EoIbeTANpF1nBV9IojSJ7ItpfyqWEz
ruDSp5aazS09/oegApG4XQzJh/px4DeEE9zkVrbDNIh+Fw8ZP9IQBa+uXeqoS4u7ERwjH+
/QXGaoEvAJxZqYX7d8HcGo7crHldgQVWHV1LwRguu43KJXhNUAAACBAM8mL+BrT0DhtuUG
W55J8FQyqN4mT+vPQxdByLB7CIjysTdv+p9k+JyBelOn9N4e4unlGaIU0zleUGBz9lAoBr
TBZfKQ/jf6rTzqb5EhPmTCjLu3ng3V1YKfuDk86nPYg8oxFy9poqO8mb9xNBPqQ4AeXeDh
xp5m9OkQtNroV85lAAAAEmpvbGl2ZWlyYUBsYXB0b3BqYg==
-----END OPENSSH PRIVATE KEY-----
```
**Obs: APENAS POR FINS DE TESTES ESTOU COLOCANDO A PRIVATE KEY EM UM REPOSITORIO. ESTA CHAVE FOI CRIADA APENAS PARA O ACESSO AS INSTANCIAS DE TESTES.**

Para utilizacao do modulo foi escolhido o resource da instância. As variaveis sao passadas pelo arquivo apache-instance.tf.

O backend do terraform foi configurado no S3. A criacao do bucket pode ser feita pelo console ou pelo aws-cli:
```
aws s3api create-bucket --bucket terraform.devops-testes.idwall --region us-east-1
```
O diretorio variables e apenas para exemplificacao de separacao de variaveis exclusivas de ambientes.

Abaixo o script enviado para a instancia que transformado em base64:
```
#!/bin/bash

yum install -y docker

chkconfig --add docker

service docker start 

docker run -d -p 80:80 --restart always httpd
```

## Execucao

Se quiser alterar o nome do bucket e/ou a chave de acesso a instancia por favor altere nos correspondetes arquivos antes de iniciar o deploy do ambiente.

### Download do terraform 
* Este procedimento tem como base a instalacao em um ambiente com Sistema Operacional Linux. Caso utilize outro, por favor acesse a pagina de [download](https://www.terraform.io/downloads.html)
```
curl https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip 
unzip terraform_0.11.8_linux_amd64.zip
chmod +x terraform
sudo mv terraform /usr/local/bin
```

### Clone do repositorio
```
git clone https://github.com/jbaojunior/desafios-devops
```

### Execucao do Terraform
```
cd desafios-devops/terraform
terraform init
terraform plan -var-file=variables/production.tfvars -refresh=true -parallelism 3 -out terraform.plan
terraform apply terraform.plan
```

No final da execucao uma mensagem com o endereco publico para acesso ao apache sera exibido.

## Remocao

Para remocao dos recursos criados sera necessario executar o plan com o parâmetro "-destroy"
```
terraform plan -var-file=variables/production.tfvars -refresh=true -parallelism 3 -out terraform.plan -destroy
terraform apply terraform.plan
```
A remoção do bucket pode ser efetuada atraves do console ou via aws-cli
```
aws s3 --recursive rm  s3://terraform.devops-testes.idwall
aws s3api delete-bucket --bucket terraform.devops-testes.idwall --region us-east-1
```

########################################################################
READ ME ORIGINAL
########################################################################
# Desafio 01: Infrastructure-as-code - Terraform

## Motivação

Recursos de infraestrutura em nubvem devem sempre ser criados utilizando gerenciadores de configuração, tais como [Cloudformation](https://aws.amazon.com/cloudformation/), [Terraform](https://www.terraform.io/) ou [Ansible](https://www.ansible.com/), garantindo que todo recurso possa ser versionado e recriado de forma facilitada.

## Objetivo

- Criar uma instância **n1-standard-1** (GCP) ou **t2.micro** (AWS) Linux utilizando **Terraform**.
- A instância deve ter aberta somente às portas **80** e **443** para todos os endereços
- A porta SSH (**22**) deve estar acessível somente para um _range_ IP definido.
- **Inputs:** A execução do projeto deve aceitar dois parâmetros:
  - O IP ou _range_ necessário para a liberação da porta SSH
  - A região da _cloud_ em que será provisionada a instância
- **Outputs:** A execução deve imprimir o IP público da instância


## Extras

- Pré-instalar o docker na instância que suba automáticamente a imagem do [Apache](https://hub.docker.com/_/httpd/), tornando a página padrão da ferramenta visualizável ao acessar o IP público da instância
- Utilização de módulos do Terraform

## Notas
- Pode se utilizar tanto AWS quanto GCP (Google Cloud), não é preciso executar o teste em ambas, somente uma.
- Todos os recursos devem ser criados utilizando os créditos gratuitos da AWS/GCP.
- Não esquecer de destruir os recursos após criação e testes do desafio para não haver cobranças ou esgotamento dos créditos.
