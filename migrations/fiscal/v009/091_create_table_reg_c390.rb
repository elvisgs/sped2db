Sequel.migration do
  change do
    create_table :reg_c390 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cst_icms, String, size: 3
      column :cfop, String, size: 4
      column :aliq_icms, BigDecimal, size: [18, 2]
      column :vl_opr, BigDecimal, size: [18, 2]
      column :vl_bc_icms, BigDecimal, size: [18, 2]
      column :vl_icms, BigDecimal, size: [18, 2]
      column :vl_red_bc, BigDecimal, size: [18, 2]
      column :cod_obs, String, size: 6
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
