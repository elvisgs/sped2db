Sequel.migration do
  change do
    create_table :reg_9999 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true
      column :qtd_lin, Integer
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
