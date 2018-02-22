import py_entitymatching as em
df = em.read_csv_metadata('matched_tuples.csv', key = '_id')
# aom = em.read_csv_metadata(path_to_csv_dir + '_aom.csv', key = 'person_id')
# whed = em.read_csv_metadata(path_to_csv_dir + '_whed.csv', key = 'a_id')
# df.head()

#use rename_col() to rename columns
#use drop_cols() to drop merged colums
# modify df to get the final results
drop_list = ['rtable_a_name','rtable_a_city','rtable_a_prov','rtable_a_country','rtable_a_email_server']
df = em.drop_cols(df, drop_list)

df = em.rename_col(df,'ltable_a_id','a_id')
df = em.rename_col(df,'ltable_a_name','a_name')
df = em.rename_col(df,'ltable_a_city','a_city')
df = em.rename_col(df,'ltable_a_prov','a_prov')
df = em.rename_col(df,'ltable_a_country','a_country')
df = em.rename_col(df,'ltable_a_web','a_web')
df = em.rename_col(df,'rtable_person_id','person_id')


# only one tuple in WHED should be matched to one tuple in aom.
df_new = df.drop_duplicates(subset=['person_id'], keep = False)
em.set_key(df_new,'person_id')
df_new = em.drop_cols(df_new,'_id')
df_new.head(n = 5)
df_new.to_csv('merged_tuples.csv', index=False)