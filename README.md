DEVOPS CHALLANGE

Implantação de dois containers Docker, executando uma aplicação "hello world" utilizando o NGINX como Load Balancer em AWS. Utilizaremos o Ansible como ferramenta de configuração e Terraform prover infraestrutura.

Primeiro Passo:

Instalar o Terraform ( downlaod https://www.terraform.io/downloads.html) ;

Configurar o Terraform ;

Crie 3 instâncias EC2 utilizando o Terraform ;

Instalar Ansible em um dos hosts;

Instalar o ansible install docker e demais requisitos nos 3 hosts;

Implante o serviço https://hub.docker.com/r/amd64/hello-world/ em HA utilizando Ansible ;

Loadbalancer : AWS EC2 -> nginx-host ;

Aplicação : AWS EC2 -> hello_world_host e AWS EC2 -> hello_world_host ;

Requisitos:

Criar "AWS Access Key ID & AWS Secret Access Key" , essas chaves serão usadas pelo terraform para criar e excluir instâncias da AWS;

Criar um par de chaves ssh que será usado para fazer ssh nas instâncias, baixar arquivo key.pem e usá-lo durante a execução Ansible;

O ssh-keyscan é necessário para as 3 máquinas para evitar a verificação de hosts conhecidos durante a execução Aansible;

Iniciando:

Instalando o Terraform:

Downlaod configuração necessária a partir de https://www.terraform.io/downloads.html;

Instalador disponível no repositório no GIT terraform_0.12.17_linux_amd64;

Instalando Unzip e descompactando o terraform:
[sudo yum install unzip -y unzip unzip terraform_0.12.17_linux_amd64.zip sudo ln -s /home/ec2-user/terraform /usr/bin/terraform]

Utilizei o script/template ec2.tf para criar as instâncias AWS EC2 usando o comando abaixo https://www.terraform.io/intro/getting-started/build.html

Comandos a serem digitados a partir do diretório Scripts :

cd Scripts; terraform plan; terraform apply; terraform show;

terraform show exibirá os IPs dos instâncias criadas. Com o public_ip de cada saída e atualize em todos os arquivos de hosts conforme necessário;

Instalar ansible usando o script InstallAnsible.sh em qualquer host , digamos no nginx-host

*./InstallAnsible.sh *

Instale o requisito relacionado ao Docker usando o comando abaixo da máquina (nginx-host) onde o ansible é instalado:

ansible-playbook InstallPy.yml -i Hosts -vvvv

Instalar o Docker usando o comando abaixo da máquina (nginx-host) onde o ansible está instalado (Pode ser necessário executar o script Docker_Repo_Pre_Req.sh caso o docker não esteja presente no repositório padrão em máquinas host alvo);

ansible-playbook InstallDockerPlay.yml -i Hosts -vvvv

Instalar/deploy das 2 aplicações'Hello'World'' usando a imagem disponível no Docker Hub (nginx-host) onde o Ansible é instalado:

ansible-playbook DockerHelloWorld1.yml -i Hosthelloworld_1.ini -vvvv

ansible-playbook DockerHelloWorld2.yml -i Hosthelloworld_2.ini -vvvv

Instalar/deploy da imagem Docker do NGINX (Load Balance) utilizando o comando abaixo da máquina (nginx-host) onde o ansible está instalado:

ansible-playbook DockerNginx.yml -i Host_Nginx.ini -vvvv

Agora o SSH para todas as 3 containers usando o comando abaixo (Verifica se estão em execução):

*ssh -i key.pem ec2-user@host_ip" *sudo docker ps -a"

Verificar se o Servidor Nginx está em execução, utilizando o IP público do Host:

http://nginx_hostIp/

Agora acesse o Container do NGINX e modifique o arquivo /etc/nginx/conf.d/default.conf. Este servidor aceita todo o tráfego para a porta 80 e faz o upstream para o Backend. Note que o nome do upstream e o proxy_pass precisam ser idênticos. Apenas atualize os IPs do host no ginx.conf

sudo docker ps -a

sudo docker exec -it <nginx_container_id> bash

*echo "upstream servers { server ${Hosthelloworld_1}:8080; server ${Hosthelloworld_2}:8081; }
server { listen 80; location / { proxy_pass http://servers; } }” > /etc/nginx/conf.d/default.conf *

Agora atualize o navegador para ser direcionado a cada Backend

http://{nginx_hostIp}}}/
