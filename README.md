# Sped2db

Importa registros de arquivos no formato [SPED](http://sped.rfb.gov.br) fiscal/contribuições e salva em um Banco de Dados

## Instalação

O sped2db usa o [Sequel](https://github.com/jeremyevans/sequel) para acesso ao banco de dados. Para tanto, é necessário instalar também o driver ruby adequado. 


```
$ gem install sped2db
$ gem install <driver do seu BD>
```

Sendo que driver pode ser `sqlite3`, `pg`, `mysql2`, etc.

## Uso

```
$ sped2db [opções] <caminho sped>
Opções:
    -c, --config             Arquivo de configuração ou URI de conexão (default: ./sped2db.yml)
    -n, --dbname             Nome do BD (sobrescreve config)
    -u, --user               Nome do usuário do BD (sobrescreve config)
    -p, --passwd             Senha do usuário (sobrescreve config)
    -e, --continue-on-error  Continua se encontrar erro (default: false)
    -v, --version
    -h, --help
```

O caminho SPED pode ser um único arquivo ou um diretório contendo arquivos SPED.

## Exemplos

1. Usa configurações de conexão do `sped2db.yml` (se existir) no diretório atual e carrega arquivo `~/sped.txt` no BD teste:
```
$ sped2db -n teste ~/sped.txt
```

2. Usa configurações de conexão contidas em `~/database.yml` com usuário john, senha 123 e carrega arquivo `~/sped.txt`:
```
$ sped2db -c ~/database.yml -u john -p 123 ~/sped.txt
```

3. Usa URI de conexão e carrega todos os arquivos SPED do diretório `~/sped-files/`, mesmo se algum tiver erros:
```
$ sped2db -c postgres://localhost/teste -e ~/sped-files/
```

Um arquivo de configuração tem o seguinte formato:
```yaml
adapter: postgres
host: localhost
port: 5432
user: myUser
password: myPassword
database: sped
```
Para mais detalhes sobre configuração e strings de conexão, consulte a [documentação](https://github.com/jeremyevans/sequel/blob/master/doc/opening_databases.rdoc) do Sequel.

## Desenvolvimento

Depois de clonar o repo, execute `bundle install` para instalar as dependências, então execute `rake spec` para rodar os testes. Execute `bundle exec sped2db` para usar a gem neste diretório, ignorando outras cópias desta gem instaladas.

Para instalar esta gem na sua máquina local, execute `bundle exec rake install`. Para fazer o release de uma nova versão, atualize o número de versão em `version.rb` e então execute `bundle exec rake release`, que criará uma tag git para a versão, fará push no git dos commits e tags e mandará o `.gem` para [rubygems.org](https://rubygems.org).

## Licença

Esta gem está disponível como open source sob os termos da [MIT License](http://opensource.org/licenses/MIT).

