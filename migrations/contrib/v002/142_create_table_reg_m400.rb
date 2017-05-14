Sequel.migration do
  change do
    create_table :reg_m400 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :cst_pis, String, size: 2
      column :vl_tot_rec, BigDecimal, size: [18, 2]
      column :cod_cta, String, size: 60
      column :desc_compl, String, size: 1000
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
