Sequel.migration do
  change do
    create_table :reg_1500 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :ind_oper, String, size: 1
      column :ind_emit, String, size: 1
      column :cod_part, String, size: 60
      column :cod_mod, String, size: 2
      column :cod_sit, String, size: 2
      column :ser, String, size: 4
      column :sub, String, size: 3
      column :cod_cons, String, size: 2
      column :num_doc, String, size: 9
      column :dt_doc, Date
      column :dt_e_s, Date
      column :vl_doc, BigDecimal, size: [18, 2]
      column :vl_desc, BigDecimal, size: [18, 2]
      column :vl_forn, BigDecimal, size: [18, 2]
      column :vl_serv_nt, BigDecimal, size: [18, 2]
      column :vl_terc, BigDecimal, size: [18, 2]
      column :vl_da, BigDecimal, size: [18, 2]
      column :vl_bc_icms, BigDecimal, size: [18, 2]
      column :vl_icms, BigDecimal, size: [18, 2]
      column :vl_bc_icms_st, BigDecimal, size: [18, 2]
      column :vl_icms_st, BigDecimal, size: [18, 2]
      column :cod_inf, String, size: 6
      column :vl_pis, BigDecimal, size: [18, 2]
      column :vl_cofis, BigDecimal, size: [18, 2]
      column :tp_ligacao, String, size: 1
      column :cod_grupo_tensao, String, size: 2
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
