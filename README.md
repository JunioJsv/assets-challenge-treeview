# 📦 Assets Challenge

Este é o desafio técnico proposto para a vaga de Mobile Software Engineer, que consiste na construção de uma árvore interativa de **localizações, ativos e componentes** para visualização dos sensores de uma empresa industrial.

📄 Enunciado oficial: [github.com/tractian/challenges](https://github.com/tractian/challenges/tree/main/mobile#readme)

---

## 🧩 Funcionalidades

- Visualização hierárquica em forma de árvore com:
  - Localizações e sub-localizações
  - Ativos e sub-ativos
  - Componentes com sensores
- Filtros combináveis por:
  - Nome
  - Tipo de sensor (`energy` ou `vibration`)
  - Status do sensor (`operating`, `alert`)
- Exclusão automática de ramos **sem componentes** após aplicação de filtros
- Scroll horizontal nas linhas com excesso de conteúdo
- Ícones personalizados por tipo de nó (local, ativo, componente)
- Interface responsiva, com identação clara de níveis hierárquicos

---

## 📱 Demonstração

![](https://github.com/JunioJsv/juniojsv-bucket/blob/main/assets_challenge.jpg?raw=true)

📺 Assista à demonstração do app: [YouTube](https://youtu.be/xgFU9Uzm7LI)

---

## 📁 Estrutura da Árvore

A árvore foi implementada com o uso de `ListView.builder` e `ExpansionTile` recursivos através dos widgets:

- `CompanyAssetsTreeView` → recebe a lista de nós e instancia a lista vertical.
- `CompanyAssetTreeNodeTile` → representa cada nó, com identação e expansão.
  
A cada nível expandido, um novo `ListView` é criado para os filhos, com margem proporcional ao nível hierárquico.

---

## 🚀 Como rodar

Este projeto utiliza Flutter. Para rodar localmente:

```bash
flutter pub get
dart run build_runner build
flutter run
```

---

## 🔎 O que eu faria com mais tempo

- Utilizaria **isolates (multithreading)** para realizar a filtragem da árvore em paralelo, melhorando a performance perceptível em cenários com grandes volumes de dados.
- Refatoraria os widgets responsáveis pela exibição da árvore para que sejam **independentes do domínio específico de ativos**, permitindo reutilizá-los em outras áreas da aplicação.
- Melhoraria o **feedback ao usuário**, com mensagens de erro mais claras e amigáveis.
- Adicionaria **transições visuais suaves** entre os estados de carregamento, sucesso e erro, proporcionando uma experiência de uso mais fluida.

---

## 🔗 API e dados

Todos os dados são consumidos via `GET` da API fake:

* `/companies`
* `/companies/:companyId/locations`
* `/companies/:companyId/assets`
