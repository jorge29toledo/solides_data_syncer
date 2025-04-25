# SolidesDataSyncer

Uma gem Ruby para sincronização de dados com o MongoDB Atlas.

## ✨ Funcionalidades

- Conexão segura com o MongoDB Atlas
- Inserção e atualização de usuários
- Listagem de usuários em ordem decrescente de criação
- Fallback seguro: falhas na conexão com MongoDB não quebram sua aplicação

## 🚀 Instalação

Adicione esta linha ao seu Gemfile:

```ruby
gem 'solides_data_syncer', git: 'https://github.com/jorge29toledo/solides_data_syncer.git'
```

E depois execute:

```sh
bundle install
```

Ou instale manualmente:

```sh
gem install solids_data_syncer-0.1.0.gem
```

## 🔧 Configuração

Crie um arquivo `.env` na raiz do seu projeto com sua URI do MongoDB Atlas:

```env
MONGO_DB_NAME=db_name
MONGO_COLLECTION_NAME=collection_name
MONGODB_URI=mongodb+srv://<usuario>:<senha>@<host>/<dbname>?retryWrites=true&w=majority
```

Ou defina diretamente no ambiente:

```sh
export MONGODB_URI='mongodb+srv://<usuario>:<senha>@<host>/<dbname>?retryWrites=true&w=majority'
```
## ✅ Tratamento de erros

Se a conexão com o MongoDB falhar, a gem imprimirá um aviso no log e continuará a execução do programa sem interromper sua aplicação:

```sh
⚠️  Conexão com MongoDB não estabelecida. Operações serão ignoradas.
```

## 🧪 Exemplo de uso

## 🧰 Uso com Ruby

```ruby
require 'dotenv/load'
require_relative 'lib/solides_data_syncer'

syncer = SolidesDataSyncer::Syncer.new(
  db_name: "#{ENV["MONGO_DB_NAME"]}",
  collection_name: "#{ENV["MONGO_COLLECTION_NAME"]}"
)

# Inserir ou atualizar usuário
if syncer.connected?
  syncer.add_or_update_user(
    name: "Huguinho Silva",
    email: "huguinhosilva@gameofthron.es",
    password: "$xpto"
  )

  syncer.find_users(limit: 2)
else
  puts "❌ Sem conexão com o MongoDB"
end
```

## 🧰 Uso com Ruby on Rails

Se você estiver usando a gem `solides_data_syncer` dentro de um projeto **Rails**, é possível configurar um helper para facilitar a reutilização da conexão com o MongoDB.

### 1. Adicione variáveis de ambiente no seu projeto Rails

No `.env`:

```env
MONGODB_URI=mongodb+srv://<seu_usuario>:<sua_senha>@<seu_cluster>.mongodb.net/
MONGO_DB_NAME=db_name
MONGO_COLLECTION_NAME=collection_name
```

### 2. Crie um initializer

Em `config/initializers/solides_data_syncer.rb`:

```ruby
if defined?(Rails)
  SolidesDataSyncer::RailsHelper.syncer
end
```

### 3. Use em models ou controllers

```ruby
SolidesDataSyncer::RailsHelper.syncer.add_or_update_user(
  name: "Arya Stark",
  email: "arya@winterfell.north",
  password: "valarMorghulis"
)
```

> ⚠️ **Importante**: O helper `RailsHelper` é carregado apenas quando o ambiente Rails é detectado (`defined?(Rails)`), então o uso da gem em scripts Ruby puros continua funcionando normalmente.

## 🧰 Desenvolvimento

Para contribuir:

```sh
git clone https://github.com/jorge29toledo/solides_data_syncer.git
cd solides_data_syncer
bundle install
```

## 📄 Licença

MIT © [jorge29toledo](https://github.com/jorge29toledo)

