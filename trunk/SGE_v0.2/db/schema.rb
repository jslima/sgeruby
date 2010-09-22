# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100708222714) do

  create_table "alunos", :force => true do |t|
    t.string   "nome"
    t.integer  "cpf"
    t.string   "identidade"
    t.string   "cert_nascimento"
    t.string   "sexo"
    t.string   "estado_civil"
    t.string   "nacionalidade"
    t.string   "nome_pai"
    t.string   "nome_mae"
    t.string   "nome_responsavel"
    t.integer  "cep"
    t.string   "endereco"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "uf",                :limit => 2
    t.string   "tel_residencial"
    t.string   "tel_celular"
    t.string   "email"
    t.text     "historico_medico"
    t.string   "historico_escolar"
    t.string   "profissao"
    t.string   "cert_militar"
    t.string   "foto_nome"
    t.string   "foto_content_type"
    t.binary   "foto_bin_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cursos", :force => true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.string   "ementa"
    t.string   "coordenador"
    t.string   "turno"
    t.integer  "duracao"
    t.integer  "total_horas"
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matriculas", :force => true do |t|
    t.string   "matricula"
    t.integer  "aluno_id"
    t.integer  "turma_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turmas", :force => true do |t|
    t.string   "nome"
    t.string   "ano"
    t.integer  "max_alunos"
    t.integer  "curso_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
