Sequel.migration do
  change do
    create_table :reg_1210 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :tipo_util, String, size: 4
      column :nr_doc, String, size: 1000
      column :vl_cred_util, BigDecimal, size: [18, 2]
      column :chv_doce, String, size: 44
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
