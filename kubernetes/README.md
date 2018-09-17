# Desafio 02: Kubernetes
## Objetivo
Este projeto tem o objetivo criar uma aplicação em um cluster Kubernetes.

## Estrutura
```
/
- namespace.yaml
- deployment.yaml
- service.yaml 
- ingress.yaml
```

O arquivo namespace.yaml é a diretiva para a criacao de uma namespace separado para deploy da aplicacao. O namespace que é criado é devops-teste. 

O arquivo deployment.yaml e o arquivo com a principal diretiva para criacao do pod e do replica resource. Foi definido como health-check a url /healthz. A variavel NAME também está explicitada neste arquivo. Caso deseje mudar execute o comando abaixo:
```
kubectl set env deployments.apps/devops-app NAME=NOVO_NOME -n devops-teste
```

Os arquivos service.yaml e ingress.yaml criam os resource necessarios para a camada de network.

## Execucao
Os testes foram efetuados utilizando Minikube para a criacao de um cluster. Pos isso e necessario executar alguns passos antes do deploy da aplicacao:
``` 
eval $(minikube docker-env)
minikube addons enable ingress
```

Apos o export das variaveis do minikube e possivel criar a imagem do container:
```
docker build -t devops-app .
```

Com um unico comando especificando todos os arquivos para criacao dos resources criamos a aplicacao:
```
kubectl create -f namespace.yaml -f deployment.yaml -f service.yaml -f ingress.yaml
```

Para remocao da aplicacao e do namespace podemos utilizar o comando delete especificando os mesmos arquivos:
```
kubectl delete -f ingress.yaml -f service.yaml -f deployment.yaml -f namespace.yaml
```

Para fins de testes da imagem e possivel utilizar o comando run que executara a aplicacao
```
kubectl create namespace devops-teste
kubectl run devops-app --image=devops-app --image-pull-policy=Never --env NAME="Joao Batista" --expose=true --limits=cpu=100m,memory=256Mi --port=3000 -n devops-teste
```

#######################################################################################

READ-ME Original
#######################################################################################
## Motivação

Kubernetes atualmente é a principal ferramenta de orquestração e _deployment_ de _containers_ utilizado no mundo, práticamente tornando-se um padrão para abstração de recursos de infraestrutura. 

Na IDWall todos nossos serviços são containerizados e distribuídos em _clusters_ para cada ambiente, sendo assim é importante que as aplicações sejam adaptáveis para cada ambiente e haja controle via código dos recursos kubernetes através de seus manifestos. 

## Objetivo
Dentro deste repositório existe um subdiretório **app** e um **Dockerfile** que constrói essa imagem, seu objetivo é:

- Construir a imagem docker da aplicação
- Criar os manifestos de recursos kubernetes para rodar a aplicação (_deployments, services, ingresses, configmap_ e qualquer outro que você considere necessário)
- Criar um _script_ para a execução do _deploy_ em uma única execução.
- A aplicação deve ter seu _deploy_ realizado com uma única linha de comando em um cluster kubernetes **local**
- Todos os _pods_ devem estar rodando
- A aplicação deve responder à uma URL específica configurada no _ingress_


## Extras 
- Utilizar Helm [HELM](https://helm.sh)
- Divisão de recursos por _namespaces_
- Utilização de _health check_ na aplicação
- Fazer com que a aplicação exiba seu nome ao invés de **"Olá, candidato!"**

## Notas

* Pode se utilizar o [Minikube](https://github.com/kubernetes/minikube) ou [Docker for Mac/Windows](https://docs.docker.com/docker-for-mac/) para execução do desafio e realização de testes.

* A aplicação sobe por _default_ utilizando a porta **3000** e utiliza uma variável de ambiente **$NAME**

* Não é necessário realizar o _upload_ da imagem Docker para um registro público, você pode construir a imagem localmente e utilizá-la diretamente.
