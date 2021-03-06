Sequel.migration do
  change do
    create_table :reg_0100 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :nome, String, size: 60
      column :cpf, String, size: 11
      column :crc, String, size: 15
      column :cnpj, String, size: 14
      column :cep, String, size: 8
      column :endereco, String, size: 60
      column :num, String, size: 10
      column :compl, String, size: 60
      column :bairro, String, size: 60
      column :fone, String, size: 11
      column :fax, String, size: 11
      column :email, String, size: 60
      column :cod_mun, String, size: 7
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
