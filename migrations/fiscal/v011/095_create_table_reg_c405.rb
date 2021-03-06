Sequel.migration do
  change do
    create_table :reg_c405 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :dt_doc, Date
      column :cro, String, size: 3
      column :crz, String, size: 6
      column :num_coo_fin, String, size: 9
      column :gt_fin, BigDecimal, size: [18, 2]
      column :vl_brt, BigDecimal, size: [18, 2]
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
