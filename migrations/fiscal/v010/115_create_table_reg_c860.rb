Sequel.migration do
  change do
    create_table :reg_c860 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_mod, String, size: 2
      column :nr_sat, String, size: 9
      column :dt_doc, Date
      column :doc_ini, String, size: 6
      column :doc_fim, String, size: 6
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
