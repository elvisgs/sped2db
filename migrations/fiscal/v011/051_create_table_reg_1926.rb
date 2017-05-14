Sequel.migration do
  change do
    create_table :reg_1926 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cod_or, String, size: 3
      column :vl_or, BigDecimal, size: [18, 2]
      column :dt_vcto, Date
      column :cod_rec, String, size: 1000
      column :num_proc, String, size: 15
      column :ind_proc, BigDecimal, size: [18, 2]
      column :proc, String, size: 1000
      column :txt_compl, String, size: 1000
      column :mes_ref, String, size: 6
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
