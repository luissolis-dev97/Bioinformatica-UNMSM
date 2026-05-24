#!/bin/bash
# 1. Actualizar repositorios e instalar herramientas base
sudo apt-get update
sudo apt-get install -y fastqc multiqc samtools bcftools bwa curl

# 2. Instalación y configuración de SRA Toolkit
echo "Instalando SRA Toolkit..."
mkdir -p /tmp/sratoolkit
cd /tmp/sratoolkit
curl -O https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
tar -vxzf sratoolkit.current-ubuntu64.tar.gz
# Copiar binarios al sistema
sudo cp -r /tmp/sratoolkit/sratoolkit.*-ubuntu64/bin/* /usr/local/bin/

# Configurar SRA Toolkit para uso no interactivo (Evita que se quede trabado)
mkdir -p $HOME/.ncbi
vdb-config --restore-defaults
echo '/repository/user/main/public/root = "./data"' > $HOME/.ncbi/user-settings.mkfg

# 3. Descarga de datos para la clase
echo "Descargando datos de la clase..."
mkdir -p ./data

# Descargar archivo SRA
prefetch SRR30867920 --output-directory ./data

# Convertir SRA a FASTQ
# Nota: prefetch guarda en una carpeta con el mismo nombre
fasterq-dump ./data/SRR30867920/SRR30867920.sra --outdir ./data --split-files

# Descargar y preparar genoma de referencia
echo "Descargando genoma de referencia..."
curl -L "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/240/185/GCF_000240185.1_ASM24018v2/GCF_000240185.1_ASM24018v2_genomic.fna.gz" -o ./data/referencia.fna.gz
gunzip -f ./data/referencia.fna.gz

echo "¡Entorno y datos listos para trabajar!"
