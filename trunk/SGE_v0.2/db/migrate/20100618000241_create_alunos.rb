class CreateAlunos < ActiveRecord::Migration
  def self.up
    create_table :alunos do |t|
      t.string :nome
      t.string :matricula
      t.integer :cpf
      t.string :identidade
      t.string :cert_nascimento
      t.string :sexo
      t.string :estado_civil
      t.string :nacionalidade
      t.string :nome_pai
      t.string :nome_mae
      t.string :nome_responsavel
      t.integer :cep
      t.string :endereco
      t.string :complemento
      t.string :bairro
      t.string :cidade
      t.string :uf, :limit => 2
      t.string :tel_residencial
      t.string :tel_celular
      t.string :email
      t.text :historico_medico
      t.string :historico_escolar
      t.string :profissao
      t.string :cert_militar
      t.string :foto_nome
      t.string :foto_content_type
      t.binary :foto_bin_data

      t.timestamps
    end
  end

  def self.down
    drop_table :alunos
  end
end
