# Homework 4: Adicionar novas features para a aplicação RottenPotatoes com o ciclo Behavior-Driven Design (BDD) e Test-Driven Development (TDD) fazendo uso das ferramentas Cucumber e RSpec 

**Aluna:** Caroline Bohadana Rodrigues Viana

**Matrícula:** 232050975

A aplicação foi construída com o uso do framework **Ruby (3.4.6) on Rails (8.0.2.1)**, seguindo as orientações apresentadas na especificação do **Homework 4 (BDD+TDD Cycle)**.

---
### Instalação e Execução da Aplicação

**Pré-requisitos:**
- Git
- Ruby
- Bundler (`gem install bundler`)
- Ruby on Rails (`gem install rails`)

1. **Clonar o Repositório:** execute o comando abaixo no terminal para baixar o código do GitHub:
```bash
git clone https://github.com/CarolB57/HW4.git
```

2. **Entrar no Diretório do Projeto:**
```bash
cd HW4
```

3. **Instalar as Dependências:** o Bundler irá ler o arquivo `Gemfile` e instalar todas as bibliotecas (gems) que o projeto necessita.
```bash
bundle install --without production
```

4. **Configuração do banco de dados:**  O comando a seguir irá apagar qualquer banco de dados existente, criar um novo, rodar todas as migrações e popular o banco com os dados do arquivo `db/seeds.rb`.
```bash
bundle exec rake db:reset
```

5. **Iniciar o Servidor:** o comando abaixo inicia o servidor web local do Rails.
```bash
bundle exec rails server
```

6. **Acessar a Aplicação:** no navegador, entre no link abaixo:
```bash
http://localhost:3000
```

7. **Execução dos testes:** Este projeto usa dois frameworks de teste: RSpec (TDD) e Cucumber (BDD).

- O comando a seguir testa a lógica interna dos `models` e `controllers`. 
```bash
bundle exec rake spec
```

 - O comando abaixo simula um usuário clicando no site para testar as *features*.
```bash
bundle exec cucumber
```

8. **Gerar o Relatório de Cobertura (SimpleCov):** Para gerar o relatório de cobertura, execute **ambas** as suítes de teste, uma após a outra, com os seguintes comandos:
```bash
bundle exec rake spec
bundle exec cucumber
```

Por fim, abra o arquivo `coverage/index.html` no seu navegador para ver os resultados detalhados e a porcentagem de cobertura de cada arquivo.
