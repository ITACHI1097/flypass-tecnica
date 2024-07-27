<p align="left">
<img src="https://img.shields.io/badge/STATUS-EN%20DESAROLLO-green">
</p>

# Prueba Técnica Flypass

Nota: todo el código se encuentra en la rama feature

Proyecto que crea un clúster EKS, con un development el cual tiene un pod con 2 contenedores, uno tiene un script (/image1/script.sh), que obtiene la ip privada y lo guarda en un archivo (/root/output/timestamp), el siguiente contenedor obtiene este archivo mediante un volumen compartido entre contenedores y lo sube a un bucket s3, mediante un script (/Image2/scrpit.sh).

Toda la infraestructura esta lanzada con Terraform

- `eks.tf`: Se encarga de lanzar el clúster a través de un módulo, que extrae información de red de networking.tf
- `networking.tf`: Genera la VPC y Subnets, que se necesita para el clúster
- `podidentity.tf`: Genera los permisos necesarios para que el pod pueda obtener acceso al s3 sin necesidad de service account o credenciales
- `terraform.tfvars`: Variables con los accesos a Amazon
- `varables.tf`: Creación de variables para su uso
- `main.tf`: Inicio de terraform y creación de bucket s3
- `/image1`: Archivos necesarios para la creación de la imagen Docker para el primer contenedor.
- `/Image2`: Archivos necesarios para la creación de la imagen docker para el segundo contenedor.
- `/Image1/crontab`: Archivo cron, con el cual se especifica cada 2 minutos la ejecución del script.
- `/Image1/Dockerfile`: Archivo con los pasos para generar la imagen
- `/Image1/script.sh`: Archivo con los pasos necesarios para extraer la ip privada
- `/Image2/crontab`: Archivo cron, con el cual se especifica cada 2 minutos la ejecución del script
- `/Image2/Dockerfile`: Archivo con los pasos para generar la imagen
- `/Image2/script.sh`: Archivo con los pasos necesarios para extraer la ip privada

# Install
1. modificar terraform.tfvars, con las credenciales necesarias
2. Aplicar: terraform init
3. Aplicar: terraform validate (para la validación de sintaxis o errores de los archivos tf)
4. Aplicar: terraform plan (para mirar que se va a instalar y el orden)
5. Aplicar: terraform apply -auto-aprove (aplica y genera la infraestructura autoafirmándose)

NOTAS: 
1. las imágenes de los contenedores son públicas y están subidas a repositorios ECR:
- `contenedor 1`: public.ecr.aws/p5a8f8s8/container1:latest
- `contenedor 2`: public.ecr.aws/p5a8f8s8/container2:latest
relacionada con la funcionalidad 2- `Funcionalidad 3`: descripción de la funcionalidad 3
2. Toda la infraestructura se instala en la cuenta aws proporcionada por flypass, para su correcto funcionamiento es necesario, permisos para la creación de roles, políticas y asociaciones
