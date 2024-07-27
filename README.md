<p align="left">
<img src="https://img.shields.io/badge/STATUS-EN%20DESAROLLO-green">
</p>

# Prueba Tecnica Flypass

Proyecto que crea un cluster EKS, con un deplopment el cual tiene un pod con 2 contenedores, uno tiene un script (/image1/script.sh), que obtiene la ip privada y lo guarda en un archivo (/root/output/timestamp), el siguiente contenedor obtiene este archivo mediante un volumen compartido enre contenedores y lo sube a un bucket s3, mediante un script (/Image2/scrpit.sh).

Toda la infraestructura esta lanzada con Terraform

eks.tf: Se encarga de lanzar el cluster a travez de un modulo, que extrae informacion de red de networking.tf
networking.tf: Genera la VPC y Subnets, que se necesita para el cluster
podidentity.tf: Genera los permisos necesarios para que el pod pueda obtener acceso al s3 sin necesidad de service account o credenciales
terraform.tfvars: Variables con los accesos a Amazon
varables.tf: Creacion de variables para su uso
main.tf: Inicio de terraform y creacion de bucket s3
/image1: Archivos necesarios para la creacion de la imagen Docker para el primer contenedor
/Image2: Archivos necesarios para la creacion de la imagen docker para el segundo contenedor
/Image1/crontab: Archivo cron, con el cual se especifica cada 2 minutos la ejecucion del script
/Image1/Dockerfile: Archivo con los pasos para generar la imagen
/Image1/script.sh: Archivo con los pasos necesarios para extraer la ip privada
/Image2/crontab: Archivo cron, con el cual se especifica cada 2 minutos la ejecucion del script
/Image2/Dockerfile: Archivo con los pasos para generar la imagen
/Image2/script.sh: Archivo con los pasos necesarios para extraer la ip privada

# Install
1. modificar terraform.tfvars, con las credenciales necesarias
2. Aplicar: terraform init
3. Aplicar: terraform validate (para la validacion de sintaxys o errores de los archivos tf)
4. Aplicar: terraform plan (para mirar que se va a instalar y el orden)
5. Aplicar: terraform apply -auto-aprove (aplica y genera la infraestructura autoconfirmandose)

NOTAS: 
1. las imagenes de los contenedores son publicas y estan subidas a repositorios ECR:
-´contenedor 1´: public.ecr.aws/p5a8f8s8/container1:latest
-´contenedor 2´: public.ecr.aws/p5a8f8s8/container2:latest
2. Toda la infraestructura se instala en la cuenta aws proporcionada por flypass, para su correcto funcionamiento es necesario permisos para la creacion de roles, politicas y asociaciones
