Sequel.migration do
  change do
    create_table :reg_c105 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :oper, String, size: 1
      column :cod_uf, String, size: 2
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
