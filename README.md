# App de Listagem de Personagens Marvel

### Trabalho PM-II - CONCEITOS BÁSICOS DE PROGRAMAÇÃO EM FLUTTER - UTFPR
## Professor Ricardo da Silva Ogliari

```
● Desenvolvimento de uma aplicação com o uso dos conceitos vistos em aula. Pontuação:
  ○ 1 Stateless e Stateful
  ○ 1 Uso de alguma Widget não vista em aula
  ○ 1 Persistência
  ○ 1 Retrofit
  ○ 1 Testes com cobertura de no mínimo 10%
  ○ 1 Gerência de estados
  ○ 1 Platform channel
  ○ 1 Mínimo de usabilidade
  ○ 1 Temas
  ○ 1 Github e Vídeo demonstrativo
```
## 


Este projeto implementa uma aplicação de listagem de personagens da Marvel, com funcionalidades de scroll infinito e exibição de detalhes, seguindo os princípios de Clean Dart. A aplicação utiliza uma arquitetura modular, promovendo manutenibilidade e escalabilidade.

Funcionalidades Principais

    •	Listagem de personagens da Marvel com scroll infinito.
    •	Detalhes de personagens com descrição e atributos relevantes.
    •	Arquitetura baseada no Clean Dart para separação de responsabilidades.

Estrutura do Projeto

A organização do projeto segue os princípios de Clean Architecture adaptados para Flutter, com divisão em camadas e módulos:

```
lib/
├── app/
│ ├── core/
│ │ ├── api/ # Comunicação com APIs
│ │ ├── di/ # Configuração de injeção de dependências
│ │ ├── env/ # Gerenciamento de variáveis de ambiente
│ │ ├── error/ # Tratamento de erros globais
│ │ ├── navigator/ # Navegação global
│ │ ├── routes/ # Definição de rotas
│ │ ├── services/ # Serviços reutilizáveis
│ │ ├── theme/ # Estilização e temas
│ ├── features/
│ ├── characters/ # Funcionalidades relacionadas a personagens
│ ├── data/ # Camada de dados (DTOs, fontes, repositórios)
│ ├── domain/ # Regras de negócios (Casos de uso e entidades)
│ ├── infra/ # Comunicação com API
│ ├── presenter/ # UI e estados
```

    •	Core: Contém as dependências e funcionalidades globais do projeto.
    •	Features: Implementa módulos independentes, como o de personagens.
    •	Data Layer: Repositórios e fontes de dados (ex.: API).
    •	Domain Layer: Casos de uso e entidades principais.
    •	Presenter Layer: Interface do usuário e lógica de apresentação.

Configuração de Variáveis de Ambiente

Este projeto utiliza variáveis de ambiente para configurar a API e credenciais de acesso da Marvel.

1. Criando o Arquivo .env

O arquivo .env deve ser criado na raiz do projeto (mesmo nível de pubspec.yaml), com os seguintes valores:
```env
API_URL=https://gateway.marvel.com/v1/public/
API_KEY=PUBLIC_KEY_MARVEL
API_SECRET=PRIVATE_KEY_MARVEL
```

Substitua PUBLIC_KEY_MARVEL e PRIVATE_KEY_MARVEL pelas chaves pública e privada da sua conta da Marvel.

2. Configurando o Projeto

Passo 1: Instale as dependências

Na raiz do projeto, execute:

flutter pub get

Passo 2: Configure o arquivo .env

    •	Crie o arquivo .env na raiz do projeto.
    •	Preencha com as credenciais da API da Marvel conforme o exemplo acima.

Passo 3: Execute o projeto

Inicie a aplicação no seu dispositivo ou emulador com o comando:

flutter run --dart-define-from-file .env

## Como Funciona a API da Marvel

A aplicação utiliza a [API oficial da Marvel](https://developer.marvel.com/) para listar personagens. O endpoint base configurado no .env é:

```
https://gateway.marvel.com/v1/public/characters
```

### Autenticação

A autenticação na API exige:
• apikey: Chave pública.
• ts: Um timestamp (necessário para validação do hash).
• hash: Um hash MD5 gerado no formato:

hash = md5(ts + PRIVATE_KEY + PUBLIC_KEY)

Este processo é gerenciado automaticamente no código, dentro da camada de infraestrutura (infra), ao realizar chamadas para a API.

### Demonstração do App
Vídeo da demonstração do aplicativo:

[APP - Apresentação Disciplina Flutter - Programação para dispositivos móveis UTFPR](https://www.youtube.com/watch?v=1WNnf4qT1eA)

Apresentação do Código e Arquitetura:

[CODE - Apresentação Disciplina Flutter - Programação para dispositivos móveis UTFPR](https://www.youtube.com/watch?v=L_9gka468nA)
