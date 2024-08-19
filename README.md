# Fiscal Flow - Processo Seletivo Mainô

O Fiscal Flow é uma aplicação desenvolvida para processar arquivos XML de documentos fiscais eletrônicos (como notas fiscais) e gerar relatórios detalhados com base nas informações contidas nos arquivos. O projeto também suporta upload de arquivos ZIP contendo múltiplos XMLs, permitindo o processamento em lote. Além disso, o sistema possui autenticação de usuários, processamento em background com Sidekiq, e funcionalidades avançadas como exportação de relatórios em Excel. E testes utilizando o Rspec

## 🚀 Começando

Essas instruções permitirão que você obtenha uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste.


### 🔧 Instalação

Comandos para configuração inicial
'bundle install'
'rails s' 
'sidekiq -C config/sidekiq.yml' 

## ⚙️ Executando os testes

Para rodar o rspec, basta rodar o comando

'bundle exec rspec spec/' e o arquivo desejado

Neste projeto temos a inclusão do Coverage sendo assim após rodar os teste, basta abrir o arquivo 'index.html' que fica na pasta 'Coverage' para ver a cobertura atual de testes do projeto.


