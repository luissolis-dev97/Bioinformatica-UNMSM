#!/bin/bash
# Actualizar e instalar herramientas
sudo apt-get update
sudo apt-get install -y sra-toolkit fastqc multiqc samtools bcftools bwa

# Configurar SRA Toolkit para que no pregunte nada y guarde en el repositorio
mkdir -p $HOME/.ncbi
echo '/repository/user/main/public/root = "./data"' > $HOME/.ncbi/user-settings.mkfg
