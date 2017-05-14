Sequel.migration do
  change do
    create_table :reg_d605 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_class, String, size: 4
      column :vl_item, BigDecimal, size: [18, 2]
      column :vl_desc, BigDecimal, size: [18, 2]
      column :cst_cofins, String, size: 2
      column :vl_bc_cofins, BigDecimal, size: [18, 2]
      column :aliq_cofins, BigDecimal, size: [18, 4]
      column :vl_cofins, BigDecimal, size: [18, 2]
      column :cod_cta, String, size: 60
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
