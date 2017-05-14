Sequel.migration do
  change do
    create_table :reg_h990 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :qtd_lin_h, Integer
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
