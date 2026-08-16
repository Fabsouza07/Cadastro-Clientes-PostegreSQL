# Sistema Cadastro Clientes — PostgreSQL

Projeto local e educacional em Java 25, Maven e JDBC.

## Preparação
1. Execute `sql/criar_banco.sql` conectado ao banco padrão `postgres`.
2. Conecte-se ao banco `cadastro_clientes` e execute `sql/criar_tabelas.sql`.
3. Edite `src/main/resources/config.properties` com usuário e senha locais. Se preferir
   variáveis de ambiente, use `CADASTRO_CLIENTES_POSTGRESQL_URL`,
   `CADASTRO_CLIENTES_POSTGRESQL_USUARIO` e `CADASTRO_CLIENTES_POSTGRESQL_SENHA`.
4. No terminal da pasta, execute: `mvn clean compile exec:java`.

Seu JDK 26 pode compilar o projeto porque o Maven usa `release 25`.

## Acesso ao sistema
No primeiro acesso, informe um login e uma senha de pelo menos 8 caracteres. Esse primeiro usuário é
criado como **administrador**. Pela opção **Usuários**, o administrador pode criar e excluir operadores
e alterar senhas. Operadores podem usar o cadastro de clientes, mas não gerenciam usuários nem exportam CSV.
Os usuários desta aplicação ficam na tabela `usuarios_cadastro_clientes`, separada de outros sistemas
que usam o mesmo banco.
Após três tentativas de senha incorretas, o login é bloqueado por 10 minutos. A contagem e o tempo de
bloqueio usam o relógio do PostgreSQL, não o relógio do computador que executa a aplicação.

## Recursos
CRUD completo, autenticação de usuários, confirmação de alteração/exclusão/saída, pesquisa, ordenação,
estatísticas, exportação CSV para administradores e validações.
