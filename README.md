# 📱 Análise do Projeto Flutter

Este projeto foi desenvolvido para o Desafio Técnico da Cronos. 
Meu objetivo foi criar uma solução que não apenas funcione bem no momento atual, mas que também seja escalável e mantenha-se alinhada com as tecnologias utilizadas pela empresa.

## 🛠️ Detalhes do Projeto

### 💡 Gerenciamento de Estado
Optei por utilizar o **Bloc** para o gerenciamento de estado, pois essa abordagem está mais alinhada com a stack tecnológica da empresa e oferece boa organização e testabilidade caso venha a ser implementada.

### 🗂️ Armazenamento de Dados
Escolhi o **Hive** como banco de dados local por ser uma solução leve, rápida e adequada para aplicações que possam demandar alto volume de dados no futuro.

### 🧩 Injeção de Dependências
Implementei a injeção de dependência utilizando os widgets **MultiRepositoryProvider** e **BlocProvider**, para garantir uma estrutura modular e reutilizável.


Seguindo o padrão de **Clean Architecture** apresentado pela empresa — com separação por camadas (`data`, `domain` e `presentation`) — organizei as pastas do projeto de forma a manter uma divisão clara entre responsabilidades, facilitando a manutenção e evolução do código.

# 📋 Guia para execução do Projeto

## 📋 Pré-requisitos

### 1. Instalar o FVM

Para instalar o FVM, consulte a **documentação oficial**:
📖 [Documentação Oficial do FVM](https://fvm.app/documentation/getting-started/installation)

A documentação oficial contém instruções detalhadas para:
- Windows (PowerShell, Chocolatey, Scoop, winget)
- macOS (Homebrew, pub)
- Linux (pub, snap)

### 2. Verificar a instalação
```bash
fvm --version
```

## 🚀 Configuração do Projeto

### 1. Navegar para o diretório do projeto
```bash
cd financas_pessoais-main
```

### 2. Configurar a versão do Flutter para o projeto
O projeto requer Flutter SDK ^3.8.0. Vamos configurar uma versão compatível:

```bash
# Listar versões disponíveis do Flutter
fvm releases

# Instalar e configurar Flutter 3.19.0 (versão estável compatível)
fvm install 3.19.0
fvm use 3.19.0
```

### 3. Verificar a configuração
```bash
# Verificar qual versão está sendo usada
fvm flutter --version

# Verificar se o projeto está configurado corretamente
fvm flutter doctor
```
## 📱 Executando o App

### 1. Obter dependências
```bash
# Usando FVM para executar flutter pub get
fvm flutter pub get
```
#### Para Android:
```bash
# Verificar dispositivos conectados
fvm flutter devices

# Executar no emulador/dispositivo Android
fvm flutter run
```
#### Para iOS (apenas macOS):
```bash
# Executar no simulador/dispositivo iOS
fvm flutter run
```
#### Para Web:
```bash
# Executar no navegador
fvm flutter run -d chrome
```
