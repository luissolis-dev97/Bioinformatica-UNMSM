#!/bin/bash
# 1. Actualizar repositorios
sudo apt-get update

# 2. Instalar herramientas base
sudo apt-get install -y fastqc multiqc samtools bcftools bwa curl

# 3. Descargar e instalar SRA Toolkit manualmente (más seguro)
mkdir -p /tmp/sratoolkit
cd /tmp/sratoolkit
curl -O https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
tar -vxzf sratoolkit.current-ubuntu64.tar.gz
# Mover binarios a una carpeta en el PATH
sudo cp /tmp/sratoolkit/sratoolkit.*-ubuntu64/bin/* /usr/local/bin/

# 4. Configuración rápida
mkdir -p $HOME/.ncbi
echo '/repository/user/main/public/root = "./data"' > $HOME/.ncbi/user-settings.mkfg

echo "¡Instalación completada!"
