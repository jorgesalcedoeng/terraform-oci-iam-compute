# 🚀 OCI IAM + Compute + Object Storage (Terraform)

## 📌 Descripción

Este proyecto implementa una arquitectura en **Oracle Cloud Infrastructure (OCI)** utilizando **Terraform**, cuyo objetivo es demostrar el uso de:

* **Instance Principals**
* **Dynamic Groups**
* **Policies IAM**
* **Object Storage (Bucket)**

El resultado es una **máquina virtual (VM)** que puede interactuar con un bucket de OCI **sin credenciales**, únicamente mediante permisos IAM.

---

## 🏗️ Arquitectura

```
Compute Instance (VM)
        ↓
Instance Principal
        ↓
Dynamic Group
        ↓
IAM Policy
        ↓
Object Storage Bucket
```

---

## 📂 Estructura del proyecto

| Ruta               | Descripción                        |
| ------------------ | ---------------------------------- |
| `modules/network`  | VCN, Subnet, Internet Gateway, NSG |
| `modules/compute`  | VM + cloud-init (user_data.yaml)   |
| `modules/storage`  | Bucket de Object Storage           |
| `modules/iam`      | Dynamic Groups + Policies          |
| `main.tf`          | Orquestación de módulos            |
| `variables.tf`     | Variables del proyecto             |
| `terraform.tfvars` | Valores de variables               |
| `outputs.tf`       | Outputs                            |

---

## ⚙️ Requisitos

* Terraform >= 1.0
* OCI CLI configurado (solo para deploy local)
* Cuenta en OCI
* Clave SSH

---

## 🚀 Despliegue

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

---

## 🌐 Acceso a la VM

```bash
ssh ubuntu@<IP_PUBLICA>
```

---

## 🧪 Validación de la política IAM

### ✅ 1. Validar instalación de OCI CLI

```bash
oci --version
```

---

### ✅ 2. Validar Instance Principal

```bash
oci os ns get --auth instance_principal
```

📌 Resultado esperado:

* Retorna el **namespace** de Object Storage

---

### ✅ 3. Validar acceso al bucket

```bash
oci os bucket list --auth instance_principal --compartment-id <COMPARTMENT_ID>
```

📌 Resultado esperado:

* Lista de buckets disponibles

---

### ✅ 4. Prueba real (lectura/escritura)

Crear archivo:

```bash
echo "test" > test.txt
```

Subir archivo:

```bash
oci os object put \
  --bucket-name <BUCKET_NAME> \
  --file test.txt \
  --auth instance_principal
```

Listar objetos:

```bash
oci os object list \
  --bucket-name <BUCKET_NAME> \
  --auth instance_principal
```

📌 Resultado esperado:

* El archivo `test.txt` aparece en el bucket

---

## 🌍 Validación Web

Abrir en navegador:

```
http://<IP_PUBLICA>
```

📌 Resultado esperado:

* Página Nginx mostrando:

  * Host
  * IP
  * Estado OCI CLI
  * Estado Instance Principal

---

## 🔐 Seguridad

Este proyecto sigue buenas prácticas:

* ❌ No uso de API Keys
* ✅ Uso de Instance Principal
* ✅ Políticas controladas por IAM
* ✅ Separación por módulos

---

## ⚠️ Problemas comunes

| Problema                  | Causa                | Solución           |
| ------------------------- | -------------------- | ------------------ |
| `oci: command not found`  | OCI CLI no instalado | Revisar cloud-init |
| `NotAuthorizedOrNotFound` | Policy incorrecta    | Revisar IAM        |
| Timeout                   | Red mal configurada  | Revisar subnet/IG  |

---

## 🧠 Conceptos clave

| Concepto           | Descripción                     |
| ------------------ | ------------------------------- |
| Instance Principal | Identidad de la VM en OCI       |
| Dynamic Group      | Grupo dinámico basado en reglas |
| Policy             | Permisos sobre recursos         |
| Object Storage     | Servicio de almacenamiento      |

---

## 🧹 Limpieza

```bash
terraform destroy -auto-approve
```

---

## 👨‍💻 Autor

Proyecto orientado a demostrar conocimientos avanzados en:

* Terraform
* OCI IAM
* Seguridad en la nube
* Automatización

---

## ⭐ Notas finales

Este proyecto está diseñado como:

* 🧪 Laboratorio práctico
* 💼 Demo para entrevistas
* 📚 Base para proyectos reales

---

🚀 **Listo para producción y demostraciones profesionales**
