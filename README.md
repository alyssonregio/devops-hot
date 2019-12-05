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

Prerequistes para este projecto :

Se você não tiver uma conta da AWS válida, então você pode criar uma conta de nível gratuito, inscrevendo-se em https://aws.amazon.com/

certifique-se de criar "AWS Access Key ID & AWS Secret Access Key" , essas chaves serão usadas pelo terraform para criar e excluir instâncias da AWS

criar um par de chaves ssh que será usado para fazer ssh para nós ec2 , baixar arquivo key.pem e usá-lo durante a execução ansible

ssh-keyscan pode ser necessário para 3 máquinas de host ansible para evitar a verificação de hosts conhecidos durante a execução ansible

Passos para começar:

Instalando o Terraform:

Downlaod configuração necessária a partir de https://www.terraform.io/downloads.html

Instalador do Linux que eu carreguei no repo e também no terraform_0.9.8.8_linux_amd64.zip

sudo yum install unzip -y unzip unzip terraform_0.9.8.8_linux_amd64.zip sudo ln -s /home/ec2-user/terraform /usr/bin/terraform

o comando de tipo "terraform" para validar o terraform foi instalado e está no caminho

Uma vez instalado o terraform, estamos prontos para começar.

Use script/template aws_ec2_creation_template.tf para criar o nó aws ec2 usando o comando abaixo https://www.terraform.io/intro/getting-started/build.html

Comandos a serem digitados a partir do diretório Scripts :

cd Scripts; plano de terraformas; aplicar terraformes; mostrar terraformes;

terraform show lhe dará os IPs requeridos de hosts ec2 criados, pegue public_ip de cada saída e atualize em todos os arquivos de hosts conforme necessário

Instalar ansible usando o script InstallAnsible.sh em qualquer host , digamos no nginx-host

*./InstallAnsible.sh *

Instale o prereq relacionado ao Docker usando o comando abaixo da máquina (nginx-host) onde o ansible é instalado

ansible-playbook InstallPy.yml -i Hosts -vvvv

Instalar o Docker usando o comando abaixo da máquina (nginx-host) onde o ansible está instalado (Docker_Repo_Pre_Req.sh pode precisar ser excutado caso o docker não esteja presente no repositório padrão em máquinas ost alvo)

ansible-playbook InstallDockerPlay.yml -i Hosts -vvvv

Instalar/implementar 2 aplicações do mundo do olá usando a imagem da janela de encaixe tutum usando o comando abaixo da máquina (nginx-host) onde o ansible é instalado

ansible-playbook PullDockerHello.yml -i Host_helloworld_1.ini -vvvv

ansible-playbook PullDockerHello2.yml -i Host_helloworld_2.ini -vvvv

Instale/implante a imagem da janela de encaixe do nginx Lb usando o comando abaixo da máquina (nginx-host) onde o ansible está instalado

ansible-playbook PullDockerNginx.yml -i Host_Nginx.ini -vvvv

Agora o ssh para todas as 3 máquinas docker usando o comando abaixo e verifique se os containers estão funcionando

*ssh -i key.pem ec2-user@host_ip" *sudo docker ps -a"

verificar se o servidor nginx está acima, o navegador web aberto diz cromo e entra no ip público do anfitrião (certifique-se de que as regras de entrada no grupo de segurança do aws estão bem para http para o nginx webui para abrir)

http://{nginx_hostIp}}}/

Agora acesse o container do docker nginx e modifique o arquivo /etc/nginx/conf.d/default.conf Este servidor aceita todo o tráfego para a porta 80 e o passa para o upstream. Note que o nome do upstream e o proxy_pass precisam corresponder. file deve se parecer com o presente na pasta de scripts nginx.cong , apenas atualize os IPs do host

sudo docker ps -a

sudo docker exec -it <nginx_container_id> bash

*echo "upstream servers { server ${hello-world-app1-ip}:8080; server ${hello-world-app2-ip}:8081; }
server { listen 80; location / { proxy_pass http://servers; } }” > /etc/nginx/conf.d/default.conf *

Agora atualize o webui no navegador cromado e você deve ver o id do recipiente do diff para cada atualização como mostrado nas imagens anexas

http://{nginx_hostIp}}}/

Assim, implementamos HA usando docker ansible e nginx como LB , aproveite :)
