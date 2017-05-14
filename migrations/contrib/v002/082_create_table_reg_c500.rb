Sequel.migration do
  change do
    create_table :reg_c500 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_part, String, size: 60
      column :cod_mod, String, size: 2
      column :cod_sit, String, size: 2
      column :ser, String, size: 4
      column :sub, String, size: 3
      column :num_doc, String, size: 60
      column :dt_doc, Date
      column :dt_e_s, Date
      column :vl_doc, BigDecimal, size: [18, 2]
      column :vl_icms, BigDecimal, size: [18, 2]
      column :cod_inf, String, size: 6
      column :vl_pis, BigDecimal, size: [18, 2]
      column :vl_cofins, BigDecimal, size: [18, 2]
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
