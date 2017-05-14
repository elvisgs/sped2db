Sequel.migration do
  change do
    create_table :reg_k235 do
      column :id, Integer, primary_key: true
      column :id_pai, Integer, index: true, null: false
      column :dt_saida, Date
      column :cod_item, String, size: 60
      column :qtd, BigDecimal, size: [18, 3]
      column :cod_ins_subst, String, size: 1000
      column :cnpj_pai, String, size: 14, index: true
    end
  end
end
