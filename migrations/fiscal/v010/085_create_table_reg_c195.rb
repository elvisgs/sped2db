Sequel.migration do
  change do
    create_table :reg_c195 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_obs, String, size: 6
      column :txt_compl, String, size: 1000
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
