# SolidesDataSyncer

🌟 Gem para sincronização de dados com uma base MongoDB do Projeto SolidesDataSyncer, feita para ser usada em projetos Ruby ou Ruby on Rails.

---

## 📦 Instalação

Adicione esta linha ao seu `Gemfile`:

```ruby
gem 'solides_data_syncer', github: 'jorge29toledo/solides_data_syncer', tag: 'v0.1.0'
```

Depois execute:

```bash
bundle install
```

---

## ⚙️ Configuração

Esta gem usa a URI do MongoDB a partir da variável de ambiente `MONGODB_URI`.

Crie um arquivo `.env` na raiz do seu projeto Rails (ou Ruby puro):

```env
MONGODB_URI=mongodb+srv://usuario:senha@host.mongodb.net
```

> Recomendado: copie o exemplo `cp .env.example .env`

Use `dotenv-rails` (no Rails) para carregar o `.env` automaticamente:

```ruby
# Gemfile
gem 'dotenv-rails', groups: [:development, :test]
```

---

## 🚀 Uso

```ruby
require 'solides_data_syncer'

syncer = SolidesDataSyncer::Syncer.new(
  db_name: 'sample_mflix',
  collection_name: 'users'
)

if syncer.connected?
  users = syncer.find_users(limit: 10)
  puts users
else
  puts "❌ Não conectado ao MongoDB"
end
```

---

## 💠 Funcionalidades

- ✅ Conecta com MongoDB Atlas
- ✅ Consulta documentos
- ✅ Insere e atualiza usuários (com upsert)
- ✅ Ordenação por criação (`created_at`)
- ✅ Validação automática da URI
- ✅ Preparado para Rails 4 até 8+

---

## 📂 Estrutura da gem

```text
lib/
└── solides_data_syncer/
    ├── mongo_client.rb      # Conexão com MongoDB
    ├── syncer.rb            # Interface principal
    ├── errors.rb            # Erros customizados
    └── version.rb           # Versão da gem
```

---

## 📁 Licença

MIT © [Jorge Toledo](https://github.com/jorge29toledo)

---

