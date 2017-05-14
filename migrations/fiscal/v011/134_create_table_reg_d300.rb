Sequel.migration do
  change do
    create_table :reg_d300 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_mod, String, size: 2
      column :ser, String, size: 4
      column :sub, String, size: 4
      column :num_doc_ini, String, size: 6
      column :num_doc_fin, Integer
      column :cst_icms, String, size: 3
      column :cfop, String, size: 4
      column :aliq_icms, BigDecimal, size: [18, 2]
      column :dt_doc, Date
      column :vl_opr, BigDecimal, size: [18, 2]
      column :vl_desc, BigDecimal, size: [18, 2]
      column :vl_serv, BigDecimal, size: [18, 2]
      column :vl_seg, BigDecimal, size: [18, 2]
      column :vl_out_desp, BigDecimal, size: [18, 2]
      column :vl_bc_icms, BigDecimal, size: [18, 2]
      column :vl_icms, BigDecimal, size: [18, 2]
      column :vl_red_bc, BigDecimal, size: [18, 2]
      column :cod_obs, String, size: 6
      column :cod_cta, String, size: 1000
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
