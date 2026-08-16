package br.com.cadastro.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class Conexao {

  private Conexao() {}

  public static Connection abrir() throws SQLException {
    String url = Config.get("cadastro_clientes.postgresql.url");
    String usuario = Config.get("cadastro_clientes.postgresql.usuario");
    String senha = Config.get("cadastro_clientes.postgresql.senha");

    if (usuario == null || usuario.isBlank()) {
      return DriverManager.getConnection(url);
    }

    return DriverManager.getConnection(url, usuario, senha);
  }

  public static void testar() throws SQLException {
    try (Connection conexao = abrir()) {
      if (!conexao.isValid(5)) {
        throw new SQLException("A conexão foi aberta, mas não foi validada.");
      }
    }
  }
}
